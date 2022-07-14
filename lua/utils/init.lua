local M = {}

function M.requirePlugin(plugin_name, message)
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

function M.changeColorscheme(colorscheme)
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

function M.readConfig(option)
    local file_path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/.config.yml"

    for line in io.lines(file_path) do
        value = line:match(option .. ": (.*)")
        if value then
            return value
        end
    end
end

-- Function for making mapping easier.
function M.map(mode, lhs, rhs, opts)
    local options = {
        noremap = true,
        silent = true,
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function M.is_file(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function M.is_directory(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "directory" or false
end

return M
