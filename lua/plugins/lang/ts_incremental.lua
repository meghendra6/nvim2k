-- Incremental selection using Neovim's built-in treesitter.
-- Replaces the `incremental_selection` module from the legacy nvim-treesitter
-- `master` branch (not available on `main`).
--
--   <c-space> (normal) -> select node under cursor
--   <c-space> (visual) -> expand to parent node
--   <bs>      (visual) -> shrink to previous node

local M = {}

-- per-buffer stack of selected nodes
local stack = {}

local function same_range(a, b)
    local a1, a2, a3, a4 = a:range()
    local b1, b2, b3, b4 = b:range()
    return a1 == b1 and a2 == b2 and a3 == b3 and a4 == b4
end

local function reselect(node)
    local srow, scol, erow, ecol = node:range()
    -- node ranges use an exclusive end column; convert to inclusive cursor pos
    if ecol > 0 then
        ecol = ecol - 1
    else
        erow = erow - 1
        ecol = math.max(vim.fn.col({ erow + 1, '$' }) - 2, 0)
    end

    if vim.fn.mode():find('[vV\22]') then
        local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
    end

    vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
    vim.cmd('normal! v')
    vim.api.nvim_win_set_cursor(0, { erow + 1, ecol })
end

function M.init()
    local buf = vim.api.nvim_get_current_buf()
    local node = vim.treesitter.get_node({ bufnr = buf })
    if not node then
        return
    end
    stack[buf] = { node }
    reselect(node)
end

function M.expand()
    local buf = vim.api.nvim_get_current_buf()
    local st = stack[buf]
    if not st or #st == 0 then
        return M.init()
    end

    local current = st[#st]
    local parent = current:parent()
    -- skip parents that cover the exact same range
    while parent and same_range(parent, current) do
        parent = parent:parent()
    end

    if not parent then
        reselect(current)
        return
    end

    st[#st + 1] = parent
    reselect(parent)
end

function M.shrink()
    local buf = vim.api.nvim_get_current_buf()
    local st = stack[buf]
    if not st or #st <= 1 then
        return
    end
    st[#st] = nil
    reselect(st[#st])
end

vim.keymap.set('n', '<c-space>', M.init, { desc = 'Init selection' })
vim.keymap.set('x', '<c-space>', M.expand, { desc = 'Expand selection' })
vim.keymap.set('x', '<bs>', M.shrink, { desc = 'Shrink selection' })

return M
