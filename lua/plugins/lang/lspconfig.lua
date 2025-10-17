local lspconfig = require('lspconfig')
local icons = require('lib.icons').diagnostics

local auto_install = require('lib.util').get_user_config('auto_install', true)
local installed_servers = {}
if auto_install then
    installed_servers = require('plugins.list').lsp_servers
end

local default_setup = function(server)
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    
    -- Disable documentColor capability to prevent unsupported requests
    if capabilities.textDocument and capabilities.textDocument.colorProvider then
        capabilities.textDocument.colorProvider = nil
    end
    
    -- Set preferred offset encoding to utf-16 for consistency across all LSP servers
    -- This prevents "multiple different client offset_encodings detected" warnings
    capabilities.offsetEncoding = { 'utf-16' }
    
    lspconfig[server].setup({
        capabilities = capabilities,
    })
end

local signs = { Error = icons.Error, Warn = icons.Warning, Hint = icons.Hint, Info = icons.Information }
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.INFO] = signs.Info,
            [vim.diagnostic.severity.HINT] = signs.Hint,
        },
    },
})

require('mason-lspconfig').setup({
    ensure_installed = installed_servers,
    handlers = {
        default_setup,
        lua_ls = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            if capabilities.textDocument and capabilities.textDocument.colorProvider then
                capabilities.textDocument.colorProvider = nil
            end
            capabilities.offsetEncoding = { 'utf-16' }
            
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                        telemetry = { enable = false },
                        format = {
                            enable = true,
                            defaultConfig = {
                                align_continuous_assign_statement = false,
                                align_continuous_rect_table_field = false,
                                align_array_table = false,
                            },
                        },
                    },
                },
            })
        end,
        -- Python LSP: pyright (빠르고 강력한 타입 체킹)
        pyright = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            if capabilities.textDocument and capabilities.textDocument.colorProvider then
                capabilities.textDocument.colorProvider = nil
            end
            capabilities.offsetEncoding = { 'utf-16' }
            
            lspconfig.pyright.setup({
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = "basic"  -- "off", "basic", "strict"
                        }
                    }
                },
            })
        end,
        -- Ruff는 linting/formatting만 담당
        ruff = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            if capabilities.textDocument and capabilities.textDocument.colorProvider then
                capabilities.textDocument.colorProvider = nil
            end
            -- Ruff uses utf-8 by default (hardcoded), but we request utf-16 preference
            capabilities.offsetEncoding = { 'utf-16', 'utf-8' }
            
            lspconfig.ruff.setup({
                capabilities = capabilities,
                init_options = {
                    settings = {
                        args = {},
                    },
                },
            })
        end,
    },
})

-- Performance: Disable LSP for large files
vim.api.nvim_create_autocmd('BufReadPre', {
    callback = function(args)
        local buf = args.buf
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        
        if ok and stats and stats.size > 1024 * 1024 then -- 1 MB
            vim.notify('Large file: LSP disabled for performance', vim.log.levels.WARN)
            vim.api.nvim_buf_set_var(buf, 'large_file', true)
            
            -- Stop LSP for this buffer
            vim.schedule(function()
                vim.lsp.stop_client(vim.lsp.get_active_clients({ bufnr = buf }))
            end)
        end
    end,
})
