local M = {}

--- require plugin and check if it exists
---@param name string
---@param message boolean?
---@return unknown
function M.require(name, message)
    local status_ok, plugin = pcall(require, name)
    if not status_ok and message ~= false then
        local info = debug.getinfo(2, "Sl")
        local file = info.short_src
        local line = info.currentline
        local _hint = "require: Failed to load '%s'\n(%s: %d)"
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

---@return string
function M.get_root()
    local path = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0))
    ---@type string[]
    local roots = {}
    if path ~= "" then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace
                    and vim.tbl_map(function(ws)
                        return vim.uri_to_fname(ws.uri)
                    end, workspace)
                or client.config.root_dir and { client.config.root_dir }
                or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    ---@type string?
    local root = roots[1]
    if not root then
        path = path == "" and vim.loop.cwd() or vim.fs.dirname(path)
        ---@type string?
        root = vim.fs.find({ ".git" }, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

return M
