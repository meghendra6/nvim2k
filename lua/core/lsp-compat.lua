-- LSP Compatibility shim for Neovim 0.12+
-- This file patches deprecated APIs to prevent warnings in plugins that haven't updated yet

-- Suppress offset encoding warnings
-- These occur when multiple LSP servers use different encodings (ruff uses utf-8, others use utf-16)
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
    -- Suppress offset encoding warnings
    if type(msg) == 'string' and (
        msg:match('multiple different client offset_encodings detected') or
        msg:match('position_encoding param is required')
    ) then
        -- Silently ignore these warnings
        return
    end
    return original_notify(msg, level, opts)
end

-- Override vim.deprecate to silence specific deprecation warnings
local original_deprecate = vim.deprecate
vim.deprecate = function(name, alternative, version, plugin, backtrace)
    -- Silence known LSP deprecation warnings from plugins that haven't updated yet
    -- These plugins (lspsaga, snacks, ccc, neotest, nvim-nio) are being updated for 0.12
    if name and type(name) == 'string' then
        if name:match('client%.supports_method') or 
           name:match('client%.request') or
           name:match('client%.request_sync') then
            return
        end
    end
    
    -- Call the original deprecate for other warnings
    return original_deprecate(name, alternative, version, plugin, backtrace)
end

-- Additionally, patch client objects to add supports_method for compatibility
-- This provides the actual implementation so plugins work correctly
local function patch_lsp_clients()
    -- Only patch if vim.lsp.supports_method exists (Neovim 0.12+)
    if not vim.lsp.supports_method then
        return
    end

    -- Patch function to add supports_method to a client
    local function add_supports_method(client)
        if client and not rawget(client, 'supports_method') then
            client.supports_method = function(method, opts)
                return vim.lsp.supports_method(client, method, opts)
            end
        end
        return client
    end

    -- Intercept LspAttach to patch each client as it attaches
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_compat_shim', { clear = true }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            add_supports_method(client)
        end,
    })

    -- Wrap get_clients to add supports_method to all returned clients
    local original_get_clients = vim.lsp.get_clients
    if original_get_clients then
        vim.lsp.get_clients = function(filter)
            local clients = original_get_clients(filter)
            for _, client in ipairs(clients) do
                add_supports_method(client)
            end
            return clients
        end
    end

    -- Wrap get_active_clients for backwards compatibility
    local original_get_active_clients = vim.lsp.get_active_clients
    if original_get_active_clients then
        vim.lsp.get_active_clients = function(filter)
            local clients = original_get_active_clients(filter)
            for _, client in ipairs(clients) do
                add_supports_method(client)
            end
            return clients
        end
    end

    -- Wrap get_client_by_id
    local original_get_client_by_id = vim.lsp.get_client_by_id
    if original_get_client_by_id then
        vim.lsp.get_client_by_id = function(id)
            local client = original_get_client_by_id(id)
            return add_supports_method(client)
        end
    end
end

-- Set preferred offset encoding for LSP utilities
-- This prevents warnings about mixed encodings when using LSP utilities
local function setup_offset_encoding()
    -- Override LSP utility functions to use a consistent encoding
    local original_make_position_params = vim.lsp.util.make_position_params
    if original_make_position_params then
        vim.lsp.util.make_position_params = function(window, offset_encoding)
            -- Always use utf-16 as the fallback encoding if not specified
            offset_encoding = offset_encoding or 'utf-16'
            return original_make_position_params(window, offset_encoding)
        end
    end
    
    -- Set up autocmd to standardize encoding on LSP attach
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_encoding_compat', { clear = true }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
                -- Store the original encoding for reference
                client._original_offset_encoding = client.offset_encoding
                -- Note: We can't actually change the encoding after initialization,
                -- but we ensure utilities default to utf-16
            end
        end,
    })
end

-- Apply all patches
patch_lsp_clients()
setup_offset_encoding()

return {}
