local null_ls = require('null-ls')

local action = null_ls.builtins.code_actions
local comp = null_ls.builtins.completion
local diag = null_ls.builtins.diagnostics
local format = null_ls.builtins.formatting
local hover = null_ls.builtins.hover

-- Buily in sources: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup({
    debug = false,
    border = 'rounded',
    log_level = 'info',
    diagnostics_format = '#{c} #{m} (#{s})',
    sources = {
        -- Formatters are now handled by conform.nvim
        -- action.proselint, -- Disabled: deprecated pkg_resources warnings
        action.refactoring,
        -- action.ts_node_action, -- treesitter node actions, buggy, causes repeated notifications
        comp.spell, -- spell completion
        comp.tags, -- tags completion
        diag.actionlint, -- github action lint
        diag.credo, -- elixir diagnostics
        diag.golangci_lint,
        diag.hadolint, -- docker lint
        -- diag.proselint, -- Disabled: deprecated pkg_resources warnings
        diag.reek, -- ruby code smell
        -- diag.rubocop, -- ruby diagnostics
        -- diag.todo_comments, -- causes highlighter errors on J
        diag.trail_space, -- trailing space check
        diag.vint, -- vim lint
        diag.write_good, -- english writing style (alternative to proselint)
        hover.dictionary, -- show word dictionary on hover
        hover.printenv, -- show env on hover
    },
})

-- Use ensure_installed list instead of automatic_installation to avoid conflicts
-- automatic_installation tries to install packages while ensure_installed is also installing them
local installed_sources = require('plugins.list').null_ls_sources

require('mason-null-ls').setup({
    ensure_installed = installed_sources,
    automatic_installation = false,  -- Disabled to prevent duplicate installation attempts
})
