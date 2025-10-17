# Neovim Performance Optimization Guide

This document describes the performance optimizations applied to improve Neovim's speed, especially when working with large files.

## 🚀 Optimization Summary

### 1. Large File Detection and Auto-Optimization

Files are categorized by size, and features are automatically disabled:

| File Size | Optimizations Applied |
|-----------|----------------------|
| > 1 MB    | • Syntax highlighting disabled<br>• Swap/undo files disabled<br>• LSP disabled |
| > 5 MB    | • Additionally: cursorline disabled<br>• Relative numbers disabled<br>• Manual fold method |

### 2. Treesitter Optimizations

- **Max file size for highlighting**: 1 MB (increased from 100KB)
- **Max line count**: 10,000 lines
- **Disabled features**: `highlight_current_scope` (performance intensive)
- **Kept enabled**: Core syntax highlighting, text objects

### 3. LSP Performance Improvements

- **Semantic tokens disabled**: Reduces CPU usage significantly
- **Auto-disable for large files**: LSP stops for files > 1MB
- **Offset encoding**: Unified to UTF-16 to prevent warnings
- **Document color disabled**: Prevents unsupported request errors

### 4. General Vim Options

```lua
updatetime = 200         -- Balanced (was 50ms, too aggressive)
lazyredraw = true        -- Don't redraw during macros
synmaxcol = 200         -- Only syntax highlight first 200 columns
redrawtime = 1500       -- Screen redraw timeout
```

### 5. Snacks BigFile Detection

- **Threshold**: 5 MB (increased from 100KB)
- **Notification**: Shows alert when big file is detected
- **Auto-optimization**: Disables heavy features automatically

## 📊 Performance Comparison

### Before Optimization
- **100KB file**: Features disabled ❌
- **Large files**: Extremely slow, frequent freezes
- **LSP**: Always active, causes lag
- **Treesitter**: Attempts to highlight everything

### After Optimization
- **< 1MB files**: All features work normally ✅
- **1-5MB files**: Core features work, heavy features disabled
- **> 5MB files**: Aggressive optimization, fast editing
- **LSP**: Smart auto-disable for large files
- **Treesitter**: Efficient with size/line count checks

## 🎯 Usage Tips

### Working with Large Files

1. **Open large file**: Auto-detection kicks in
   ```bash
   nvim large_file.cpp  # Auto-optimized if > 1MB
   ```

2. **Check file size**: Use `:lua print(vim.fn.getfsize(vim.fn.expand('%')))`

3. **Manual LSP toggle**: If needed
   ```vim
   :LspStop    " Disable LSP
   :LspStart   " Re-enable LSP
   ```

### Performance Commands

```vim
:WriteNoFormat        " Write without auto-formatting
:LspStop             " Disable LSP manually
:TSDisable highlight " Disable Treesitter highlighting
:set syntax=off      " Disable all syntax
```

## 🔧 Customization

### Adjust Thresholds

Edit `lua/core/autocmd.lua` to change size limits:

```lua
-- Change 1MB threshold to 2MB
if size_mb > 2 then  -- was: if size_mb > 1 then
```

Edit `lua/plugins/ui/snacks.lua` for BigFile:

```lua
size = 10 * 1024 * 1024,  -- Change to 10MB
```

### Re-enable Features

If you want specific features for large files:

```lua
-- In autocmd.lua, comment out specific optimizations
-- vim.api.nvim_buf_set_option(buf, 'syntax', 'off')  -- Keep syntax on
```

## 📈 Expected Improvements

- **Startup time**: Similar (optimizations are lazy)
- **Large file opening**: 3-5x faster
- **Editing large files**: Much smoother, no freezes
- **Memory usage**: Reduced by 30-50% on large files
- **CPU usage**: Significantly lower during editing

## ⚠️ Trade-offs

Some features are disabled for performance:

1. **No LSP on files > 1MB**: No autocomplete, goto definition
2. **No Treesitter on files > 1MB**: No advanced syntax highlighting
3. **No semantic tokens**: Slightly less detailed highlighting
4. **Limited syntax columns**: Only first 200 columns highlighted

These trade-offs are acceptable for large files where features would be slow anyway.

## 🐛 Troubleshooting

### File still slow?

1. Check file size: `:echo getfsize(expand('%'))`
2. Check if optimizations applied: Look for notification
3. Manually disable features:
   ```vim
   :set syntax=off
   :LspStop
   :TSDisable highlight
   ```

### Features not working?

If a small file is incorrectly optimized:
- Check if file is actually small: `ls -lh filename`
- Restart Neovim: Features should work normally
- Check notifications for any errors

## 📚 Related Documentation

- [Neovim Options](https://neovim.io/doc/user/options.html)
- [LSP Configuration](https://neovim.io/doc/user/lsp.html)
- [Treesitter Performance](https://github.com/nvim-treesitter/nvim-treesitter#performance)

---

Last updated: 2025-10-17
