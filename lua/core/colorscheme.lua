local M = {}
local all_colorschemes = {}

--- add a new colorscheme
---@param name string|table: name of colorscheme
---@param plugin table|string: used by packer
function M.add_colorscheme(name, plugin)
    if type(name) == "string" then
        table.insert(all_colorschemes, name)
    elseif type(name) == "table" then
        for _, v in pairs(name) do
            table.insert(all_colorschemes, v)
        end
    end

    if plugin then
        require("core.packer").add_plugin(plugin)
    end
end

function M.load_colorscheme(colorscheme)
    if colorscheme then
        if colorscheme == "random" then
            local random_index = (vim.fn.rand() % #all_colorschemes) + 1
            colorscheme = all_colorschemes[random_index]
        end
        pcall(require, "config.ui.colorschemes." .. colorscheme)
        pcall(vim.cmd.colorscheme, colorscheme)
    end
end

function M.load_colorscheme_ui()
    vim.ui.select(all_colorschemes, {
        prompt = "Select a colorscheme:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        M.load_colorscheme(choice)
    end)
end

return M
