local lspsaga = require('lspsaga')

local icons = require('lib.icons')

lspsaga.setup({
    ui = {
        theme = 'round',
        border = 'rounded',
        devicon = true,
        title = true,
        winblend = 1,
        expand = icons.ui.ArrowOpen,
        collapse = icons.ui.ArrowClosed,
        preview = icons.ui.List,
        code_action = icons.diagnostics.Hint,
        diagnostic = icons.ui.Bug,
        incoming = icons.ui.Incoming,
        outgoing = icons.ui.Outgoing,
        hover = icons.ui.Comment,
    },
    -- Definition settings
    definition = {
        width = 0.6,
        height = 0.5,
        keys = {
            edit = '<CR>',      -- Open definition
            vsplit = '<C-v>',   -- Open in vertical split
            split = '<C-x>',    -- Open in horizontal split
            tabe = '<C-t>',     -- Open in new tab
            quit = 'q',         -- Close peek window
            close = '<Esc>',    -- Close peek window
        },
    },
    -- Finder settings for showing all references/implementations/definitions
    finder = {
        max_height = 0.6,
        min_width = 40,
        force_max_height = false,
        keys = {
            jump_to = 'p',            -- Jump to location
            edit = { 'o', '<CR>' },   -- Open location
            vsplit = 's',             -- Open in vertical split
            split = 'i',              -- Open in horizontal split
            tabe = 't',               -- Open in new tab
            quit = { 'q', '<ESC>' },  -- Close finder
            close = '<C-c>',          -- Close finder
        },
    },
})
