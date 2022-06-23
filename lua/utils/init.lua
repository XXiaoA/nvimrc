local M = {}

M.requirePlugin = function(plugin_name)
    local status_ok, plugin = pcall(require, plugin_name)
    if not status_ok then
        vim.notify(" Failed to load: " .. plugin_name, vim.log.levels.WARN)
        return nil
    else
        if plugin ~= true then
            return plugin
        end
    end
    return nil
end

M.changeColorscheme = function(colorscheme)
    -- the theme has lualine's colorscheme
    local lualine_theme = { "nightfox", "gruvbox-material" }

    if vim.tbl_contains(lualine_theme, colorscheme) then
        local lualine = require("utils").requirePlugin("lualine")
        lualine.setup({ options = { theme = colorscheme } })
    end

    if colorscheme then
        pcall(require, "config/colorscheme/" .. colorscheme)
        pcall(vim.cmd, "colorscheme " .. colorscheme)
    end
end

return M
