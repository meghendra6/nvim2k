require('core.options')
require('core.lsp-compat')  -- Load LSP compatibility shim early
require('core.functions')
require('core.keys')
require('core.autocmd')
require('plugins.lazy')
-- Add user configs to this module
pcall(require, 'user')
vim.opt.shadafile = vim.fn.stdpath('data') .. '/shada/main.shada'
