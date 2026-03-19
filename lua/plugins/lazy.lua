local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end

local icons = require('lib.icons')
local plugins = require('plugins.list').plugins

lazy.setup({
    root = vim.fn.stdpath('data') .. '/lazy',
    defaults = { 
        lazy = true,
        version = false, -- Don't check version for speed
    },
    spec = plugins,
    lockfile = vim.fn.stdpath('config') .. '/lua/plugins/lock.json',
    concurrency = 4, -- Limit concurrency to prevent 'fetch waiting'
    -- Install/update concurrency optimization
    install = {
        -- Put colorscheme plugin first for faster perceived startup
        colorscheme = { 'onedark' },
        missing = true,
    },
    dev = { path = '~/Projects/2KAbhishek/', patterns = { '2kabhishek' }, fallback = true },

    git = {
        log = { '--since=3 days ago' },
        timeout = 120,
        url_format = 'https://github.com/%s.git',
        filter = true,
        throttle = {
            enabled = true,
            rate = 10, -- 10 ops/sec (prevent rate limiting)
            duration = 1000, -- reset throttle window every 1s (avoid long waits)
        },
    },

    ui = {
        size = { width = 0.9, height = 0.8 },
        wrap = true,
        border = 'rounded',
        icons = {
            cmd = icons.ui.Terminal,
            config = icons.ui.Gear,
            event = icons.ui.Electric,
            ft = icons.documents.File,
            init = icons.ui.Rocket,
            import = icons.documents.Import,
            keys = icons.ui.Keyboard,
            lazy = icons.ui.Sleep,
            loaded = icons.ui.CircleSmall,
            not_loaded = icons.ui.CircleSmallEmpty,
            plugin = icons.ui.Package,
            runtime = icons.ui.Neovim,
            source = icons.ui.Code,
            start = icons.ui.Play,
            task = icons.ui.Check,
            list = {
                icons.ui.CircleSmall,
                icons.ui.Arrow,
                icons.ui.Star,
                icons.ui.Minus,
            },
        },
        browser = nil,
        throttle = 20,
        custom_keys = {
            ['<localleader>l'] = function(plugin)
                require('lazy.util').float_term({ 'lazygit', 'log' }, {
                    cwd = plugin.dir,
                })
            end,

            ['<localleader>t'] = function(plugin)
                require('lazy.util').float_term(nil, {
                    cwd = plugin.dir,
                })
            end,
        },
    },

    diff = { cmd = 'git' },
    checker = { 
        enabled = false,  -- Disable update checking for faster startup
        concurrency = nil,
        notify = false,   -- Don't notify about updates
        frequency = 86400, -- Check once per day if enabled
    },
    change_detection = { 
        enabled = false,  -- Disable file change detection for speed
        notify = false,
    },
    performance = {
        cache = {
            enabled = true,
            path = vim.fn.stdpath('cache') .. '/lazy/cache',
            -- disable = { 'cache' },
            ttl = 3600 * 24 * 5, -- 5 days cache
        },
        reset_packpath = true,
        rtp = {
            reset = true,
            paths = {},
            disabled_plugins = {
                'gzip',
                'tarPlugin',
                'zipPlugin',
                'tohtml',
                'tutor',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'rplugin',
                'getscript',
                'getscriptPlugin',
                'logipat',
                'rrhelper',
                'spellfile',
                'vimball',
                'vimballPlugin',
            },
        },
    },
    readme = {
        root = vim.fn.stdpath('data') .. '/lazy/readme',
        files = { 'README.md', 'lua/**/README.md' },
        skip_if_doc_exists = true,
    },
    state = vim.fn.stdpath('data') .. '/lazy/state.json',
})
