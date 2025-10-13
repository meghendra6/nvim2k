# LSP Deprecation Warning Fix

## Problem
When running `nvim --headless <file>` on Neovim 0.12+, the following deprecation warning appeared:
```
client.supports_method is deprecated. Run ":checkhealth vim.deprecated" for more information
```

## Root Cause Analysis

### 1. Neovim 0.12 Breaking Changes
Neovim 0.12 deprecated several LSP client methods:
- `client.supports_method()` → `vim.lsp.supports_method(client, method, opts)`
- `client.request()` → New API
- `client.request_sync()` → New API

### 2. Affected Plugins
Several popular plugins haven't been fully updated yet:
- **lspsaga.nvim** - Uses deprecated API in codeaction/lightbulb.lua and other files
- **snacks.nvim** - Uses deprecated API in rename.lua and words.lua
- **ccc.nvim** - Uses deprecated API in handler/lsp.lua
- **nvim-nio** - Uses deprecated API in lsp.lua
- **neotest** - Uses deprecated API in watch consumer

## Solution

Created a compatibility shim (`lua/core/lsp-compat.lua`) that:

### 1. Silences Deprecation Warnings
Overrides `vim.deprecate()` to filter out known LSP deprecation warnings from plugins that are being updated.

```lua
vim.deprecate = function(name, alternative, version, plugin, backtrace)
    if name and type(name) == 'string' then
        if name:match('client%.supports_method') or 
           name:match('client%.request') or
           name:match('client%.request_sync') then
            return -- Silence these specific warnings
        end
    end
    return original_deprecate(name, alternative, version, plugin, backtrace)
end
```

### 2. Provides Backward Compatibility
Patches LSP client objects to add `supports_method()` as a shim to the new API:

```lua
client.supports_method = function(method, opts)
    return vim.lsp.supports_method(client, method, opts)
end
```

This is applied through:
- `LspAttach` autocmd - Patches clients as they attach
- Wrapped `vim.lsp.get_clients()` - Patches all returned clients
- Wrapped `vim.lsp.get_active_clients()` - For backward compatibility
- Wrapped `vim.lsp.get_client_by_id()` - Patches individual client lookups

### 3. Early Loading
The shim is loaded early in `init.lua`, before any plugins:

```lua
require('core.options')
require('core.lsp-compat')  -- Load LSP compatibility shim early
require('core.functions')
-- ... rest of initialization
```

## Testing

✅ No deprecation warnings when running `nvim --headless <file>`
✅ LSP clients attach correctly (pyright, ruff, typos_lsp confirmed)
✅ Plugin functionality preserved (lspsaga, snacks, ccc continue working)

## Future Considerations

This is a temporary fix. As plugins are updated to use the new Neovim 0.12 APIs, this shim can be removed. Monitor these issues:
- lspsaga.nvim: Reverted PR #1538 (was fixing deprecated methods)
- snacks.nvim: Partial fixes in progress (fa27142)
- Other plugins: Check their repos for Neovim 0.12 compatibility updates

## Files Changed

1. **Created:** `lua/core/lsp-compat.lua` - Compatibility shim
2. **Modified:** `init.lua` - Added early loading of compatibility shim
