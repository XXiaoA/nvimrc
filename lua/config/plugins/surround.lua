local M = {
    "kylechui/nvim-surround",
    event = "VeryLazy",
}

M.config = function()
    local surround = require("utils").require("nvim-surround")
    if not surround then
        return
    end
    local config = require("nvim-surround.config")
    local buffer = require("nvim-surround.buffer")
    local utils = require("nvim-surround.utils")

    surround.setup({
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
        },
        surrounds = {
            ["q"] = {
                add = function()
                    local quotes = { '"', "'", "`" }
                    local selection_list = {}
                    local not_inside = true
                    for _, quote in ipairs(quotes) do
                        local cur_selection = config.get_selection({ motion = "a" .. quote })
                        if not cur_selection then
                            goto continue
                        end
                        cur_selection = {
                            left = {
                                first_pos = cur_selection.first_pos,
                                last_pos = cur_selection.first_pos,
                            },
                            right = {
                                first_pos = cur_selection.last_pos,
                                last_pos = cur_selection.last_pos,
                            },
                        }
                        local cursor = buffer.get_curpos()
                        if buffer.is_inside(cursor, cur_selection) then
                            table.insert(selection_list, cur_selection)
                            not_inside = false
                        end
                        ::continue::
                    end
                    if not_inside then
                        return { { quotes[1] }, { quotes[1] } }
                    else
                        local best_selection = utils.filter_selections_list(selection_list)
                        local best_text = buffer.get_text(best_selection.left)
                        local next_quote = vim.tbl_filter(function(value)
                            if value ~= best_text[1] then
                                return value
                            end
                        end, quotes)[1]
                        return { { next_quote }, { next_quote } }
                    end
                end,
            },
        },
    })
end

return M
