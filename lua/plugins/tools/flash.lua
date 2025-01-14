local flash = require('flash')
local icons = require('lib.icons')

flash.setup({
    -- exact, fuzzy, regex, custom function
    mode = 'fuzzy',
    -- behave like `incsearch`
    incremental = true,

    jump = {
        -- save location in the jumplist
        jumplist = true,
        -- automatically jump when there is only one match
        autojump = true,
        continue = true,
    },
    label = {
        rainbow = {
            enabled = true,
            -- number between 1 and 9
            shade = 4,
        },
    },
    prompt = {
        enabled = true,
        prefix = { { icons.ui.Separator .. icons.ui.Rocket .. icons.ui.ChevronRight .. ' ', 'flashPromptIcon' } },
        win_config = { relative = 'editor', width = 1, height = 1, row = 1, col = 0, zindex = 1000 },
    },
    modes = {
        search = {
            enabled = true,
        },
        char = {
            enabled = false,
            jump_labels = false,
        },
    },
})

vim.api.nvim_create_user_command('flashDiagnostics', function()
    require('flash').jump({
        matcher = function(win)
            return vim.tbl_map(function(diag)
                return {
                    pos = { diag.lnum + 1, diag.col },
                    end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
                }
            end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
        end,
        action = function(match, state)
            vim.api.nvim_win_call(match.win, function()
                vim.api.nvim_win_set_cursor(match.win, match.pos)
                vim.diagnostic.open_float()
            end)
            state:restore()
        end,
    })
end, {})

---@param opts flash.Format
local function format(opts)
    -- always show first and second label
    return {
        { opts.match.label1, 'flashMatch' },
        { opts.match.label2, 'flashLabel' },
    }
end

flash.jump({
    search = { mode = 'search' },
    label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
    pattern = [[\<]],
    action = function(match, state)
        state:hide()
        flash.jump({
            search = { max_length = 0 },
            highlight = { matches = false },
            label = { format = format },
            matcher = function(win)
                -- limit matches to the current label
                return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                end, state.results)
            end,
            labeler = function(matches)
                for _, m in ipairs(matches) do
                    m.label = m.label2 -- use the second label
                end
            end,
        })
    end,
    labeler = function(matches, state)
        local labels = state:labels()
        for m, match in ipairs(matches) do
            match.label1 = labels[math.floor((m - 1) / #labels) + 1]
            match.label2 = labels[(m - 1) % #labels + 1]
            match.label = match.label1
        end
    end,
})
