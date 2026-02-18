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

--- Add a new keymap
---@param mode string|table
function M.keymap(mode)
    --- set a new keymap
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts table?
    return function(lhs, rhs, opts)
        opts = opts or {}

        local options = vim.tbl_extend("force", {
            noremap = true,
            silent = true,
        }, opts)

        vim.keymap.set(mode, lhs, rhs, options)
    end
end

M.nmap = M.keymap("n")
M.xmap = M.keymap("x")
M.omap = M.keymap("o")
M.imap = M.keymap("i")
M.tmap = M.keymap("t")

return M
