local icons = require('lib.icons').diagnostics

local formatter_only_servers = {
    black = true,
    clang_format = true,
    ['clang-format'] = true,
    prettier = true,
    shfmt = true,
    stylua = true,
}

local function make_capabilities(extra)
    local ok, blink = pcall(require, 'blink.cmp')
    local capabilities = ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

    -- Disable documentColor capability to prevent unsupported requests.
    if capabilities.textDocument and capabilities.textDocument.colorProvider then
        capabilities.textDocument.colorProvider = nil
    end

    -- Set preferred offset encoding to utf-16 for consistency across LSP servers.
    capabilities.offsetEncoding = { 'utf-16' }

    return vim.tbl_deep_extend('force', capabilities, extra or {})
end

local function sanitize_servers(servers)
    local result = {}
    local seen = {}

    for _, server in ipairs(servers) do
        if type(server) == 'string' and server ~= '' and not formatter_only_servers[server] and not seen[server] then
            table.insert(result, server)
            seen[server] = true
        end
    end

    return result
end

local function setup_server(server, opts)
    opts = opts or {}
    opts.capabilities = make_capabilities(opts.capabilities)
    vim.lsp.config(server, opts)
end

local auto_install = require('lib.util').get_user_config('auto_install', true)
local lsp_servers = sanitize_servers(require('plugins.list').lsp_servers)
local installed_servers = auto_install and lsp_servers or {}

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

for _, server in ipairs(lsp_servers) do
    setup_server(server)
end

setup_server('lua_ls', {
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

-- Python LSP: pyright (빠르고 강력한 타입 체킹)
setup_server('pyright', {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'basic',
            },
        },
    },
})

-- Ruff uses utf-8 by default, but we request utf-16 preference too.
setup_server('ruff', {
    capabilities = { offsetEncoding = { 'utf-16', 'utf-8' } },
    init_options = {
        settings = {
            args = {},
        },
    },
})

require('mason-lspconfig').setup({
    ensure_installed = installed_servers,
    automatic_enable = lsp_servers,
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
