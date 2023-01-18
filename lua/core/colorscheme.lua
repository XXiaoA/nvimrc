local M = {}
local yamler = require("utils.yamler")
local swicher = require("utils.swicher")
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

--- get a random colorscheme in all colorschemes except current colorscheme
---@return string
function M.get_random_colorscheme()
    local all_colorschemes = vim.tbl_filter(function(value)
        if value ~= "random" and value ~= M.current_colorscheme() then
            return true
        end
    end, M.all_colorschemes)
    local random_index = (vim.fn.rand() % #all_colorschemes) + 1
    local colorscheme = all_colorschemes[random_index]
    return colorscheme
end

--- change the colorscheme
---@param colorscheme string
---@param expand boolean? Whether change the colorscheme of fish and wezterm
function M.load_colorscheme(colorscheme, expand)
    if colorscheme then
        pcall(require, "config.ui.colorschemes." .. colorscheme)
        local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
        if not status_ok then
            vim.notify("No find colorscheme: " .. colorscheme, vim.log.levels.WARN)
            return
        end
        yamler.modify_value("colorscheme", colorscheme)
        if expand then
            swicher.fish(swicher.colorschemes[colorscheme].fish)
            swicher.wezterm(swicher.colorschemes[colorscheme].wezterm)
        end
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
        local colorscheme = choice == "random" and M.get_random_colorscheme() or choice
        M.load_colorscheme(colorscheme, expand)
    end)
end

--- get current colorscheme
---@return string
function M.current_colorscheme()
    ---@diagnostic disable-next-line: return-type-mismatch
    return yamler.get_value("colorscheme")
end

function M.setup()
    local nmap = require("core.keymap").nmap
    require("config.ui.autocmd")
    vim.o.background = "dark"
    M.load_colorscheme(M.current_colorscheme())
    nmap("<leader>cc", M.load_colorscheme_ui, { desc = "Change ColorScheme" })
    nmap("<leader>ce", function ()
        M.load_colorscheme_ui(true)
    end, { desc = "Change ColorScheme with expand" })
end

return M
