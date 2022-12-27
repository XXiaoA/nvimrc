local yamler = require("utils.yamler")
local utils = require("utils")
local M = {}
M.all_colorschemes = {}

--- Add a new colorscheme
---@param colorscheme string|table Name of colorscheme
---@param repo_name string Used by packadd
function M.add_colorscheme(colorscheme, repo_name)
    repo_name = repo_name or colorscheme
    if type(colorscheme) == "string" then
        M.all_colorschemes[colorscheme] = repo_name
    elseif type(colorscheme) == "table" then
        for _, each_colorscheme in pairs(colorscheme) do
            M.all_colorschemes[each_colorscheme] = repo_name
        end
    end
end

function M.load_colorscheme(colorscheme)
    if colorscheme then
        if colorscheme == "random" then
            local _all_colorschemes = utils.tbl_copy(M.all_colorschemes)
            _all_colorschemes["random"] = nil
            _all_colorschemes[yamler.get_value("color_scheme")] = nil
            local random_index = (vim.fn.rand() % vim.tbl_count(_all_colorschemes)) + 1
            colorscheme = vim.tbl_keys(_all_colorschemes)[random_index]
        end
        local colorscheme_repo_name = M.all_colorschemes[colorscheme]

        pcall(vim.cmd.packadd, colorscheme_repo_name)
        pcall(require, "config.ui.colorschemes." .. colorscheme)
        pcall(vim.cmd.colorscheme, colorscheme)
        yamler.modify_value("color_scheme", colorscheme)
    end
end

function M.load_colorscheme_ui()
    vim.ui.select(vim.tbl_keys(M.all_colorschemes), {
        prompt = "Select a colorscheme:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        M.load_colorscheme(choice)
    end)
end

return M
