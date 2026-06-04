-- nvim-treesitter-textobjects `main` branch API.
-- Select / move / swap text objects + repeatable f/F/t/T and ;/, motions.

require('nvim-treesitter-textobjects').setup({
    select = {
        lookahead = true,
    },
    move = {
        set_jumps = true,
    },
})

local select = require('nvim-treesitter-textobjects.select')
local swap = require('nvim-treesitter-textobjects.swap')
local move = require('nvim-treesitter-textobjects.move')

-- Select
local select_keys = {
    ['a='] = '@assignment.outer',
    ['i='] = '@assignment.inner',
    ['al='] = '@assignment.lhs',
    ['ar='] = '@assignment.rhs',
    ['a:'] = '@property.outer',
    ['i:'] = '@property.inner',
    ['l:'] = '@property.lhs',
    ['r:'] = '@property.rhs',
    ['aa'] = '@parameter.outer',
    ['ia'] = '@parameter.inner',
    ['ai'] = '@conditional.outer',
    ['ii'] = '@conditional.inner',
    ['al'] = '@loop.outer',
    ['il'] = '@loop.inner',
    ['af'] = '@call.outer',
    ['if'] = '@call.inner',
    ['am'] = '@function.outer',
    ['im'] = '@function.inner',
    ['ac'] = '@class.outer',
    ['ic'] = '@class.inner',
}
for lhs, query in pairs(select_keys) do
    vim.keymap.set({ 'x', 'o' }, lhs, function()
        select.select_textobject(query, 'textobjects')
    end, { desc = 'Select ' .. query })
end

-- Swap
local swap_next = {
    ['<leader>rna'] = '@parameter.inner',
    ['<leader>rn:'] = '@property.outer',
    ['<leader>rnm'] = '@function.outer',
}
for lhs, query in pairs(swap_next) do
    vim.keymap.set('n', lhs, function()
        swap.swap_next(query)
    end, { desc = 'Swap next ' .. query })
end

local swap_prev = {
    ['<leader>rpa'] = '@parameter.inner',
    ['<leader>rp:'] = '@property.outer',
    ['<leader>rpm'] = '@function.outer',
}
for lhs, query in pairs(swap_prev) do
    vim.keymap.set('n', lhs, function()
        swap.swap_previous(query)
    end, { desc = 'Swap previous ' .. query })
end

-- Move
local function map_move(lhs, fn, query, group, desc)
    vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
        move[fn](query, group)
    end, { desc = desc })
end

local move_start = {
    ['[oc'] = '@class.outer',
    ['[of'] = '@call.outer',
    ['[oi'] = '@conditional.outer',
    ['[ol'] = '@loop.outer',
    ['[om'] = '@function.outer',
}
for lhs, query in pairs(move_start) do
    map_move(lhs, 'goto_previous_start', query, 'textobjects', 'Prev start ' .. query)
end
map_move('[z', 'goto_previous_start', '@fold', 'folds', 'Prev fold')

local move_end = {
    ['[oC'] = '@class.outer',
    ['[oF'] = '@call.outer',
    ['[oI'] = '@conditional.outer',
    ['[oL'] = '@loop.outer',
    ['[oM'] = '@function.outer',
}
for lhs, query in pairs(move_end) do
    map_move(lhs, 'goto_previous_end', query, 'textobjects', 'Prev end ' .. query)
end
map_move('[Z', 'goto_previous_end', '@fold', 'folds', 'Prev fold end')

local move_next_start = {
    [']oc'] = '@class.outer',
    [']of'] = '@call.outer',
    [']oi'] = '@conditional.outer',
    [']ol'] = '@loop.outer',
    [']om'] = '@function.outer',
}
for lhs, query in pairs(move_next_start) do
    map_move(lhs, 'goto_next_start', query, 'textobjects', 'Next start ' .. query)
end
map_move(']z', 'goto_next_start', '@fold', 'folds', 'Next fold')

local move_next_end = {
    [']oC'] = '@class.outer',
    [']oF'] = '@call.outer',
    [']oI'] = '@conditional.outer',
    [']oL'] = '@loop.outer',
    [']oM'] = '@function.outer',
}
for lhs, query in pairs(move_next_end) do
    map_move(lhs, 'goto_next_end', query, 'textobjects', 'Next end ' .. query)
end
map_move(']Z', 'goto_next_end', '@fold', 'folds', 'Next fold end')

-- Repeatable moves: ; and , repeat the last move; also make f/F/t/T repeatable.
local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')

vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
