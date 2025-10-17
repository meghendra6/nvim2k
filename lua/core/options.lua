local options = {
    ai = true,
    autoindent = true,
    autowrite = true,
    backspace = 'indent,eol,start',
    backup = false, -- creates a backup file
    breakindent = true,
    clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    completeopt = 'menu,menuone,noselect', -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    confirm = true, -- Confirm to save changes before exiting modified buffer
    cursorline = false, -- disable for performance (can be slow on large files)
    cursorlineopt = 'number', -- only highlight line number, not entire line
    expandtab = true, -- convert tabs to spaces
    fileencoding = 'utf-8', -- the encoding written to a file
    formatoptions = 'jlnqt', -- set formatoptions, check help fo-table
    grepformat = '%f:%l:%c:%m',
    grepprg = 'rg --vimgrep',
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    inccommand = 'split', -- preview incremental substitute
    laststatus = 3,
    list = true,
    listchars = { trail = '', tab = '', nbsp = '_', extends = '>', precedes = '<' }, -- highlight
    mouse = 'a', -- allow the mouse to be used in neovim
    number = true, -- set numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    pumblend = 10, -- Popup blen
    pumheight = 10, -- pop up menu height
    relativenumber = true, -- set relative numbered lines
    scrolloff = 10, -- is one of my fav
    sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal',
    shiftround = true, -- Round indent
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    showcmd = false,
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 0, -- always show tabs
    si = true,
    sidescrolloff = 8,
    signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    smarttab = true,
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    tabstop = 4, -- insert 2 spaces for a tab
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true, -- window titles
    undofile = true, -- enable persistent undo
    undolevels = 10000,
    updatetime = 200, -- faster completion but not too aggressive (4000ms default, was 50)
    wildmenu = true, -- wildmenu
    wildmode = 'longest:full,full', -- Command-line completion mode
    winminwidth = 5, -- Minimum window width
    wrap = false, -- display lines as one long line
    writebackup = false, -- do not edit backups
    
    -- Performance optimizations
    lazyredraw = true, -- Don't redraw during macro execution
    synmaxcol = 200, -- Only highlight first 200 columns for performance
    redrawtime = 1500, -- Time in ms for redrawing screen (default 2000)
    showmatch = false, -- Don't jump to matching bracket (performance)
    matchtime = 0, -- Disable match time for showmatch
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- netrw file explorer settings
vim.g.netrw_winsize = 20
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Performance: Disable matchparen (bracket highlighting)
-- This is the biggest performance bottleneck according to profiling
vim.g.loaded_matchparen = 1

-- Disable other built-in plugins for performance
vim.g.loaded_matchit = 1  -- matchit plugin
vim.g.loaded_logiPat = 1  -- logical patterns
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_man = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1

vim.opt.path:append({ '**' })
vim.opt.shortmess:append({ W = true, I = true, c = true })

-- hides `~` at the end of the buffer
vim.cmd([[set fillchars+=eob:\ ]])

vim.cmd([[
     setlocal spell spelllang=en "Set spellcheck language to en
     setlocal spell! "Disable spell checks by default
     filetype plugin indent on
     if has('win32')
        let g:python3_host_prog = $HOME . '/scoop/apps/python/current/python.exe'
     endif
    let &t_Cs = "\e[4:3m" "Undercurl
    let &t_Ce = "\e[4:0m"
    set whichwrap+=<,>,[,],h,l
    set iskeyword+=-
 ]])

-- ShaDa optimization - reduce data stored for faster startup
vim.opt.shada = "!,'100,<50,s10,h" -- Reduced from defaults
-- ! - store global variables
-- '100 - marks for last 100 files (reduced from 1000)
-- <50 - max lines saved for each register (reduced from 1000)
-- s10 - max size of item in KB (reduced from 100)
-- h - disable hlsearch on startup
vim.opt.shadafile = vim.fn.stdpath('data') .. '/shada/main.shada'
