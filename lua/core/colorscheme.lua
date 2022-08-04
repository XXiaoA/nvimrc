local M = {}
local colorschemes = {}

--- add_colorscheme
---@param name(string)
---@param tbl(table)
function M.add_colorscheme(name, tbl)
    if type(name) == "string" then
        table.insert(colorschemes, name)
    elseif type(name) == "table" then
        for _, v in pairs(name) do
            table.insert(colorschemes, v)
        end
    end

    if type(tbl) == "table" then
        require("core.packer").add_plugin(tbl)
    end
end

function M.change_colorscheme(colorscheme)
    if colorscheme then
        pcall(require, "config.colorscheme." .. colorscheme)
        pcall(vim.cmd, "colorscheme " .. colorscheme)
    end
end

function M.changeColorschemeUI()
    vim.ui.select(colorschemes, {
        prompt = "Select a colorscheme:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        M.change_colorscheme(choice)
    end)
end

return M
