local M = {}

--- require plugin and check if it exists
---@param name string
---@param message boolean?
---@return any
function M.require(name, message)
    local status_ok, plugin = pcall(require, name)
    if not status_ok and message ~= false then
        local info = debug.getinfo(2, "Sl")
        local file = info.short_src
        local line = info.currentline
        local _hint = "require_plugin: Failed to load '%s'\n(%s: %d)"
        local hint = _hint:format(name, file, line)
        vim.notify(hint, vim.log.levels.WARN)
        return nil
    else
        if status_ok and plugin ~= true then
            return plugin
        end
    end
    return nil
end

--- Checks whether a given path exists and is a file.
---@param path string path to check
---@return boolean
function M.is_file(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
---@param path string path to check
---@return  boolean
function M.is_directory(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "directory" or false
end

--- Get the current nvim version
---@return string
function M.get_nvim_version()
    local version = vim.version()
    return string.format("%d.%d.%d", version.major, version.minor, version.patch)
end

--- Remove string trim
---@param str string
---@param mode "all"|"head"|"tail"?
---@return string
function M.trim(str, mode)
    mode = mode or "all"
    local regex = mode == "all" and "^%s*(.-)%s*$" or (mode == "tail" and "(.-)%s*$" or "^%s*(.-)")
    return str:match(regex)
end

return M
