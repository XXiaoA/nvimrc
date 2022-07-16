local M = {}
local keymap = {}

function M.set_keymap(mode)
    return function(tbl)
        local options = {
            noremap = true,
            silent = true,
        }

        if #tbl >= 3 then
            options = vim.tbl_extend("force", options, tbl[3])
            if type(tbl[4]) == "string" then
                keymap[tbl[1]] = tbl[4]
            end
        end
        vim.keymap.set(mode, tbl[1], tbl[2], options)
    end
end

return M
