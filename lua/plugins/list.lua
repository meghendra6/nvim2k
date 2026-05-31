local util = require('lib.util')

local function dropbar(action)
    return function()
        if not _G.dropbar then
            require('dropbar').setup()
        end
        require('dropbar.api')[action]()
    end
end

local function load_config(package)
    return function()
        require('plugins.' .. package)
    end
end

local plugins = {
    -- UI
    {
        'navarasu/onedark.nvim',
        config = load_config('ui.onedark'),
        lazy = false,
        priority = 1000,
    },
    { 'nvim-tree/nvim-web-devicons' },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        config = load_config('ui.snacks'),
    },
    {
        'nvim-lualine/lualine.nvim',
        config = load_config('ui.lualine'),
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'Bekaboo/dropbar.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('dropbar').setup()
        end,
        keys = {
            {
                '<leader>;',
                dropbar('pick'),
                desc = 'Pick Breadcrumb',
            },
            {
                '[;',
                dropbar('goto_context_start'),
                desc = 'Context Start',
            },
            {
                '];',
                dropbar('select_next_context'),
                desc = 'Next Context',
            },
        },
    },

    -- Language
    {
        'michaelb/sniprun',
        build = 'bash ./install.sh',
        config = load_config('lang.sniprun'),
        cmd = 'SnipRun',
    },
    {
        'ThePrimeagen/refactoring.nvim',
        config = load_config('lang.refactoring'),
    },
    {
        'echasnovski/mini.bracketed',
        config = load_config('lang.bracketed'),
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'echasnovski/mini.pairs',
        config = load_config('lang.pairs'),
        event = 'InsertEnter',
    },
    {
        'echasnovski/mini.surround',
        version = '*',
        config = load_config('lang.surround'),
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'echasnovski/mini.ai',
        version = '*',
        config = load_config('lang.ai'),
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'chrisgrieser/nvim-spider',
        config = load_config('lang.spider'),
        event = { 'BufReadPost', 'BufNewFile' },
    },

    -- Tresitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'RRethy/nvim-treesitter-textsubjects',
        },
        config = load_config('lang.treesitter'),
        event = { 'BufReadPre', 'BufNewFile' },
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'williamboman/mason-lspconfig.nvim' },
        config = load_config('lang.lspconfig'),
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
    },
    {
        'nvimdev/lspsaga.nvim',
        config = load_config('lang.lspsaga'),
        event = 'LspAttach',
    },
    {
        'williamboman/mason.nvim',
        config = load_config('lang.mason'),
        cmd = 'Mason',
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = { 'jay-babu/mason-null-ls.nvim' },
        config = load_config('lang.null-ls'),
        event = { 'BufReadPost', 'BufNewFile' },
    },

    -- Completion
    {
        'folke/ts-comments.nvim',
        opts = {},
        event = 'VeryLazy',
        enabled = vim.fn.has('nvim-0.10.0') == 1,
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '*',
        config = load_config('lang.blink'),
        opts_extend = { 'sources.default' },
        event = { 'InsertEnter' },
    },
    -- Copilot disabled for performance
    -- {
    --     'zbirenbaum/copilot.lua',
    --     dependencies = { 'giuxtaposition/blink-cmp-copilot' },
    --     config = load_config('lang.copilot'),
    --     event = 'InsertEnter',
    -- },
    {
        'olimorris/codecompanion.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        config = load_config('lang.codecompanion'),
        event = { 'BufReadPost', 'BufNewFile' },
    },

    -- Tools
    {
        'echasnovski/mini.files',
        version = '*',
        config = load_config('tools.files'),
        event = { 'BufReadPost', 'BufNewFile' },
        keys = {
            {
                '<leader>ee',
                function()
                    require('mini.files').open(util.get_file_path(), true)
                end,
                desc = 'Explorer',
            },
        },
    },
    {
        'stevearc/conform.nvim',
        config = load_config('tools.conform'),
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = { 'ConformInfo' },
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = load_config('tools.trouble'),
        cmd = 'Trouble',
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
            {
                '<leader>xt',
                '<cmd>Trouble todo toggle<cr>',
                desc = 'Todo Comments (Trouble)',
            },
        },
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = load_config('tools.todo-comments'),
        event = { 'BufReadPost', 'BufNewFile' },
        cmd = { 'TodoQuickFix', 'TodoLocList' },
        keys = {
            {
                '<leader>xT',
                '<cmd>TodoQuickFix<cr>',
                desc = 'Todo Comments (Quickfix)',
            },
        },
    },
    {
        'windwp/nvim-spectre',
        config = load_config('tools.spectre'),
        cmd = 'Spectre',
    },
    {
        'folke/flash.nvim',
        config = load_config('tools.flash'),
        keys = {
            {
                'S',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            --           {
            --               'S',
            --               mode = { 'n', 'x', 'o' },
            --               function()
            --                   require('flash').treesitter()
            --               end,
            --               desc = 'Flash Treesitter',
            --           },
        },
    },
    -- Detect indentation style per file automatically
    {
        'tpope/vim-sleuth',
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'numToStr/Navigator.nvim',
        config = load_config('tools.navigator'),
        event = 'VeryLazy',
    },
    {
        'folke/which-key.nvim',
        config = load_config('tools.which-key'),
        event = 'VeryLazy',
    },
    {
        'iamcco/markdown-preview.nvim',
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        ft = 'markdown',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview' },
        build = ':call mkdp#util#install()',
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        config = load_config('ui.render_markdown'),
    },
    {
        'uga-rosa/ccc.nvim',
        config = load_config('tools.ccc'),
        cmd = { 'CccHighlighterToggle', 'CccConvert', 'CccPick' },
    },

    -- Git
    {
        'ruifm/gitlinker.nvim',
        config = load_config('tools.gitlinker'),
        keys = '<leader>yg',
    },
    {
        'lewis6991/gitsigns.nvim',
        config = load_config('tools.gitsigns'),
        cmd = 'Gitsigns',
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
    },

    -- Homegrown :)
    {
        '2kabhishek/utils.nvim',
        cmd = 'UtilsClearCache',
    },
    {
        '2kabhishek/co-author.nvim',
        cmd = 'CoAuthor',
    },
    {
        '2kabhishek/tdo.nvim',
        cmd = { 'Tdo', 'TdoEntry', 'TdoNote', 'TdoTodos', 'TdoToggle', 'TdoFind', 'TdoFiles' },
        keys = { '[t', ']t' },
    },
    {
        '2kabhishek/markit.nvim',
        dependencies = { '2kabhishek/pickme.nvim' },
        config = load_config('tools.markit'),
        event = { 'BufReadPost', 'BufNewFile' },
    },
    -- Optional
    {
        'm4xshen/hardtime.nvim',
        dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
        cmd = 'Hardtime',
        enabled = util.get_user_config('enable_trainer', false),
    },
    {
        'kndndrj/nvim-dbee',
        dependencies = { 'MunifTanjim/nui.nvim' },
        build = function()
            --    "curl", "wget", "bitsadmin", "go"
            require('dbee').install('curl')
        end,
        config = load_config('tools.dbee'),
        cmd = 'DBToggle',
        enabled = util.get_user_config('enable_db_explorer', false),
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'mfussenegger/nvim-dap-python',
            'jay-babu/mason-nvim-dap.nvim',
        },
        config = load_config('tools.dap'),
        cmd = { 'DapUIToggle', 'DapToggleRepl', 'DapToggleBreakpoint' },
        enabled = util.get_user_config('enable_debugger', false),
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
            ensure_installed = { 'python' },
            automatic_installation = true,
        },
        enabled = util.get_user_config('enable_debugger', false),
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'olimorris/neotest-rspec',
            'nvim-neotest/neotest-jest',
            'nvim-neotest/neotest-python',
        },
        config = load_config('tools.neotest'),
        cmd = 'Neotest',
        enabled = util.get_user_config('enable_test_runner', false),
    },
    {
        'ojroques/vim-oscyank',
        event = 'VeryLazy', -- Load lazily to improve startup time
        config = function()
            vim.g.oscyank_silent = true -- 성공 메시지 비활성화

            -- TextYankPost 이벤트를 통해 OSCYank 실행
            vim.api.nvim_create_autocmd('TextYankPost', {
                callback = function()
                    if vim.v.event.operator == 'y' then
                        local reg = vim.v.event.regname
                        -- 기본 레지스터는 빈 문자열 대신 '"'로 처리
                        if reg == '' then
                            reg = '"'
                        end

                        -- OSCYank 명령 실행 (빈 레지스터 포함)
                        vim.fn.OSCYankRegister(reg)
                    end
                end,
            })
        end,
    },
}

local treesitter_parsers = {
    'bash',
    'css',
    'elixir',
    'gitcommit',
    'go',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline', -- markdown code blocks
    'python',
    'ruby',
    'rust',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
}

local null_ls_sources = {
    -- Formatters
    'stylua', -- Lua formatter
    'black', -- Python formatter
    'shfmt', -- Shell formatter
    'clang_format', -- C/C++ formatter
    'prettier', -- JS/TS/CSS/MD formatter

    -- Linters/Diagnostics
    'shellcheck', -- Shell script linter
    'actionlint', -- GitHub Actions linter
    'hadolint', -- Dockerfile linter
    -- 'proselint',  -- Disabled: deprecated pkg_resources causing errors
    'vint', -- Vim script linter
    'write_good', -- English writing linter (alternative to proselint)
    'golangci_lint', -- Go linter
}

local lsp_servers = {
    'bashls',
    'jsonls',
    'lua_ls',
    -- 'typos_lsp', -- disabled: causes -32601 errors (documentColor not supported)
    'vimls',
}

if util.is_present('npm') then
    table.insert(lsp_servers, 'eslint')
    table.insert(lsp_servers, 'ts_ls')
end

if util.is_present('gem') then
    local ror_nvim = {
        'weizheheng/ror.nvim',
        branch = 'main',
        ft = 'ruby',
        config = load_config('lang.ror'),
        keys = {
            {
                '<leader>rc',
                mode = { 'n' },
                function()
                    vim.cmd('RorCommands')
                end,
                desc = 'Rails Commands',
            },
        },
    }
    local vim_rails = {
        'tpope/vim-rails',
        ft = 'ruby',
    }

    -- table.insert(lsp_servers, 'solargraph')
    -- table.insert(lsp_servers, 'ruby_lsp')
    -- table.insert(lsp_servers, 'rubocop')
    table.insert(plugins, ror_nvim)
    table.insert(plugins, vim_rails)
end

if util.is_present('go') then
    table.insert(lsp_servers, 'gopls')
end

if util.is_present('java') then
    table.insert(lsp_servers, 'jdtls')
end

if util.is_present('pip') then
    table.insert(lsp_servers, 'ruff')
    table.insert(lsp_servers, 'pyright')
end

if util.is_present('mix') then
    table.insert(lsp_servers, 'elixirls')
end

if util.is_present('cargo') then
    table.insert(lsp_servers, 'rust_analyzer')
end

if util.is_present('clangd') then
    table.insert(lsp_servers, 'clangd')
end

local function append_items(target, items)
    if type(items) ~= 'table' then
        return
    end

    for _, item in ipairs(items) do
        table.insert(target, item)
    end
end

local function append_unique_strings(target, items)
    if type(items) ~= 'table' then
        return
    end

    local seen = {}
    for _, item in ipairs(target) do
        if type(item) == 'string' then
            seen[item] = true
        end
    end

    for _, item in ipairs(items) do
        if type(item) == 'string' and item ~= '' and not seen[item] then
            table.insert(target, item)
            seen[item] = true
        end
    end
end

append_items(plugins, util.get_user_config('user_plugins', {}))
append_unique_strings(lsp_servers, util.get_user_config('user_lsp_servers', {}))
append_unique_strings(null_ls_sources, util.get_user_config('user_null_ls_sources', {}))
append_unique_strings(treesitter_parsers, util.get_user_config('user_treesitter_parsers', {}))
append_unique_strings(treesitter_parsers, util.get_user_config('user_tresitter_parsers', {}))

return {
    plugins = plugins,
    lsp_servers = lsp_servers,
    null_ls_sources = null_ls_sources,
    ts_parsers = treesitter_parsers,
}
