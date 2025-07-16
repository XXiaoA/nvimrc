local M = {}

--- Checks whether a given path exists and is a file.
---@param path string path to check
---@return boolean
function M.is_file(path)
    local stat = vim.uv.fs_stat(path)
    return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
---@param path string path to check
---@return  boolean
function M.is_directory(path)
    local stat = vim.uv.fs_stat(path)
    return stat and stat.type == "directory" or false
end

--- Remove string trim
---@param str string
---@param mode "all"|"head"|"tail"? default is `all`
---@return string
function M.trim(str, mode)
    mode = mode or "all"
    local regex = mode == "all" and "^%s*(.-)%s*$" or (mode == "tail" and "(.-)%s*$" or "^%s*(.-)")
    return str:match(regex)
end

return M
