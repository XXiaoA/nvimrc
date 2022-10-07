local M = {}

--- require plugin and check if it exists
---@param plugin_name (string)
---@param message (boolean)
---@return any
function M.require_plugin(plugin_name, message)
    local status_ok, plugin = pcall(require, plugin_name)
    if not status_ok and message ~= false then
        local info = debug.getinfo(2, "Sl")
        local file = info.short_src
        local line = info.currentline
        local _hint = "require_plugin: Failed to load '%s'\n(%s: %d)"
        local hint = _hint:format(plugin_name, file, line)
        vim.notify(hint, vim.log.levels.WARN)
        return nil
    else
        if status_ok and plugin ~= true then
            return plugin
        end
    end
    return nil
end

--- Read the config from `config.yml`
---@param option string
---@return nil|boolean|string
function M.read_config(option)
    local file_path = vim.fn.stdpath("config") .. "/config.yml"

    for line in io.lines(file_path) do
        local value = line:match(option .. [[%s*:%s*([^%s]*)]])
        if value then
            value = value == "true" or value
            if value == "false" then
                value = false
            end
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

--- Get the current nvim version
---@return string
function M.get_nvim_version()
    local version = vim.version()
    local major = version.major
    local minor = version.minor
    local patch = version.patch
    local version = string.format("%d.%d.%d", major, minor, patch)

    return version
end

return M
