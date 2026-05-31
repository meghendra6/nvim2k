local which_key = require('which-key')
local icons = require('lib.icons')
local util = require('lib.util')
local prompts = require('lib.prompts')

local setup = {
    preset = 'modern',
    plugins = {
        marks = true,
        registers = true,
        spelling = {
            enabled = true,
            suggestions = 30,
        },
        presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
        },
    },
    icons = {
        breadcrumb = icons.ui.ArrowOpen,
        separator = icons.ui.Arrow,
        group = '',
        keys = {
            Space = icons.ui.Rocket,
        },
        rules = false, -- enable auto icon rules
    },
    win = {
        no_overlap = true,
        border = 'rounded',
        width = 0.8,
        height = { min = 5, max = 25 },
        padding = { 1, 2 },
        title = true,
        title_pos = 'center',
        zindex = 1000,
        wo = {
            winblend = 10,
        },
    },
    layout = {
        width = { min = 20 },
        spacing = 6,
        align = 'center',
    },
    show_help = false,
    show_keys = true,
    triggers = {
        { '<auto>', mode = 'nvisoct' },
        { '<leader>', mode = { 'n', 'v' } },
    },
}

local function snacks_picker(name, opts)
    return function()
        Snacks.picker[name](opts)
    end
end

local function config_files()
    Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
end

local function dotfiles()
    local cwd = vim.fn.expand('$DOTS_DIR')
    if cwd == '' or cwd == '$DOTS_DIR' then
        cwd = vim.fn.expand('~/.config')
    end
    Snacks.picker.files({ cwd = cwd })
end

local function cwd()
    return vim.fn.getcwd()
end

local function project_root()
    return util.get_root_dir() or cwd()
end

local function current_path()
    return util.get_file_path()
end

local function explorer(path)
    return function()
        require('mini.files').open(path(), true)
    end
end

local function terminal(cmd, opts)
    return function()
        Snacks.terminal.toggle(cmd, opts)
    end
end

local function sudo_write()
    vim.cmd('write !sudo tee % >/dev/null')
    vim.cmd('edit!')
end

local function detailed_blame()
    local file = vim.api.nvim_buf_get_name(0)
    if file == '' or vim.fn.filereadable(file) == 0 then
        vim.notify('Detailed blame requires a saved file', vim.log.levels.WARN)
        return
    end

    local parent = vim.fn.fnamemodify(file, ':h')
    local git_root = vim.fn.systemlist({ 'git', '-C', parent, 'rev-parse', '--show-toplevel' })
    if vim.v.shell_error ~= 0 or not git_root[1] or git_root[1] == '' then
        vim.notify('Detailed blame requires a Git repository', vim.log.levels.WARN)
        return
    end

    Snacks.git.blame_line()
end

local bottom_terminal = { win = { position = 'bottom', height = 0.3 } }
local vertical_terminal = { win = { position = 'right', width = 0.4 } }

local normal_mappings = {
    mode = 'n',
    { '<leader>x', group = ' Trouble' },
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List' },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List' },

    { '<leader>a', group = ' AI' },
    { '<leader>aa', ':CodeCompanionActions<cr>', desc = 'Code Companion Actions' },
    { '<leader>ac', ':CodeCompanionChat Toggle<cr>', desc = 'Copilot Chat' },
    { '<leader>aC', ':CodeCompanionChat copilot_claude37_thought<cr>', desc = 'Copilot Claude' },
    { '<leader>ad', ':CodeCompanionChat github_deepseek_r1<cr>', desc = 'GitHub Deepseek' },
    { '<leader>af', ':CodeCompanionChat copilot_o3mini<cr>', desc = 'Copilot Fast' },
    { '<leader>ag', ':CodeCompanionChat copilot_gpt4o<cr>', desc = 'Copilot GPT' },
    { '<leader>al', ':CodeCompanionChat github_llama_3_3_70b<cr>', desc = 'GitHub Ollama' },
    { '<leader>ao', ':CodeCompanionChat ollama_deepseek_coder<cr>', desc = 'Ollama Deepseek Coder' },
    { '<leader>as', ':CodeCompanionChat copilot_gemini<cr>', desc = 'Copilot Gemini' },
    { '<leader>ap', group = 'Insert Prompt' },
    { '<leader>apd', prompts.add_prompt('docs'), desc = 'Docs' },
    { '<leader>ape', prompts.add_prompt('explain'), desc = 'Explain' },
    { '<leader>apf', prompts.add_prompt('fix'), desc = 'Fix' },
    { '<leader>apg', prompts.add_prompt('commit'), desc = 'Commit' },
    { '<leader>apo', prompts.add_prompt('optimize'), desc = 'Optimize' },
    { '<leader>apr', prompts.add_prompt('review'), desc = 'Review' },
    { '<leader>apt', prompts.add_prompt('tests'), desc = 'Tests' },

    { '<leader>c', group = ' Code' },
    { '<leader>cF', '<cmd>retab<cr>', desc = 'Fix Tabs' },
    { '<leader>cP', '<cmd>CccConvert<cr>', desc = 'Convert Color' },
    { '<leader>cR', '<cmd>ReloadConfig<cr>', desc = 'Reload Configs' },
    { '<leader>cc', '<cmd>CccHighlighterToggle<cr>', desc = 'Highlight Colors' },
    { '<leader>cd', '<cmd>RootDir<cr>', desc = 'Root Directory' },
    { '<leader>ce', '<cmd>%SnipRun<cr>', desc = 'Execute File' },
    {
        '<leader>cf',
        '<cmd>lua require("conform").format({async = true, lsp_format = "fallback"})<cr>',
        desc = 'Format File',
    },
    { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Trouble' },
    { '<leader>cm', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown Preview' },
    { '<leader>cn', '<cmd>lua require("snacks").notifier.show_history()<cr>', desc = 'Notifications' },
    {
        '<leader>co',
        function()
            Snacks.dashboard()
        end,
        desc = 'Dashboard',
    },
    { '<leader>cp', '<cmd>CccPick<cr>', desc = 'Pick Color' },
    { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },

    { '<leader>e', group = ' Edit' },
    { '<leader>ea', ':b#<cr>', desc = 'Alternate File' },
    { '<leader>ec', group = 'Edit Configs' },
    { '<leader>eca', '<cmd>e ~/.config/shell/aliases.sh<cr>', desc = 'Shell Aliases' },
    { '<leader>ecA', '<cmd>e ~/.config/alacritty/alacritty.toml<cr>', desc = 'Alacritty Config' },
    { '<leader>ecb', '<cmd>e ~/.bashrc<cr>', desc = 'Bash Config' },
    {
        '<leader>ecc',
        config_files,
        desc = 'Neovim Configs',
    },
    {
        '<leader>ecd',
        dotfiles,
        desc = 'Dotfiles',
    },
    { '<leader>ece', '<cmd>e ~/.config/shell/environment.sh<cr>', desc = 'Environment Config' },
    { '<leader>ecf', '<cmd>e ~/.config/shell/functions.sh<cr>', desc = 'Shell Functions' },
    { '<leader>ecg', '<cmd>e ~/.gitconfig<cr>', desc = 'Git Config' },
    { '<leader>eck', '<cmd>e ~/.config/kitty/kitty.conf<cr>', desc = 'Kitty Config' },
    { '<leader>ecl', '<cmd>e ~/.config/shell/local.sh<cr>', desc = 'Local Env' },
    { '<leader>ecn', '<cmd>e $MYVIMRC<cr>', desc = 'Neovim Init' },
    { '<leader>ecp', '<cmd>e ~/.config/nvim/lua/plugins/list.lua<cr>', desc = 'Plugin List' },
    { '<leader>ecq', '<cmd>e ~/.config/qutebrowser/config.py<cr>', desc = 'Qutebrowser Config' },
    { '<leader>ect', '<cmd>e ~/.config/tmux/tmux.conf<cr>', desc = 'Tmux Config' },
    { '<leader>ecv', '<cmd>e ~/.vimrc<cr>', desc = 'Vim Config' },
    { '<leader>ecz', '<cmd>e $ZDOTDIR/.zshrc<cr>', desc = 'Zsh Config' },
    { '<leader>ecZ', '<cmd>e $ZDOTDIR/prompt/init.zsh<cr>', desc = 'Zsh Prompt Config' },

    { '<leader>eE', explorer(project_root), desc = 'Project Explorer' },
    { '<leader>ee', explorer(current_path), desc = 'Explorer' },
    { '<leader>ef', 'gf', desc = 'File Under Cursor' },
    { '<leader>em', ':e README.md<cr>', desc = 'Readme' },
    { '<leader>en', ':enew<cr>', desc = 'New File' },
    { '<leader>ew', explorer(cwd), desc = 'CWD Explorer' },

    { '<leader>f', group = ' Find' },
    { '<leader>fB', snacks_picker('grep_buffers'), desc = 'Search Buffers' },
    { '<leader>fL', snacks_picker('loclist'), desc = 'Location List' },
    { '<leader>fS', snacks_picker('smart'), desc = 'Smart Find' },
    { '<leader>fb', snacks_picker('buffers'), desc = 'Buffers' },
    { '<leader>fc', config_files, desc = 'Config Files' },
    { '<leader>ff', snacks_picker('files'), desc = 'Files' },
    { '<leader>fg', snacks_picker('git_files'), desc = 'Git Files' },
    { '<leader>fh', snacks_picker('help'), desc = 'Help' },
    { '<leader>fj', snacks_picker('jumps'), desc = 'Jumps' },
    { '<leader>fl', snacks_picker('lines'), desc = 'Lines' },
    { '<leader>fp', snacks_picker('projects'), desc = 'Projects' },
    { '<leader>fq', snacks_picker('qflist'), desc = 'Quickfix' },
    { '<leader>fr', snacks_picker('recent'), desc = 'Recent Files' },
    { '<leader>fs', snacks_picker('grep'), desc = 'Search Text' },
    { '<leader>fu', snacks_picker('undo'), desc = 'Undo History' },
    { '<leader>fw', snacks_picker('grep_word'), desc = 'Word' },
    { '<leader>fx', ':%bd|e#|bd#<cr>', desc = 'Close except current' },
    { '<leader>fz', snacks_picker('zoxide'), desc = 'Zoxide' },

    { '<leader>g', group = ' Git' },
    { '<leader>gA', ':Gitsigns stage_buffer<cr>', desc = 'Stage Buffer' },
    { '<leader>gC', ':CoAuthor<cr>', desc = 'Co-Authors' },
    { '<leader>gP', ':Git push<cr>', desc = 'Push' },
    { '<leader>gR', ':Gitsigns reset_buffer<cr>', desc = 'Reset Buffer' },
    { '<leader>ga', ':Gitsigns stage_hunk<cr>', desc = 'Stage Hunk' },
    { '<leader>gb', ":lua require('gitsigns').blame_line({full = true})<cr>", desc = 'Blame' },
    { '<leader>gc', ':Git commit<cr>', desc = 'Commit Staged' },
    { '<leader>gB', detailed_blame, desc = 'Detailed Blame' },
    { '<leader>gd', ':Gitsigns diffthis HEAD<cr>', desc = 'Git Diff' },
    { '<leader>gF', ':Git<cr>', desc = 'Fugitive Panel' },
    { '<leader>gg', ':lua require("snacks").lazygit()<cr>', desc = 'Lazygit' },
    { '<leader>gi', ':Gitsigns preview_hunk<cr>', desc = 'Hunk Info' },
    { '<leader>gj', ':Gitsigns next_hunk<cr>', desc = 'Next Hunk' },
    { '<leader>gk', ':Gitsigns prev_hunk<cr>', desc = 'Prev Hunk' },
    { '<leader>gL', snacks_picker('git_log'), desc = 'Git Log' },
    { '<leader>gl', snacks_picker('git_log_file'), desc = 'File Log' },
    { '<leader>go', group = 'GitHub' },
    {
        '<leader>goI',
        function()
            Snacks.picker.gh_issue({ state = 'all' })
        end,
        desc = 'All Issues',
    },
    {
        '<leader>goP',
        function()
            Snacks.picker.gh_pr({ state = 'all' })
        end,
        desc = 'All Pull Requests',
    },
    { '<leader>goi', snacks_picker('gh_issue'), desc = 'Open Issues' },
    { '<leader>gop', snacks_picker('gh_pr'), desc = 'Open Pull Requests' },
    { '<leader>gp', '<cmd>Git pull<cr>', desc = 'Pull' },
    { '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset Hunk' },
    { '<leader>gs', snacks_picker('git_branches'), desc = 'Switch Branch' },
    { '<leader>gS', snacks_picker('git_status'), desc = 'Changed Files' },
    { '<leader>gt', group = 'Toggle' },
    { '<leader>gtb', ':Gitsigns toggle_current_line_blame<cr>', desc = 'Blame' },
    { '<leader>gtd', ':Gitsigns toggle_deleted<cr>', desc = 'Deleted' },
    { '<leader>gtl', ':Gitsigns toggle_linehl<cr>', desc = 'Line HL' },
    { '<leader>gtn', ':Gitsigns toggle_numhl<cr>', desc = 'Number HL' },
    { '<leader>gts', ':Gitsigns toggle_signs<cr>', desc = 'Signs' },
    { '<leader>gtw', ':Gitsigns toggle_word_diff<cr>', desc = 'Word Diff' },
    { '<leader>gu', ':Gitsigns undo_stage_hunk<cr>', desc = 'Undo Stage Hunk' },
    { '<leader>gv', ':Gitsigns select_hunk<cr>', desc = 'Select Hunk' },
    { '<leader>gw', ':lua require("snacks").gitbrowse()<cr>', desc = 'Git Browse' },

    { '<leader>i', group = ' Insert' },
    { '<leader>id', ":put =strftime('## %a, %d %b, %Y, %r')<cr>", desc = 'Date' },
    { '<leader>if', ":put =expand('%:t')<cr>", desc = 'File Name' },
    { '<leader>in', snacks_picker('icons'), desc = 'Icons' },
    { '<leader>ip', ':put %<cr>', desc = 'Relative Path' },
    { '<leader>iP', ':put %:p<cr>', desc = 'Absolute Path' },
    { '<leader>it', ":put =strftime('## %r')<cr>", desc = 'Time' },

    { '<leader>j', group = ' Jump' },
    { '<leader>jc', '*', desc = 'Word' },
    { '<leader>jd', ':FlashDiagnostics<cr>', desc = 'Diagnostics' },
    { '<leader>jh', '<C-o>', desc = 'Backward' },
    { '<leader>jj', ":lua require('flash').remote()<cr>", desc = 'Remote' },
    { '<leader>jk', ":lua require('flash').treesitter()<cr>", desc = 'Treesitter' },
    { '<leader>jl', '<C-i>', desc = 'Forward' },
    { '<leader>jp', ":lua require('flash').jump({continue = true})<cr>", desc = 'Previous Jump' },
    {
        '<leader>jR',
        function()
            Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
    },
    {
        '<leader>jr',
        function()
            Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
    },
    { '<leader>js', ":lua require('flash').jump()<cr>", desc = 'Search' },
    { '<leader>jt', ":lua require('flash').treesitter_search()<cr>", desc = 'Remote Treesitter' },
    {
        '<leader>jn',
        ":lua require('flash').jump({search = { forward = true, wrap = false, multi_window = false },})<cr>",
        desc = 'Search Forward',
    },
    {
        '<leader>jN',
        ":lua require('flash').jump({search = { forward = false, wrap = false, multi_window = false },})<cr>",
        desc = 'Search Backward',
    },
    {
        '<leader>jw',
        ':lua require("flash").jump({ pattern = vim.fn.expand("<cword>")})<cr>',
        desc = 'Current Word',
    },

    { '<leader>l', group = ' LSP' },
    { '<leader>la', ':Lspsaga code_action<cr>', desc = 'Code Action' },
    { '<leader>lC', snacks_picker('lsp_outgoing_calls'), desc = 'Outgoing Calls' },
    { '<leader>ld', ':Lspsaga goto_definition<cr>', desc = 'Goto Definition' },
    { '<leader>lf', ':Lspsaga finder<cr>', desc = 'Finder' },
    { '<leader>lF', snacks_picker('lsp_references'), desc = 'References' },
    { '<leader>lh', ':Lspsaga hover_doc<cr>', desc = 'Hover' },
    { '<leader>lI', ':LspInfo<cr>', desc = 'LSP Info' },
    { '<leader>li', snacks_picker('lsp_implementations'), desc = 'Implementations' },
    { '<leader>lj', ':Lspsaga diagnostic_jump_next<cr>', desc = 'Next Diagnostic' },
    { '<leader>lk', ':Lspsaga diagnostic_jump_prev<cr>', desc = 'Prev Diagnostic' },
    { '<leader>ll', snacks_picker('diagnostics_buffer'), desc = 'Buffer Diagnostics' },
    { '<leader>lL', snacks_picker('diagnostics'), desc = 'Workspace Diagnostics' },
    { '<leader>lo', ':Lspsaga outline<cr>', desc = 'Outline' },
    { '<leader>lc', snacks_picker('lsp_incoming_calls'), desc = 'Incoming Calls' },
    { '<leader>lp', ':Lspsaga peek_definition<cr>', desc = 'Peek Definition (Float Window)' },
    { '<leader>lq', ':LspStop<cr>', desc = 'Stop LSP' },
    { '<leader>lQ', ':LspRestart<cr>', desc = 'Restart LSP' },
    { '<leader>lr', ':Lspsaga rename<cr>', desc = 'Rename' },
    { '<leader>lR', ':Lspsaga project_replace<cr>', desc = 'Replace' },
    { '<leader>ls', snacks_picker('lsp_symbols'), desc = 'Document Symbols' },
    { '<leader>lS', snacks_picker('lsp_workspace_symbols'), desc = 'Workspace Symbols' },
    { '<leader>lt', ':Lspsaga goto_type_definition<cr>', desc = 'Goto Type Definition' },
    { '<leader>lT', ':Lspsaga peek_type_definition<cr>', desc = 'Peek Type Definition' },

    { '<leader>m', group = ' Marks' },
    {
        '<leader>mb',
        snacks_picker('marks'),
        desc = 'Bookmarks',
    },
    { '<leader>md', ":lua require('markit').delete_line()<cr>", desc = 'Delete Marks In Line' },
    { '<leader>mD', ":lua require('markit').delete_buf()<cr>", desc = 'Delete Marks In Buffer' },
    { '<leader>mh', ":lua require('markit').prev_bookmark()<cr>", desc = 'Previous Bookmark' },
    { '<leader>mj', ":lua require('markit').next()<cr>", desc = 'Next' },
    { '<leader>mk', ":lua require('markit').prev()<cr>", desc = 'Previous' },
    { '<leader>ml', ":lua require('markit').next_bookmark()<cr>", desc = 'Next Bookmark' },
    { '<leader>mn', group = 'Next Bookmark In Group' },
    { '<leader>mp', group = 'Previous Bookmark In Group' },
    { '<leader>mP', ":lua require('markit').preview()<cr>", desc = 'Preview' },
    { '<leader>ms', ":lua require('markit').set_next()<cr>", desc = 'Set Next' },
    { '<leader>mt', ":lua require('markit').toggle()<cr>", desc = 'Toggle' },
    { '<leader>mx', ":lua require('markit').delete_bookmark()<cr>", desc = 'Delete Bookmark' },

    { '<leader>n', group = ' Notes' },
    { '<leader>na', ':lua Snacks.scratch.select()<cr>', desc = 'Select Scratch' },
    {
        '<leader>nc',
        ':lua require("tdo").run_with("commit " .. vim.fn.expand("%:p")) vim.notify("Committed!")<cr>',
        desc = 'Commit Note',
    },
    { '<leader>nd', ':Tdo<cr>', desc = "Today's Todo" },
    { '<leader>ne', ':TdoEntry<cr>', desc = "Today's Entry" },
    { '<leader>nf', ':TdoFiles<cr>', desc = 'All Notes' },
    { '<leader>ng', ':TdoFind<cr>', desc = 'Find Notes' },
    { '<leader>nh', ':Tdo -1<cr>', desc = "Yesterday's Todo" },
    { '<leader>nl', ':Tdo 1<cr>', desc = "Tomorrow's Todo" },
    { '<leader>nn', ':TdoNote<cr>', desc = 'New Note' },
    { '<leader>np', group = 'Past Todos' },
    { '<leader>ns', ':lua Snacks.scratch()<cr>', desc = 'New Scratch' },
    { '<leader>nt', ':TdoTodos<cr>', desc = 'Incomplete Todos' },
    { '<leader>nx', ':TdoToggle<cr>', desc = 'Toggle Todo' },

    { '<leader>o', group = ' Options' },
    {
        '<leader>oi',
        function()
            vim.show_pos()
        end,
        desc = 'Inspect Position',
    },
    { '<leader>oN', ':lua Snacks.notifier.show_history()<cr>', desc = 'Notification History' },
    { '<leader>or', ':set relativenumber!<cr>', desc = 'Relative Numbers' },

    { '<leader>p', group = ' Packages' },
    { '<leader>pc', ':Lazy check<cr>', desc = 'Check' },
    { '<leader>pd', ':Lazy debug<cr>', desc = 'Debug' },
    { '<leader>pe', ':lua require("snacks").profiler.scratch()<cr>', desc = 'Profiler Scratch' },
    { '<leader>pf', ':lua require("snacks").profiler.pick()<cr>', desc = 'Profiler Pick' },
    { '<leader>pi', ':Lazy install<cr>', desc = 'Install' },
    { '<leader>pl', ':Lazy log<cr>', desc = 'Log' },
    { '<leader>pm', ':Mason<cr>', desc = 'Mason' },
    { '<leader>pp', ':Lazy<cr>', desc = 'Plugins' },
    { '<leader>pP', ':Lazy profile<cr>', desc = 'Profile' },
    { '<leader>pr', ':Lazy restore<cr>', desc = 'Restore' },
    { '<leader>ps', ':Lazy sync<cr>', desc = 'Sync' },
    { '<leader>pt', ':lua require("snacks").profiler.toggle()<cr>', desc = 'Profiler Toggle' },
    { '<leader>pu', ':Lazy update<cr>', desc = 'Update' },
    { '<leader>px', ':Lazy clean<cr>', desc = 'Clean' },

    { '<leader>q', group = ' Quit' },
    { '<leader>qa', ':qall<cr>', desc = 'Quit All' },
    { '<leader>qb', ':bw<cr>', desc = 'Close Buffer' },
    { '<leader>qd', ':lua require("snacks").bufdelete()<cr>', desc = 'Delete Buffer' },
    { '<leader>qf', ':qall!<cr>', desc = 'Force Quit' },
    { '<leader>qo', ':%bdelete|b#|bdelete#<cr>', desc = 'Close Others' },
    { '<leader>qq', ':q<cr>', desc = 'Quit' },
    { '<leader>qs', '<C-w>c', desc = 'Close Split' },
    { '<leader>qw', ':wq<cr>', desc = 'Write and Quit' },

    { '<leader>r', group = ' Refactor' },
    {
        '<leader>rR',
        function()
            require('refactoring').select_refactor()
        end,
        desc = 'Refactor Commands',
    },
    { '<leader>rS', "<cmd>lua require('spectre').open()<cr>", desc = 'Replace' },
    { '<leader>rb', "<cmd>lua require('spectre').open_file_search()<cr>", desc = 'Replace Buffer' },
    { '<leader>re', "<cmd>lua require('refactoring').refactor('Extract Block')<CR>", desc = 'Extract Block' },
    {
        '<leader>rf',
        "<cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
        desc = 'Extract To File',
    },
    { '<leader>ri', "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", desc = 'Inline Variable' },
    { '<leader>rs', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', desc = 'Replace Word' },
    { '<leader>rv', "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>", desc = 'Extract Variable' },
    { '<leader>rw', "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", desc = 'Replace Word' },

    { '<leader>s', group = ' Split' },
    { '<leader>s+', ':resize +10<cr>', desc = 'Increase window height' },
    { '<leader>s-', ':vertical resize -20<cr>', desc = 'Decrease window width' },
    { '<leader>s/', '<C-w>s', desc = 'Split Below' },
    { '<leader>s=', ':vertical resize +20<cr>', desc = 'Increase window width' },
    { '<leader>sH', ':vertical resize -10<cr>', desc = 'Decrease window width' },
    { '<leader>sJ', ':resize -5<cr>', desc = 'Decrease window height' },
    { '<leader>sK', ':resize +5<cr>', desc = 'Increase window height' },
    { '<leader>sL', ':vertical resize +10<cr>', desc = 'Increase window width' },
    { '<leader>s\\', '<C-w>v', desc = 'Split Right' },
    { '<leader>s_', ':resize -10<cr>', desc = 'Decrease window height' },
    { '<leader>s`', '<C-w>p', desc = 'Previous Window' },
    { '<leader>sa', ':split<cr>', desc = 'Horizontal Split' },
    { '<leader>sc', ':tabclose<cr>', desc = 'Close Tab' },
    { '<leader>sf', ':tabfirst<cr>', desc = 'First Tab' },
    { '<leader>sh', '<C-w>h', desc = 'Move Left' },
    { '<leader>sj', '<C-w>j', desc = 'Move Down' },
    { '<leader>sk', '<C-w>k', desc = 'Move Up' },
    { '<leader>sl', '<C-w>l', desc = 'Move Right' },
    { '<leader>sp', ':NavigatorPrevious<cr>', desc = 'Previous Pane' },
    { '<leader>sq', '<C-w>c', desc = 'Close Split' },
    { '<leader>ss', ':vsplit<cr>', desc = 'Vertical Split' },

    { '<leader>t', group = ' Terminal' },
    { '<leader>t`', terminal(nil, bottom_terminal), desc = 'Horizontal Terminal' },
    { '<leader>tc', terminal('bundle exec rails console', bottom_terminal), desc = 'Rails Console' },
    { '<leader>td', terminal('dexe', bottom_terminal), desc = 'Exe Launcher' },
    { '<leader>tn', terminal('node', bottom_terminal), desc = 'Node' },
    { '<leader>tp', terminal('bpython', bottom_terminal), desc = 'Python' },
    { '<leader>tr', terminal('irb', bottom_terminal), desc = 'Ruby' },
    { '<leader>ts', terminal(nil, bottom_terminal), desc = 'Horizontal Terminal' },
    { '<leader>tt', terminal(), desc = 'Terminal' },
    { '<leader>tv', terminal(nil, vertical_terminal), desc = 'Vertical Terminal' },
    { '<leader>tw', terminal('dexe --wait-before-exit', bottom_terminal), desc = 'Exe Launcher, Wait' },

    { '<leader>w', group = ' Writing' },
    { '<leader>wc', ':set spell!<cr>', desc = 'Spellcheck' },
    { '<leader>wd', ':lua require("snacks").dim.enable()<cr>', desc = 'Dim On' },
    { '<leader>wD', ':lua require("snacks").dim.disable()<cr>', desc = 'Dim Off' },
    { '<leader>wf', sudo_write, desc = 'Force Write' },
    { '<leader>wj', ']s', desc = 'Next Misspell' },
    { '<leader>wk', '[s', desc = 'Prev Misspell' },
    { '<leader>wn', '<cmd>WriteNoFormat<cr>', desc = 'Write Without Formatting' },
    { '<leader>wq', '<cmd>wq<cr>', desc = 'Write and Quit' },
    { '<leader>ws', snacks_picker('spelling'), desc = 'Suggestions' },
    { '<leader>ww', '<cmd>w<cr>', desc = 'Write' },
    { '<leader>wz', '<cmd>lua require("snacks").zen.zen()<cr>', desc = 'Zen' },
    { '<leader>wZ', '<cmd>lua require("snacks").zen.zoom()<cr>', desc = 'Zoom' },

    { '<leader>y', group = ' Yank' },
    { '<leader>yL', ':CopyAbsolutePathWithLine<cr>', desc = 'Absolute Path with Line' },
    { '<leader>yP', ':CopyAbsolutePath<cr>', desc = 'Absolute Path' },
    { '<leader>ya', ':%y+<cr>', desc = 'Copy Whole File' },
    { '<leader>yf', ':CopyFileName<cr>', desc = 'File Name' },
    { '<leader>yg', ':lua require"gitlinker".get_buf_range_url()<cr>', desc = 'Copy Git URL' },
    { '<leader>yl', ':CopyRelativePathWithLine<cr>', desc = 'Relative Path with Line' },
    { '<leader>yp', ':CopyRelativePath<cr>', desc = 'Relative Path' },
}

-- Numerical mappings
for i = 1, 9 do
    table.insert(normal_mappings, {
        string.format('<leader>n%d', i),
        string.format(':Tdo %d<cr>', i),
        desc = string.format('Todo %d Days In Future', i),
    })

    table.insert(normal_mappings, {
        string.format('<leader>np%d', i),
        string.format(':Tdo -%d<cr>', i),
        desc = string.format('Todo %d Days From Past', i),
    })

    table.insert(normal_mappings, {
        string.format('<leader>f%d', i),
        string.format(':LualineBuffersJump%d<cr>', i),
        desc = string.format('File %d', i),
    })

    table.insert(normal_mappings, {
        string.format('<leader>m%d', i),
        string.format(':lua require("markit").toggle_bookmark%d()<cr>', i),
        desc = string.format('Toggle Group %d Bookmark', i),
    })

    table.insert(normal_mappings, {
        string.format('<leader>mp%d', i),
        string.format(':lua require("markit").prev_bookmark%d()<cr>', i),
        desc = string.format('Previous Group %d Bookmarks', i),
    })

    table.insert(normal_mappings, {
        string.format('<leader>mn%d', i),
        string.format(':lua require("markit").next_bookmark%d()<cr>', i),
        desc = string.format('Next Group %d Bookmarks', i),
    })
end

local visual_mappings = {
    mode = 'v',
    { '<leader>a', group = ' AI' },
    { '<leader>ac', ':CodeCompanion<cr>', desc = 'Chat' },
    { '<leader>ad', ':CodeCompanion ' .. prompts.docs .. '<cr>', desc = 'Docs' },
    { '<leader>ae', ':CodeCompanion ' .. prompts.explain .. '<cr>', desc = 'Explain' },
    { '<leader>af', ':CodeCompanion ' .. prompts.fix .. '<cr>', desc = 'Fix' },
    { '<leader>ag', ':CodeCompanion ' .. prompts.commit .. '<cr>', desc = 'Commit' },
    { '<leader>ao', ':CodeCompanion ' .. prompts.optimize .. '<cr>', desc = 'Optimize' },
    { '<leader>ar', ':CodeCompanion ' .. prompts.review .. '<cr>', desc = 'Review' },
    { '<leader>at', ':CodeCompanion ' .. prompts.tests .. '<cr>', desc = 'Tests' },

    { '<leader>c', group = ' Code' },
    { '<leader>ce', "<esc>:'<,'>SnipRun<cr>", desc = 'Execute Selection' },
    { '<leader>cS', ':sort!<cr>', desc = 'Sort Desc' },
    { '<leader>ci', ':sort i<cr>', desc = 'Sort Case Insensitive' },
    { '<leader>cs', ':sort<cr>', desc = 'Sort Asc' },
    { '<leader>cu', ':!uniq<cr>', desc = 'Unique' },
    { '<leader>cx', ':lua<cr>', desc = 'Execute Lua' },

    { '<leader>g', group = ' Git' },
    { '<leader>ga', ":'<,'>Gitsigns stage_hunk<cr>", desc = 'Stage Hunk' },
    { '<leader>gr', ":'<,'>Gitsigns reset_hunk<cr>", desc = 'Reset Hunk' },
    { '<leader>gu', ":'<,'>Gitsigns undo_stage_hunk<cr>", desc = 'Undo Stage Hunk' },

    { '<leader>j', group = ' Jump' },
    {
        '<leader>jN',
        ":lua require('flash').jump({search = { forward = false, wrap = false, multi_window = false },})<cr>",
        desc = 'Search Backward',
    },
    { '<leader>jd', ':FlashDiagnostics<cr>', desc = 'Diagnostics' },
    { '<leader>jj', ":lua require('flash').remote()<cr>", desc = 'Remote' },
    { '<leader>jk', ":lua require('flash').treesitter()<cr>", desc = 'Treesitter' },
    {
        '<leader>jn',
        ":lua require('flash').jump({search = { forward = true, wrap = false, multi_window = false },})<cr>",
        desc = 'Search Forward',
    },
    { '<leader>jp', ":lua require('flash').jump({continue = true})<cr>", desc = 'Previous Jump' },
    { '<leader>js', ":lua require('flash').jump()<cr>", desc = 'Search' },
    { '<leader>jt', ":lua require('flash').treesitter_search()<cr>", desc = 'Remote Treesitter' },
    {
        '<leader>jw',
        ':lua require("flash").jump({ pattern = vim.fn.expand("<cword>")})<cr>',
        desc = 'Current Word',
    },

    { '<leader>l', group = ' LSP' },
    { '<leader>la', ':<C-U>Lspsaga range_code_action<cr>', desc = 'Code Action' },

    { '<leader>r', group = ' Refactor' },
    {
        '<leader>re',
        "<esc>:lua require('refactoring').refactor('Extract Function')<cr>",
        desc = 'Extract Function',
    },
    {
        '<leader>rf',
        "<esc>:lua require('refactoring').refactor('Extract Function To File')<cr>",
        desc = 'Extract To File',
    },
    { '<leader>ri', "<esc>:lua require('refactoring').refactor('Inline Variable')<cr>", desc = 'Inline Variable' },
    {
        '<leader>rv',
        "<esc>:lua require('refactoring').refactor('Extract Variable')<cr>",
        desc = 'Extract Variable',
    },

    { '<leader>y', group = ' Yank' },
    { '<leader>yg', ':lua require"gitlinker".get_buf_range_url("v")<cr>', desc = 'Copy Git URL' },
}

local no_leader_mappings = {
    mode = 'n',
    { '<C-Down>', ':resize -10<cr>', desc = 'Decrease window height' },
    { '<C-Left>', ':vertical resize -10<cr>', desc = 'Decrease window width' },
    { '<C-Right>', ':vertical resize +10<cr>', desc = 'Increase window width' },
    { '<C-Up>', ':resize +10<cr>', desc = 'Increase window height' },
    {
        '<C-g>',
        function()
            Snacks.lazygit()
        end,
        desc = 'Lazygit',
    },

    { '<C-h>', ':NavigatorLeft<cr>', desc = 'Move Left' },
    { '<C-j>', ':NavigatorDown<cr>', desc = 'Move Down' },
    { '<C-k>', ':NavigatorUp<cr>', desc = 'Move Up' },
    { '<C-l>', ':NavigatorRight<cr>', desc = 'Move Right' },
    { '<C-\\>', ':NavigatorPrevious<cr>', desc = 'Previous Pane' },

    { '<S-h>', ':bprevious<cr>', desc = 'Previous Buffer' },
    { '<S-l>', ':bnext<cr>', desc = 'Next Buffer' },

    { 'K', ':Lspsaga hover_doc<cr>', desc = 'LSP Hover' },
    { 'Q', ':qall!<cr>', desc = 'Force Quit!' },
    { 'U', ':redo<cr>', desc = 'Redo' },

    { '[', group = ' Previous' },
    { '[g', ':Gitsigns prev_hunk<cr>', desc = 'Git Hunk' },
    { '[o', group = 'Textobjects' },

    { ']', group = ' Next' },
    { ']g', ':Gitsigns next_hunk<cr>', desc = 'Git Hunk' },
    { ']o', group = 'Textobjects' },

    { 'gd', ':Lspsaga peek_definition<cr>', desc = 'Peek Definition (Select & Jump)' },
    { 'gD', ':Lspsaga goto_definition<cr>', desc = 'Goto Definition (Direct)' },
    { 'gf', ':Lspsaga finder<cr>', desc = 'LSP Finder (All References)' },
}

which_key.setup(setup)
which_key.add(normal_mappings)
which_key.add(visual_mappings)
which_key.add(no_leader_mappings)

Snacks.toggle.diagnostics():map('<leader>od')
Snacks.toggle.indent():map('<leader>og')
Snacks.toggle.inlay_hints():map('<leader>oh')
Snacks.toggle.words():map('<leader>ow')
Snacks.toggle.dim():map('<leader>oD')

if util.get_user_config('enable_test_runner', false) then
    local test_runner_bindings = {
        mode = 'n',
        { '<leader>u', group = ' Test' },
        { '<leader>uc', ':lua require("neotest").run.run()<cr>', desc = 'Run Current Test' },
        { '<leader>uf', ':lua require("neotest").run.run(vim.fn.expand("%"))<cr>', desc = 'Run Test File' },
        { '<leader>uo', ':Neotest output-panel<cr>', desc = 'Test Output' },
        { '<leader>us', ':Neotest summary<cr>', desc = 'Test Summary' },
    }
    which_key.add(test_runner_bindings)
end

if util.get_user_config('enable_db_explorer', false) then
    local db_explorer_bindings = {
        mode = 'n',
        { '<leader>d', group = ' Database' },
        { '<leader>dS', ':lua require("dbee").store("json", "buffer", { extra_arg = 0 })<cr>', desc = 'To JSON' },
        { '<leader>db', ':DBToggle<cr>', desc = 'DB Explorer' },
        { '<leader>dj', ':lua require("dbee").next()<cr>', desc = 'DB Next' },
        { '<leader>dk', ':lua require("dbee").prev()<cr>', desc = 'DB Prev' },
        { '<leader>ds', ':lua require("dbee").store("csv", "buffer", { extra_arg = 0 })<cr>', desc = 'To CSV' },
        { '<leader>dt', ':lua require("dbee").store("table", "buffer", { extra_arg = 0 })<cr>', desc = 'To Table' },
    }
    which_key.add(db_explorer_bindings)
end

if util.get_user_config('enable_trainer', false) then
    local trainer_bindings = {
        mode = 'n',
        { '<leader>ch', '<cmd>Hardtime toggle<cr>', desc = 'Hardtime' },
    }
    which_key.add(trainer_bindings)
end

if util.get_user_config('enable_debugger', false) then
    local debugger_bindings = {
        mode = 'n',
        { '<leader>b', group = ' Debug' },
        { '<leader>bO', ':DapStepOut<cr>', desc = 'Out' },
        { '<leader>bR', ':DapRestartFrame<cr>', desc = 'Restart Frame' },
        { '<leader>bb', ':DapToggleBreakpoint<cr>', desc = 'Breakpoint' },
        { '<leader>bc', ':DapContinue<cr>', desc = 'Continue' },
        { '<leader>bi', ':DapStepInto<cr>', desc = 'Into' },
        { '<leader>bl', ":lua require'dap'.run_last()<cr>", desc = 'Last' },
        { '<leader>bo', ':DapStepOver<cr>', desc = 'Over' },
        { '<leader>br', ':DapToggleRepl<cr>', desc = 'Repl' },
        { '<leader>bt', ':DapUIToggle<cr>', desc = 'Debugger' },
        { '<leader>bx', ':DapTerminate<cr>', desc = 'Exit' },
    }
    which_key.add(debugger_bindings)
end

local user_keybindings = require('lib.util').get_user_config('user_keybindings', {})
which_key.add(user_keybindings)
