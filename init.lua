-- Performance: Disable shada on startup, enable after loading
vim.opt.shadafile = "NONE"

-- Load core modules in optimized order
require('core.options')
require('core.lsp-compat')  -- Load LSP compatibility shim early
require('core.keys')        -- Keys before functions (fewer dependencies)
require('core.functions')
require('plugins.lazy')     -- Lazy load plugins

-- Re-enable shada after startup
vim.schedule(function()
    vim.opt.shadafile = vim.fn.stdpath('data') .. '/shada/main.shada'
    -- Read shada in background
    pcall(vim.cmd, 'rshada!')
end)

-- Load autocmds last (some depend on plugins)
require('core.autocmd')

-- Add user configs to this module
pcall(require, 'user')
