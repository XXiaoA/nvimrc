local M = {}
local switcher = require("utils.theme_switcher")
--- string[]
M.all_colorschemes = {}
--- string
M.current_colorscheme = "everforest"

function M.modify_colorscheme(colorscheme)
    local file_path = vim.fn.stdpath("config") .. "/lua/core/colorscheme.lua"
    local _f = assert(io.open(file_path, "r"))
    local data = _f:read("*a")
    _f:close()

    local f = assert(io.open(file_path, "w"))
    data = data:gsub('M.current_colorscheme = "[^%%]-"', ('M.current_colorscheme = "%s"'):format(colorscheme))
    f:write(data)
    f:close()
end

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

--- get a random colorscheme in all colorschemes except current colorscheme
---@return string
function M.get_random_colorscheme()
    local all_colorschemes = vim.tbl_filter(function(value)
        if value ~= "random" and value ~= M.current_colorscheme then
            return true
        end
        return false
    end, M.all_colorschemes)
    local random_index = (vim.fn.rand() % #all_colorschemes) + 1
    local colorscheme = all_colorschemes[random_index]
    return colorscheme
end

--- change the colorscheme
---@param colorscheme string
---@param expand boolean? Whether change the colorscheme of fish and wezterm
function M.load_colorscheme(colorscheme, expand)
    if not colorscheme then
        return false
    end

    colorscheme = colorscheme == "random" and M.get_random_colorscheme() or colorscheme
    pcall(require, "config.ui.colorschemes." .. colorscheme)
    local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
    if not status_ok then
        vim.notify("No find colorscheme: " .. colorscheme, vim.log.levels.WARN)
        return
    end
    M.modify_colorscheme(colorscheme)
    if expand then
        switcher.fish(switcher.colorschemes[colorscheme].fish)
        switcher.wezterm(switcher.colorschemes[colorscheme].wezterm)
    end
end

--- choice a colorscheme with ui
---@param expand boolean?
function M.load_colorscheme_ui(expand)
    table.sort(M.all_colorschemes, function(a, b)
        return string.len(a) < string.len(b)
    end)
    vim.ui.select(M.all_colorschemes, {
        prompt = "Select a colorscheme:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        M.load_colorscheme(choice, expand)
    end)
end

function M.setup()
    local nmap = require("core.keymap").nmap
    require("config.ui.highlights")
    vim.opt.background = "dark"
    M.load_colorscheme(M.current_colorscheme)
    nmap("<leader>cc", M.load_colorscheme_ui, { desc = "Change ColorScheme" })
    nmap("<leader>ce", function()
        M.load_colorscheme_ui(true)
    end, { desc = "Change ColorScheme with expand" })
end

return M
