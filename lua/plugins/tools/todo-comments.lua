local todo = require('todo-comments')
local icons = require('lib.icons')

todo.setup({
    signs = true,
    keywords = {
        FIX = { icon = icons.ui.Bug, color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
        TODO = { icon = icons.ui.Check, color = 'info' },
        HACK = { icon = icons.ui.Fire, color = 'warning' },
        WARN = { icon = icons.diagnostics.Warning, color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = icons.ui.Time, alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = icons.ui.Note, color = 'hint', alt = { 'INFO' } },
        TEST = { icon = icons.ui.Test, color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
    highlight = {
        comments_only = true,
        max_line_len = 400,
    },
    search = {
        command = 'rg',
    },
})
