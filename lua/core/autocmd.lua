local function augroup(name)
    return vim.api.nvim_create_augroup('nvim2k_' .. name, { clear = true })
end

-- Strip trailing spaces before write
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = augroup('strip_space'),
    pattern = { '*' },
    callback = function()
        vim.cmd([[ %s/\s\+$//e ]])
    end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = augroup('checktime'),
    command = 'checktime',
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('highlight_yank'),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
    group = augroup('resize_splits'),
    callback = function()
        vim.cmd('tabdo wincmd =')
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
    group = augroup('last_loc'),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('close_with_q'),
    pattern = {
        'Jaq',
        'PlenaryTestPopup',
        'codecompanion',
        'fugitive',
        'git',
        'help',
        'lir',
        'lspinfo',
        'man',
        'netrw',
        'notify',
        'qf',
        'spectre_panel',
        'startuptime',
        'tsplayground',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('wrap_spell'),
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = augroup('auto_create_dir'),
    callback = function(event)
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
})

-- Set arb filetype
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    group = augroup('set_file_type'),
    pattern = { '*.arb' },
    command = require('lib.util').get_file_type_cmd('arb'),
})

-- Disable format options
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('disable_formatoptions'),
    pattern = '*',
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

vim.api.nvim_create_user_command('WriteNoFormat', function()
    -- Temporarily disable autoformat-on-save
    vim.b.disable_autoformat = true
    vim.cmd('write')
    -- Re-enable autoformat-on-save
    vim.b.disable_autoformat = false
end, {})


-- Performance optimization for large files
vim.api.nvim_create_autocmd({ 'BufReadPre', 'FileReadPre' }, {
    group = augroup('large_file_performance'),
    callback = function(args)
        local buf = args.buf
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        
        if ok and stats then
            local size_mb = stats.size / (1024 * 1024)
            
            -- For files > 1MB, disable heavy features
            if size_mb > 1 then
                vim.notify(
                    string.format('Large file detected (%.1f MB). Optimizing performance...', size_mb),
                    vim.log.levels.WARN
                )
                
                -- Disable syntax for very large files
                vim.api.nvim_buf_set_option(buf, 'syntax', 'off')
                
                -- Disable swap, undo, and backup for large files
                vim.api.nvim_buf_set_option(buf, 'swapfile', false)
                vim.api.nvim_buf_set_option(buf, 'undofile', false)
                vim.api.nvim_set_option_value('undolevels', -1, { buf = buf })
                
                -- Disable some vim options for better performance
                vim.api.nvim_set_option_value('eventignore', 'all', { scope = 'local' })
                
                -- Schedule re-enabling events after buffer is loaded
                vim.schedule(function()
                    vim.api.nvim_set_option_value('eventignore', '', { scope = 'local' })
                end)
            end
            
            -- For files > 5MB, be more aggressive
            if size_mb > 5 then
                vim.api.nvim_buf_set_option(buf, 'foldmethod', 'manual')
                vim.api.nvim_set_option_value('cursorline', false, { scope = 'local' })
                vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
            end
        end
    end,
})

-- Disable LSP semantic tokens for better performance
vim.api.nvim_create_autocmd('LspAttach', {
    group = augroup('lsp_performance'),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            -- Disable semantic tokens (can be slow on large files)
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})
