# [nvim2k](https://github.com/2kabhishek/nvim2k) [Keybindings](https://github.com/2KAbhishek/nvim2k/blob/main/docs/keybindings.md)

Here are all the keybindings defined for nvim2k.

Check out the source code of individual files for more info.

Sources:

- [Which Key](../lua/plugins/tools/which-key.lua) - Biggest source of keybindings, fully documented.
- [General](../lua/core/keys.lua) - Changes behavior of core keys, not documented here.
- Individual plugin configs - Check out the source code of individual files in [plugins](../lua/plugins/) for more info.

## Leader Bindings (Normal Mode)

> Leader == <kbd>Space</kbd>

### ; - Breadcrumb

| Keybinding                       | Action          |
| -------------------------------- | --------------- |
| <kbd>Leader</kbd> <kbd> ; </kbd> | Pick Breadcrumb |

### a - AI

| Keybinding                         | Action         |
| ---------------------------------- | -------------- |
| <kbd>Leader</kbd> <kbd> a a </kbd> | Code Companion Actions |
| <kbd>Leader</kbd> <kbd> a c </kbd> | Copilot Chat |
| <kbd>Leader</kbd> <kbd> a C </kbd> | Copilot Claude |
| <kbd>Leader</kbd> <kbd> a d </kbd> | GitHub Deepseek |
| <kbd>Leader</kbd> <kbd> a f </kbd> | Copilot Fast |
| <kbd>Leader</kbd> <kbd> a g </kbd> | Copilot GPT |
| <kbd>Leader</kbd> <kbd> a l </kbd> | GitHub Ollama |
| <kbd>Leader</kbd> <kbd> a o </kbd> | Ollama Deepseek Coder |
| <kbd>Leader</kbd> <kbd> a s </kbd> | Copilot Gemini |
| <kbd>Leader</kbd> <kbd> a p d </kbd> | Docs |
| <kbd>Leader</kbd> <kbd> a p e </kbd> | Explain |
| <kbd>Leader</kbd> <kbd> a p f </kbd> | Fix |
| <kbd>Leader</kbd> <kbd> a p g </kbd> | Commit |
| <kbd>Leader</kbd> <kbd> a p o </kbd> | Optimize |
| <kbd>Leader</kbd> <kbd> a p r </kbd> | Review |
| <kbd>Leader</kbd> <kbd> a p t </kbd> | Tests |

### c - Code

| Keybinding                         | Action            |
| ---------------------------------- | ----------------- |
| <kbd>Leader</kbd> <kbd> c c </kbd> | Highlight Colors  |
| <kbd>Leader</kbd> <kbd> c d </kbd> | Root Directory    |
| <kbd>Leader</kbd> <kbd> c e </kbd> | Execute File      |
| <kbd>Leader</kbd> <kbd> c f </kbd> | Format File       |
| <kbd>Leader</kbd> <kbd> c F </kbd> | Fix Tabs          |
| <kbd>Leader</kbd> <kbd> c l </kbd> | LSP Trouble       |
| <kbd>Leader</kbd> <kbd> c m </kbd> | Markdown Preview  |
| <kbd>Leader</kbd> <kbd> c n </kbd> | Notifications     |
| <kbd>Leader</kbd> <kbd> c o </kbd> | Dashboard         |
| <kbd>Leader</kbd> <kbd> c p </kbd> | Pick Color        |
| <kbd>Leader</kbd> <kbd> c P </kbd> | Convert Color     |
| <kbd>Leader</kbd> <kbd> c R </kbd> | Reload Configs    |
| <kbd>Leader</kbd> <kbd> c s </kbd> | Symbols           |

### e - Edit

| Keybinding                           | Action             |
| ------------------------------------ | ------------------ |
| <kbd>Leader</kbd> <kbd> e a </kbd>   | Alternate File     |
| <kbd>Leader</kbd> <kbd> e c </kbd>   | Config             |
| <kbd>Leader</kbd> <kbd> e c a </kbd> | Shell Aliases      |
| <kbd>Leader</kbd> <kbd> e c A </kbd> | Alacritty Config   |
| <kbd>Leader</kbd> <kbd> e c b </kbd> | Bash Config        |
| <kbd>Leader</kbd> <kbd> e c c </kbd> | Neovim Configs     |
| <kbd>Leader</kbd> <kbd> e c d </kbd> | Dotfiles           |
| <kbd>Leader</kbd> <kbd> e c e </kbd> | Environment Config |
| <kbd>Leader</kbd> <kbd> e c f </kbd> | Shell Functions    |
| <kbd>Leader</kbd> <kbd> e c g </kbd> | Git Config         |
| <kbd>Leader</kbd> <kbd> e c k </kbd> | Kitty Config       |
| <kbd>Leader</kbd> <kbd> e c l </kbd> | Local Env          |
| <kbd>Leader</kbd> <kbd> e c n </kbd> | Neovim Init        |
| <kbd>Leader</kbd> <kbd> e c p </kbd> | Plugin List        |
| <kbd>Leader</kbd> <kbd> e c q </kbd> | Qutebrowser Config |
| <kbd>Leader</kbd> <kbd> e c t </kbd> | Tmux Config        |
| <kbd>Leader</kbd> <kbd> e c v </kbd> | Vim Config         |
| <kbd>Leader</kbd> <kbd> e c z </kbd> | Zsh Config         |
| <kbd>Leader</kbd> <kbd> e c Z </kbd> | Zsh Prompt Config  |
| <kbd>Leader</kbd> <kbd> e E </kbd>   | Project Explorer   |
| <kbd>Leader</kbd> <kbd> e e </kbd>   | Explorer           |
| <kbd>Leader</kbd> <kbd> e f </kbd>   | File Under Cursor  |
| <kbd>Leader</kbd> <kbd> e m </kbd>   | Readme             |
| <kbd>Leader</kbd> <kbd> e n </kbd>   | New File           |
| <kbd>Leader</kbd> <kbd> e w </kbd>   | CWD Explorer       |

### f - Find

| Keybinding                            | Action               |
| ------------------------------------- | -------------------- |
| <kbd>Leader</kbd> <kbd> f 1..9 </kbd> | Jump to File         |
| <kbd>Leader</kbd> <kbd> f B </kbd>    | Search Buffers       |
| <kbd>Leader</kbd> <kbd> f b </kbd>    | Buffers              |
| <kbd>Leader</kbd> <kbd> f c </kbd>    | Config Files         |
| <kbd>Leader</kbd> <kbd> f f </kbd>    | Files                |
| <kbd>Leader</kbd> <kbd> f g </kbd>    | Git Files            |
| <kbd>Leader</kbd> <kbd> f h </kbd>    | Help                 |
| <kbd>Leader</kbd> <kbd> f j </kbd>    | Jumps                |
| <kbd>Leader</kbd> <kbd> f L </kbd>    | Location List        |
| <kbd>Leader</kbd> <kbd> f l </kbd>    | Lines                |
| <kbd>Leader</kbd> <kbd> f p </kbd>    | Projects             |
| <kbd>Leader</kbd> <kbd> f q </kbd>    | Quickfix             |
| <kbd>Leader</kbd> <kbd> f r </kbd>    | Recent Files         |
| <kbd>Leader</kbd> <kbd> f S </kbd>    | Smart Find           |
| <kbd>Leader</kbd> <kbd> f s </kbd>    | Search Text          |
| <kbd>Leader</kbd> <kbd> f u </kbd>    | Undo History         |
| <kbd>Leader</kbd> <kbd> f w </kbd>    | Word                 |
| <kbd>Leader</kbd> <kbd> f x </kbd>    | Close except current |
| <kbd>Leader</kbd> <kbd> f z </kbd>    | Zoxide               |

### g - Git

| Keybinding                           | Action          |
| ------------------------------------ | --------------- |
| <kbd>Leader</kbd> <kbd> g a </kbd>   | Stage Hunk      |
| <kbd>Leader</kbd> <kbd> g A </kbd>   | Stage Buffer    |
| <kbd>Leader</kbd> <kbd> g b </kbd>   | Blame           |
| <kbd>Leader</kbd> <kbd> g B </kbd>   | Detailed Blame  |
| <kbd>Leader</kbd> <kbd> g c </kbd>   | Commit Staged   |
| <kbd>Leader</kbd> <kbd> g C </kbd>   | Co-Authors      |
| <kbd>Leader</kbd> <kbd> g d </kbd>   | Diff            |
| <kbd>Leader</kbd> <kbd> g F </kbd>   | Fugitive Panel  |
| <kbd>Leader</kbd> <kbd> g g </kbd>   | Lazygit         |
| <kbd>Leader</kbd> <kbd> g i </kbd>   | Hunk Info       |
| <kbd>Leader</kbd> <kbd> g j </kbd>   | Next Hunk       |
| <kbd>Leader</kbd> <kbd> g k </kbd>   | Prev Hunk       |
| <kbd>Leader</kbd> <kbd> g l </kbd>   | File Log        |
| <kbd>Leader</kbd> <kbd> g L </kbd>   | Git Log         |
| <kbd>Leader</kbd> <kbd> g p </kbd>   | Pull            |
| <kbd>Leader</kbd> <kbd> g P </kbd>   | Push            |
| <kbd>Leader</kbd> <kbd> g r </kbd>   | Reset Hunk      |
| <kbd>Leader</kbd> <kbd> g R </kbd>   | Reset Buffer    |
| <kbd>Leader</kbd> <kbd> g s </kbd>   | Switch Branch   |
| <kbd>Leader</kbd> <kbd> g S </kbd>   | Changed Files   |
| <kbd>Leader</kbd> <kbd> g t b </kbd> | Blame           |
| <kbd>Leader</kbd> <kbd> g t d </kbd> | Deleted         |
| <kbd>Leader</kbd> <kbd> g t l </kbd> | Line HL         |
| <kbd>Leader</kbd> <kbd> g t n </kbd> | Number HL       |
| <kbd>Leader</kbd> <kbd> g t s </kbd> | Signs           |
| <kbd>Leader</kbd> <kbd> g t w </kbd> | Word Diff       |
| <kbd>Leader</kbd> <kbd> g u </kbd>   | Undo Stage Hunk |
| <kbd>Leader</kbd> <kbd> g v </kbd>   | Select Hunk     |
| <kbd>Leader</kbd> <kbd> g w </kbd>   | Git Browse      |

#### go - GitHub

| Keybinding                             | Action                 |
| -------------------------------------- | ---------------------- |
| <kbd>Leader</kbd> <kbd> g o i </kbd>   | Open Issues            |
| <kbd>Leader</kbd> <kbd> g o I </kbd>   | All Issues             |
| <kbd>Leader</kbd> <kbd> g o p </kbd>   | Open Pull Requests     |
| <kbd>Leader</kbd> <kbd> g o P </kbd>   | All Pull Requests      |

### i - Insert

| Keybinding                         | Action        |
| ---------------------------------- | ------------- |
| <kbd>Leader</kbd> <kbd> i d </kbd> | Date          |
| <kbd>Leader</kbd> <kbd> i f </kbd> | File Name     |
| <kbd>Leader</kbd> <kbd> i n </kbd> | Icons         |
| <kbd>Leader</kbd> <kbd> i P </kbd> | Absolute Path |
| <kbd>Leader</kbd> <kbd> i p </kbd> | Relative Path |
| <kbd>Leader</kbd> <kbd> i t </kbd> | Time          |

### j - Jump

| Keybinding                         | Action            |
| ---------------------------------- | ----------------- |
| <kbd>Leader</kbd> <kbd> j c </kbd> | Word              |
| <kbd>Leader</kbd> <kbd> j d </kbd> | Diagnostics       |
| <kbd>Leader</kbd> <kbd> j h </kbd> | Backward          |
| <kbd>Leader</kbd> <kbd> j j </kbd> | Remote            |
| <kbd>Leader</kbd> <kbd> j k </kbd> | Treesitter        |
| <kbd>Leader</kbd> <kbd> j l </kbd> | Forward           |
| <kbd>Leader</kbd> <kbd> j n </kbd> | Search Forward    |
| <kbd>Leader</kbd> <kbd> j N </kbd> | Search Backward   |
| <kbd>Leader</kbd> <kbd> j p </kbd> | Previous Jump     |
| <kbd>Leader</kbd> <kbd> j R </kbd> | Prev Reference    |
| <kbd>Leader</kbd> <kbd> j r </kbd> | Next Reference    |
| <kbd>Leader</kbd> <kbd> j s </kbd> | Search            |
| <kbd>Leader</kbd> <kbd> j t </kbd> | Remote Treesitter |
| <kbd>Leader</kbd> <kbd> j w </kbd> | Current Word      |

### l - LSP

| Keybinding                         | Action                |
| ---------------------------------- | --------------------- |
| <kbd>Leader</kbd> <kbd> l a </kbd> | Code Action           |
| <kbd>Leader</kbd> <kbd> l C </kbd> | Outgoing Calls        |
| <kbd>Leader</kbd> <kbd> l c </kbd> | Incoming Calls        |
| <kbd>Leader</kbd> <kbd> l d </kbd> | Goto Definition       |
| <kbd>Leader</kbd> <kbd> l f </kbd> | Finder                |
| <kbd>Leader</kbd> <kbd> l F </kbd> | References            |
| <kbd>Leader</kbd> <kbd> l h </kbd> | Hover                 |
| <kbd>Leader</kbd> <kbd> l I </kbd> | LSP Info              |
| <kbd>Leader</kbd> <kbd> l i </kbd> | Implementations       |
| <kbd>Leader</kbd> <kbd> l j </kbd> | Next Diagnostic       |
| <kbd>Leader</kbd> <kbd> l k </kbd> | Prev Diagnostic       |
| <kbd>Leader</kbd> <kbd> l L </kbd> | Workspace Diagnostics |
| <kbd>Leader</kbd> <kbd> l l </kbd> | Buffer Diagnostics    |
| <kbd>Leader</kbd> <kbd> l o </kbd> | Outline               |
| <kbd>Leader</kbd> <kbd> l p </kbd> | Peek Definition       |
| <kbd>Leader</kbd> <kbd> l q </kbd> | Stop LSP              |
| <kbd>Leader</kbd> <kbd> l Q </kbd> | Restart LSP           |
| <kbd>Leader</kbd> <kbd> l R </kbd> | Replace               |
| <kbd>Leader</kbd> <kbd> l r </kbd> | Rename                |
| <kbd>Leader</kbd> <kbd> l s </kbd> | Document Symbols      |
| <kbd>Leader</kbd> <kbd> l S </kbd> | Workspace Symbols     |
| <kbd>Leader</kbd> <kbd> l T </kbd> | Peek Type Definition  |
| <kbd>Leader</kbd> <kbd> l t </kbd> | Goto Type Definition  |

### Marks

| Keybinding                           | Action              |
| ------------------------------------ | ------------------- |
| <kbd>Leader</kbd> <kbd> m b </kbd>   | Bookmarks           |
| <kbd>Leader</kbd> <kbd> m d </kbd>   | Delete Line         |
| <kbd>Leader</kbd> <kbd> m D </kbd>   | Delete Buffer       |
| <kbd>Leader</kbd> <kbd> m h </kbd>   | Previous Bookmark   |
| <kbd>Leader</kbd> <kbd> m j </kbd>   | Next                |
| <kbd>Leader</kbd> <kbd> m k </kbd>   | Previous            |
| <kbd>Leader</kbd> <kbd> m l </kbd>   | Next Bookmark       |
| <kbd>Leader</kbd> <kbd> m n 1..9 </kbd> | Next Group Bookmarks |
| <kbd>Leader</kbd> <kbd> m p 1..9 </kbd> | Previous Group Bookmarks |
| <kbd>Leader</kbd> <kbd> m P </kbd>   | Preview             |
| <kbd>Leader</kbd> <kbd> m s </kbd>   | Set Next            |
| <kbd>Leader</kbd> <kbd> m t </kbd>   | Toggle              |
| <kbd>Leader</kbd> <kbd> m x </kbd>   | Delete Bookmark     |
| <kbd>Leader</kbd> <kbd> m 1..9 </kbd> | Toggle Group Bookmark |

### n - Notes

| Keybinding                         | Action           |
| ---------------------------------- | ---------------- |
| <kbd>Leader</kbd> <kbd> n a </kbd> | Select Scratch   |
| <kbd>Leader</kbd> <kbd> n 1..9 </kbd> | Future Todos |
| <kbd>Leader</kbd> <kbd> n c </kbd> | Commit Note      |
| <kbd>Leader</kbd> <kbd> n d </kbd> | Today's Todo     |
| <kbd>Leader</kbd> <kbd> n e </kbd> | Today's Entry    |
| <kbd>Leader</kbd> <kbd> n f </kbd> | All Notes        |
| <kbd>Leader</kbd> <kbd> n g </kbd> | Find Notes       |
| <kbd>Leader</kbd> <kbd> n h </kbd> | Yesterday's Todo |
| <kbd>Leader</kbd> <kbd> n l </kbd> | Tomorrow's Todo  |
| <kbd>Leader</kbd> <kbd> n n </kbd> | New Note         |
| <kbd>Leader</kbd> <kbd> n p 1..9 </kbd> | Past Todos |
| <kbd>Leader</kbd> <kbd> n s </kbd> | New Scratch      |
| <kbd>Leader</kbd> <kbd> n t </kbd> | Incomplete Todos |
| <kbd>Leader</kbd> <kbd> n x </kbd> | Toggle Todo      |

### o - Options

| Keybinding                         | Action           |
| ---------------------------------- | ---------------- |
| <kbd>Leader</kbd> <kbd> o D </kbd> | Toggle Dimming   |
| <kbd>Leader</kbd> <kbd> o d </kbd> | Toggle Diagnostics |
| <kbd>Leader</kbd> <kbd> o g </kbd> | Toggle Indent Guides |
| <kbd>Leader</kbd> <kbd> o h </kbd> | Toggle Inlay Hints |
| <kbd>Leader</kbd> <kbd> o i </kbd> | Inspect Position |
| <kbd>Leader</kbd> <kbd> o N </kbd> | Notification History |
| <kbd>Leader</kbd> <kbd> o r </kbd> | Relative Numbers |
| <kbd>Leader</kbd> <kbd> o t </kbd> | Toggle Colorscheme |
| <kbd>Leader</kbd> <kbd> o w </kbd> | Toggle LSP Words |

### p - Packages

| Keybinding                         | Action           |
| ---------------------------------- | ---------------- |
| <kbd>Leader</kbd> <kbd> p c </kbd> | Check            |
| <kbd>Leader</kbd> <kbd> p d </kbd> | Debug            |
| <kbd>Leader</kbd> <kbd> p e </kbd> | Profiler Scratch |
| <kbd>Leader</kbd> <kbd> p f </kbd> | Profiler Pick    |
| <kbd>Leader</kbd> <kbd> p i </kbd> | Install          |
| <kbd>Leader</kbd> <kbd> p l </kbd> | Log              |
| <kbd>Leader</kbd> <kbd> p m </kbd> | Mason            |
| <kbd>Leader</kbd> <kbd> p p </kbd> | Plugins          |
| <kbd>Leader</kbd> <kbd> p P </kbd> | Profile          |
| <kbd>Leader</kbd> <kbd> p r </kbd> | Restore          |
| <kbd>Leader</kbd> <kbd> p s </kbd> | Sync             |
| <kbd>Leader</kbd> <kbd> p t </kbd> | Profiler Toggle  |
| <kbd>Leader</kbd> <kbd> p u </kbd> | Update           |
| <kbd>Leader</kbd> <kbd> p x </kbd> | Clean            |

### q - Quit

| Keybinding                         | Action         |
| ---------------------------------- | -------------- |
| <kbd>Leader</kbd> <kbd> q a </kbd> | Quit All       |
| <kbd>Leader</kbd> <kbd> q b </kbd> | Close Buffer   |
| <kbd>Leader</kbd> <kbd> q d </kbd> | Delete Buffer  |
| <kbd>Leader</kbd> <kbd> q f </kbd> | Force Quit     |
| <kbd>Leader</kbd> <kbd> q o </kbd> | Close Others   |
| <kbd>Leader</kbd> <kbd> q q </kbd> | Quit           |
| <kbd>Leader</kbd> <kbd> q s </kbd> | Close Split    |
| <kbd>Leader</kbd> <kbd> q w </kbd> | Write and Quit |

### r - Refactor

| Keybinding                         | Action               |
| ---------------------------------- | -------------------- |
| <kbd>Leader</kbd> <kbd> r b </kbd> | Replace Buffer       |
| <kbd>Leader</kbd> <kbd> r c </kbd> | Rails Commands       |
| <kbd>Leader</kbd> <kbd> r e </kbd> | Extract Block        |
| <kbd>Leader</kbd> <kbd> r f </kbd> | Extract To File      |
| <kbd>Leader</kbd> <kbd> r i </kbd> | Inline Variable      |
| <kbd>Leader</kbd> <kbd> r R </kbd> | Refactor Commands    |
| <kbd>Leader</kbd> <kbd> r S </kbd> | Replace              |
| <kbd>Leader</kbd> <kbd> r s </kbd> | Replace Word         |
| <kbd>Leader</kbd> <kbd> r v </kbd> | Extract Variable     |
| <kbd>Leader</kbd> <kbd> r w </kbd> | Replace Word         |

### s - Split

| Keybinding                          | Action           |
| ----------------------------------- | ---------------- |
| <kbd>Leader</kbd> <kbd> s ` </kbd>  | Previous Window  |
| <kbd>Leader</kbd> <kbd> s \ </kbd>  | Split Right      |
| <kbd>Leader</kbd> <kbd> s / </kbd>  | Split Below      |
| <kbd>Leader</kbd> <kbd> s - </kbd>  | Decrease Width   |
| <kbd>Leader</kbd> <kbd> s = </kbd>  | Increase Width   |
| <kbd>Leader</kbd> <kbd> s \_ </kbd> | Decrease Height  |
| <kbd>Leader</kbd> <kbd> s + </kbd>  | Increase Height  |
| <kbd>Leader</kbd> <kbd> s a </kbd>  | Horizontal Split |
| <kbd>Leader</kbd> <kbd> s c </kbd>  | Close Tab        |
| <kbd>Leader</kbd> <kbd> s f </kbd>  | First Tab        |
| <kbd>Leader</kbd> <kbd> s h </kbd>  | Move Left        |
| <kbd>Leader</kbd> <kbd> s H </kbd>  | Decrease Width   |
| <kbd>Leader</kbd> <kbd> s j </kbd>  | Move Down        |
| <kbd>Leader</kbd> <kbd> s J </kbd>  | Decrease Height  |
| <kbd>Leader</kbd> <kbd> s k </kbd>  | Move Up          |
| <kbd>Leader</kbd> <kbd> s K </kbd>  | Increase Height  |
| <kbd>Leader</kbd> <kbd> s l </kbd>  | Move Right       |
| <kbd>Leader</kbd> <kbd> s L </kbd>  | Increase Width   |
| <kbd>Leader</kbd> <kbd> s p </kbd>  | Previous Pane    |
| <kbd>Leader</kbd> <kbd> s q </kbd>  | Close Split      |
| <kbd>Leader</kbd> <kbd> s s </kbd>  | Vertical Split   |

### t - Terminal

| Keybinding                         | Action              |
| ---------------------------------- | ------------------- |
| <kbd>Leader</kbd> <kbd> t ` </kbd> | Horizontal Terminal |
| <kbd>Leader</kbd> <kbd> t c </kbd> | Rails Console       |
| <kbd>Leader</kbd> <kbd> t d </kbd> | Exe Launcher        |
| <kbd>Leader</kbd> <kbd> t n </kbd> | Node                |
| <kbd>Leader</kbd> <kbd> t p </kbd> | Python              |
| <kbd>Leader</kbd> <kbd> t r </kbd> | Ruby                |
| <kbd>Leader</kbd> <kbd> t s </kbd> | Horizontal Terminal |
| <kbd>Leader</kbd> <kbd> t t </kbd> | Terminal            |
| <kbd>Leader</kbd> <kbd> t v </kbd> | Vertical Terminal   |
| <kbd>Leader</kbd> <kbd> t w </kbd> | Exe Launcher, Wait  |

### w - Writing

| Keybinding                         | Action                   |
| ---------------------------------- | ------------------------ |
| <kbd>Leader</kbd> <kbd> w c </kbd> | Spellcheck               |
| <kbd>Leader</kbd> <kbd> w d </kbd> | Dim On                   |
| <kbd>Leader</kbd> <kbd> w D </kbd> | Dim Off                  |
| <kbd>Leader</kbd> <kbd> w f </kbd> | Force Write              |
| <kbd>Leader</kbd> <kbd> w j </kbd> | Next Misspell            |
| <kbd>Leader</kbd> <kbd> w k </kbd> | Prev Misspell            |
| <kbd>Leader</kbd> <kbd> w n </kbd> | Write Without Formatting |
| <kbd>Leader</kbd> <kbd> w q </kbd> | Write and Quit           |
| <kbd>Leader</kbd> <kbd> w w </kbd> | Write                    |
| <kbd>Leader</kbd> <kbd> w s </kbd> | Suggestions              |
| <kbd>Leader</kbd> <kbd> w z </kbd> | Zen                      |
| <kbd>Leader</kbd> <kbd> w Z </kbd> | Zoom                     |

### x - Trouble

| Keybinding                         | Action               |
| ---------------------------------- | -------------------- |
| <kbd>Leader</kbd> <kbd> x x </kbd> | Diagnostics          |
| <kbd>Leader</kbd> <kbd> x X </kbd> | Buffer Diagnostics   |
| <kbd>Leader</kbd> <kbd> x L </kbd> | Location List        |
| <kbd>Leader</kbd> <kbd> x Q </kbd> | Quickfix List        |
| <kbd>Leader</kbd> <kbd> x t </kbd> | Todo Comments        |
| <kbd>Leader</kbd> <kbd> x T </kbd> | Todo Comments Quickfix |

### y - Yank

| Keybinding                         | Action          |
| ---------------------------------- | --------------- |
| <kbd>Leader</kbd> <kbd> y a </kbd> | Copy Whole File |
| <kbd>Leader</kbd> <kbd> y f </kbd> | File Name       |
| <kbd>Leader</kbd> <kbd> y g </kbd> | Copy Git URL    |
| <kbd>Leader</kbd> <kbd> y L </kbd> | Absolute Path with Line |
| <kbd>Leader</kbd> <kbd> y P </kbd> | Absolute Path   |
| <kbd>Leader</kbd> <kbd> y l </kbd> | Relative Path with Line |
| <kbd>Leader</kbd> <kbd> y p </kbd> | Relative Path   |

## Leader Bindings (Visual Mode)

### a - AI

| Keybinding                         | Action         |
| ---------------------------------- | -------------- |
| <kbd>Leader</kbd> <kbd> a c </kbd> | Chat           |
| <kbd>Leader</kbd> <kbd> a d </kbd> | Docs           |
| <kbd>Leader</kbd> <kbd> a e </kbd> | Explain        |
| <kbd>Leader</kbd> <kbd> a f </kbd> | Fix            |
| <kbd>Leader</kbd> <kbd> a g </kbd> | Commit         |
| <kbd>Leader</kbd> <kbd> a o </kbd> | Optimize       |
| <kbd>Leader</kbd> <kbd> a r </kbd> | Review         |
| <kbd>Leader</kbd> <kbd> a t </kbd> | Tests          |

### c - Code

| Keybinding                         | Action                |
| ---------------------------------- | --------------------- |
| <kbd>Leader</kbd> <kbd> c e </kbd> | Run Code              |
| <kbd>Leader</kbd> <kbd> c i </kbd> | Sort Case Insensitive |
| <kbd>Leader</kbd> <kbd> c S </kbd> | Sort Desc             |
| <kbd>Leader</kbd> <kbd> c s </kbd> | Sort Asc              |
| <kbd>Leader</kbd> <kbd> c u </kbd> | Unique                |
| <kbd>Leader</kbd> <kbd> c x </kbd> | Execute Lua           |

### g - Git

| Keybinding                         | Action     |
| ---------------------------------- | ---------- |
| <kbd>Leader</kbd> <kbd> g a </kbd> | Stage Hunk |
| <kbd>Leader</kbd> <kbd> g r </kbd> | Reset Hunk |
| <kbd>Leader</kbd> <kbd> g u </kbd> | Undo Stage Hunk |

### j - Jump

| Keybinding                         | Action            |
| ---------------------------------- | ----------------- |
| <kbd>Leader</kbd> <kbd> j d </kbd> | Diagnostics       |
| <kbd>Leader</kbd> <kbd> j j </kbd> | Remote            |
| <kbd>Leader</kbd> <kbd> j k </kbd> | Treesitter        |
| <kbd>Leader</kbd> <kbd> j n </kbd> | Search Forward    |
| <kbd>Leader</kbd> <kbd> j N </kbd> | Search Backward   |
| <kbd>Leader</kbd> <kbd> j p </kbd> | Previous Jump     |
| <kbd>Leader</kbd> <kbd> j s </kbd> | Search            |
| <kbd>Leader</kbd> <kbd> j t </kbd> | Remote Treesitter |
| <kbd>Leader</kbd> <kbd> j w </kbd> | Current Word      |

### l - LSP

| Keybinding                         | Action            |
| ---------------------------------- | ----------------- |
| <kbd>Leader</kbd> <kbd> l a </kbd> | Range Code Action |

### r - Refactor

| Keybinding                         | Action            |
| ---------------------------------- | ----------------- |
| <kbd>Leader</kbd> <kbd> r e </kbd> | Extract Function  |
| <kbd>Leader</kbd> <kbd> r f </kbd> | Extract To File   |
| <kbd>Leader</kbd> <kbd> r v </kbd> | Extract Variable  |
| <kbd>Leader</kbd> <kbd> r i </kbd> | Inline Variable   |

### y - Yank

| Keybinding                         | Action       |
| ---------------------------------- | ------------ |
| <kbd>Leader</kbd> <kbd> y g </kbd> | Copy Git URL |

## Non Leader Bindings

| Keybinding                         | Action                 |
| ---------------------------------- | ---------------------- |
| <kbd>K</kbd>                       | LSP Hover              |
| <kbd>Q</kbd>                       | Force Quit!            |
| <kbd>S</kbd>                       | Flash                  |
| <kbd>U</kbd>                       | Redo                   |
| <kbd>g d</kbd>                     | Peek Definition        |
| <kbd>g D</kbd>                     | Goto Definition        |
| <kbd>g f</kbd>                     | LSP Finder             |
| <kbd>g h</kbd>                     | Beginning of Line      |
| <kbd>g l</kbd>                     | End of Line            |
| <kbd>Shift</kbd> + <kbd>H</kbd>    | Previous Buffer        |
| <kbd>Shift</kbd> + <kbd>L</kbd>    | Next Buffer            |
| <kbd>Ctrl</kbd> + <kbd>S</kbd>     | Save File              |
| <kbd>Ctrl</kbd> + <kbd>H</kbd>     | Move Left              |
| <kbd>Ctrl</kbd> + <kbd>J</kbd>     | Move Down              |
| <kbd>Ctrl</kbd> + <kbd>K</kbd>     | Move Up                |
| <kbd>Ctrl</kbd> + <kbd>L</kbd>     | Move Right             |
| <kbd>Ctrl</kbd> + <kbd>\</kbd>     | Previous Pane          |
| <kbd>Ctrl</kbd> + <kbd>Up</kbd>    | Increase window height |
| <kbd>Ctrl</kbd> + <kbd>Down</kbd>  | Decrease window height |
| <kbd>Ctrl</kbd> + <kbd>Left</kbd>  | Decrease window width  |
| <kbd>Ctrl</kbd> + <kbd>Right</kbd> | Increase window width  |
| <kbd>Ctrl</kbd> + <kbd>G</kbd>     | Lazygit                |

### [ - Previous

| Keybinding                | Action       |
| ------------------------- | ------------ |
| <kbd>[</kbd> <kbd>;</kbd> | Context Start |
| <kbd>[</kbd> <kbd>b</kbd> | Buffer       |
| <kbd>[</kbd> <kbd>c</kbd> | Comment      |
| <kbd>[</kbd> <kbd>B</kbd> | First Buffer |
| <kbd>[</kbd> <kbd>d</kbd> | Diagnostic   |
| <kbd>[</kbd> <kbd>g</kbd> | Git Hunk     |
| <kbd>[</kbd> <kbd>j</kbd> | Jump         |

### ] - Next

| Keybinding                | Action      |
| ------------------------- | ----------- |
| <kbd>]</kbd> <kbd>;</kbd> | Next Context |
| <kbd>]</kbd> <kbd>b</kbd> | Buffer      |
| <kbd>]</kbd> <kbd>c</kbd> | Comment     |
| <kbd>]</kbd> <kbd>B</kbd> | Last Buffer |
| <kbd>]</kbd> <kbd>d</kbd> | Diagnostic  |
| <kbd>]</kbd> <kbd>g</kbd> | Git Hunk    |
| <kbd>]</kbd> <kbd>j</kbd> | Jump        |
