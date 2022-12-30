local yamler = require("utils.yamler")
local M = {}
--- string[]
M.all_colorschemes = {}

--- Add new colorschemes
---@vararg string colorschemes
function M.add_colorscheme(...)
    if #... == 1 then
        table.insert(M.all_colorschemes, ...)
    else
        for _, colorscheme in ipairs({ ... }) do
            table.insert(M.all_colorschemes, colorscheme)
        end
    end
end

function M.load_colorscheme(colorscheme)
    if colorscheme then
        if colorscheme == "random" then
            local _all_colorschemes = vim.tbl_filter(function(value)
                if value ~= "random" and value ~= M.current_colorscheme() then
                    return true
                end
            end, M.all_colorschemes)
            local random_index = (vim.fn.rand() % #_all_colorschemes) + 1
            colorscheme = _all_colorschemes[random_index]
        end

        pcall(require, "config.ui.colorschemes." .. colorscheme)
        pcall(vim.cmd.colorscheme, colorscheme)
        yamler.modify_value("colorscheme", colorscheme)
    end
end

function M.load_colorscheme_ui()
    vim.ui.select(M.all_colorschemes, {
        prompt = "Select a colorscheme:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        M.load_colorscheme(choice)
    end)
end

function M.current_colorscheme()
    return yamler.get_value("colorscheme")
end

function M.init()
    require("config.ui.autocmd")
    vim.o.background = "dark"
    M.load_colorscheme(M.current_colorscheme())
    require("core.keymap").nmap(
        "<leader>cc",
        M.load_colorscheme_ui,
        { desc = "Change ColorScheme" }
    )
end

return M
