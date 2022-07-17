local M = {}

--- require plugin and check if it exists
---@param plugin_name (string)
---@param message (bool)
---@return nil if plugin doesn't exists
function M.requirePlugin(plugin_name, message)
    local status_ok, plugin = pcall(require, plugin_name)
    if not status_ok and message ~= false then
        vim.notify(" Failed to load: " .. plugin_name .. " (From requirePlugin)", vim.log.levels.WARN)
        return nil
    else
        if plugin ~= true then
            return plugin
        end
    end
    return nil
end

--- read config in .config.yml
---@param option (string)
function M.readConfig(option)
    local file_path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/.config.yml"

    for line in io.lines(file_path) do
        value = line:match(option .. ": (.*)")
        if value then
            return value
        end
    end
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
