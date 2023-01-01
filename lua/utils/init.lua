local M = {}

--- require plugin and check if it exists
---@param plugin_name string
---@param message boolean?
---@return table?
function M.require(plugin_name, message)
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

--- compare two table
---@param t1 table
---@param t2 table
---@param ignore_mt boolean? if ignore metatable or not ( default is false )
---@return boolean
--- from https://web.archive.org/web/20131225070434/http://snippets.luacode.org/snippets/Deep_Comparison_of_Two_Values_3
function M.tbl_isequal(t1, t2, ignore_mt)
    ignore_mt = ignore_mt or false
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then
        return false
    end
    -- non-table types can be directly compared
    if ty1 ~= "table" and ty2 ~= "table" then
        return t1 == t2
    end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then
        return t1 == t2
    end
    for k1, v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not M.tbl_isequal(v1, v2) then
            return false
        end
    end
    for k2, v2 in pairs(t2) do
        local v1 = t1[k2]
        if v1 == nil or not M.tbl_isequal(v1, v2) then
            return false
        end
    end
    return true
end

--- deep copy a table
---@param orig table
---@return table
function M.tbl_copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[M.tbl_copy(orig_key)] = M.tbl_copy(orig_value)
        end
        setmetatable(copy, M.tbl_copy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

return M
