return function()
    local ok, render_markdown = pcall(require, 'render-markdown')
    if not ok then
        return
    end

    render_markdown.setup({
        -- Use defaults; other plugins (treesitter, web-devicons) already present.
    })
end
