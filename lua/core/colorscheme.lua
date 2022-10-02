local M = {}
local all_colorschemes = {}

--- add a new colorscheme
---@param name string|table: name of colorscheme
---@param plugin table|string: used by packer
function M.add_colorscheme(colorscheme, repo_name)
    repo_name = repo_name or colorscheme
    if type(colorscheme) == "string" then
        all_colorschemes[colorscheme] = repo_name
    elseif type(colorscheme) == "table" then
        for _, each_colorscheme in pairs(colorscheme) do
            all_colorschemes[each_colorscheme] = repo_name
        end
    end
end

function M.load_colorscheme(colorscheme)
    if colorscheme then
        if colorscheme == "random" then
            local random_index = (vim.fn.rand() % vim.tbl_count(all_colorschemes)) + 1
            colorscheme = vim.tbl_keys(all_colorschemes)[random_index]
        end
        local colorscheme_repo_name = all_colorschemes[colorscheme]

        pcall(vim.cmd.packadd, colorscheme_repo_name)
        pcall(require, "config.ui.colorschemes." .. colorscheme)
        pcall(vim.cmd.colorscheme, colorscheme)
    end
end

function M.load_colorscheme_ui()
    vim.ui.select(vim.tbl_keys(all_colorschemes), {
        prompt = "Select a colorscheme:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        M.load_colorscheme(choice)
    end)
end

return M
