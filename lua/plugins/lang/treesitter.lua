-- nvim-treesitter `main` branch (Neovim 0.12+).
-- Highlighting / folding / injections are provided by Neovim core
-- (`vim.treesitter.*`); this plugin only installs and manages parsers.

local ts = require('nvim-treesitter')
local util = require('lib.util')

local auto_install = util.get_user_config('auto_install', true)
local parsers = require('plugins.list').ts_parsers

ts.setup({})

-- Install the configured parsers (async; no-op if already installed).
if auto_install and type(parsers) == 'table' and #parsers > 0 then
    pcall(function()
        ts.install(parsers)
    end)
end

-- Languages where treesitter indentation is disabled for performance/correctness.
local no_indent = {
    python = true,
    cpp = true,
    c = true,
    rust = true,
}

local MAX_FILESIZE = 1024 * 1024 -- 1 MB
local MAX_LINES = 10000

local function start_buffer(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
        return
    end

    -- Disable for very large files (performance).
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > MAX_FILESIZE then
        return
    end
    if vim.api.nvim_buf_line_count(buf) > MAX_LINES then
        return
    end

    local ft = vim.bo[buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then
        return
    end

    -- Highlighting (core). Fails silently if the parser is not installed yet.
    if not pcall(vim.treesitter.start, buf, lang) then
        return
    end

    -- Indentation (experimental, provided by nvim-treesitter main).
    if not no_indent[ft] then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
end

local group = vim.api.nvim_create_augroup('user_treesitter', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = group,
    callback = function(args)
        start_buffer(args.buf)
    end,
})

-- Handle the buffer that triggered plugin loading (its FileType may have
-- already fired before this autocmd was registered).
vim.schedule(function()
    start_buffer(vim.api.nvim_get_current_buf())
end)

-- Incremental selection (core-based replacement for the legacy module).
require('plugins.lang.ts_incremental')

-- Text objects: select / move / swap / repeatable (nvim-treesitter-textobjects main).
require('plugins.lang.textobjects')
