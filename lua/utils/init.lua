local M = {}

M.requirePlugin = function(plugin_name, message)
    local status_ok, plugin = pcall(require, plugin_name)
    if not status_ok then
        if message ~= false then
            vim.notify(" Failed to load: " .. plugin_name .. " (From requirePlugin)", vim.log.levels.WARN)
        end
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
        if lualine then
            lualine.setup({ options = { theme = colorscheme } })
        end
    end

    if colorscheme then
        pcall(require, "config/colorscheme/" .. colorscheme)
        pcall(vim.cmd, "colorscheme " .. colorscheme)
    end
end

M.readConfig = function(option)
    local file_path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/.config.yml"

    for line in io.lines(file_path) do
        value = line:match(option .. ": (.*)")
        if value then
            return value
        end
    end
end

-- Function for make mapping easier.
M.map = function(mode, lhs, rhs, opts)
    local options = {
        noremap = true,
        silent = true,
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

return M
