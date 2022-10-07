local M = {}

---@param mode string|table
function M.set_keymap(mode)
    --- set a new keymap
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts table
    return function(lhs, rhs, opts)
        opts = opts or {}

        local options = vim.tbl_extend("force", {
            noremap = true,
            silent = true,
        }, opts)

        vim.keymap.set(mode, lhs, rhs, options)
    end
end

M.nmap = M.set_keymap("n")
M.xmap = M.set_keymap("x")
M.omap = M.set_keymap("o")
M.imap = M.set_keymap("i")
M.tmap = M.set_keymap("t")

return M
