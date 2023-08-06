local M = {
    "kylechui/nvim-surround",
    event = "VeryLazy",
}

M.opts = function()
    local config = require("nvim-surround.config")
    return {
        keymaps = {
            insert = "<C-g>s",
            insert_line = "<C-g>S",
            normal = "sa",
            normal_cur = "ssa",
            normal_line = "sA",
            normal_cur_line = "ssA",
            visual = "sa",
            visual_line = "sA",
            delete = "sd",
            change = "sr",
            change_line = "sR",
        },
        surrounds = {
            -- remove the default configuration
            ["i"] = false,

            ["?"] = { -- TODO: Add find/delete/change functions
                add = function()
                    local left_delimiter = config.get_input("Enter the left delimiter: ")
                    local right_delimiter = left_delimiter
                        and config.get_input("Enter the right delimiter: ")
                    if right_delimiter then
                        return { { left_delimiter }, { right_delimiter } }
                    end
                end,
                find = function() end,
                delete = function() end,
            },
        },
    }
end

return M
