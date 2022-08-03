local M = {}

M.descriptions = {}

---@param mode string|table
function M.set_keymap(mode)
    --- set a new keymap
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts table
    ---@param desc string
    return function(lhs, rhs, opts, desc)
        opts = opts or {}

        local options = vim.tbl_extend("force", {
            noremap = true,
            silent = true,
        }, opts)

        if type(desc) == "string" then
            M.descriptions[lhs] = desc
        end

        vim.keymap.set(mode, lhs, rhs, options)
    end
end

return M
