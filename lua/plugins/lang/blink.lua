local blink = require('blink.cmp')
local icons = require('lib.icons')

blink.setup({
    -- VSCode-style keybindings for completion
    keymap = {
        preset = 'none', -- Start from scratch for custom bindings
        -- Navigation (VSCode style)
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        
        -- Accept/Confirm (VSCode style)
        ['<Tab>'] = { 'accept', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        
        -- Show/Hide
        ['<C-space>'] = { 'show', 'hide' },
        ['<Esc>'] = { 'hide', 'fallback' },
        
        -- Documentation
        ['<C-y>'] = { 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide_documentation', 'fallback' },
        
        -- Scrolling documentation
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },
    completion = {
        list = {
            selection = {
                auto_insert = true,
                preselect = true,
            },
        },
        menu = { border = 'rounded' },
        documentation = { window = { border = 'rounded' } },
    },
    signature = { window = { border = 'rounded' } },
    appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        nerd_font_variant = 'normal',
        kind_icons = icons.kind,
    },
    sources = {
        -- Copilot removed for performance
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            lazydev = {
                name = 'LazyDev',
                module = 'lazydev.integrations.blink',
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
        },
    },
})
