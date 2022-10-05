local lualine = require("utils").require_plugin("lualine")
if not lualine then
    return
end

local utils = require("utils")
local function spell()
    return vim.o.spell and "[SPELL]" or ""
end

local function diff()
    local git_status = vim.b.gitsigns_status_dict
    if git_status == nil then
        return
    end

    local modify_num = git_status.changed
    local remove_num = git_status.removed
    local add_num = git_status.added

    local info = { added = add_num, modified = modify_num, removed = remove_num }
    return info
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = utils.read_config("lualine_theme"),
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        component_separators = "",
        section_separators = "",
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "diff",
                source = diff,
            },
            "diagnostics",
        },
        lualine_c = {
            "filename",
            spell,
        },
        lualine_x = { "filetype" }, -- "encoding", "fileformat"
        lualine_y = { "" }, -- "progress"
        lualine_z = { "location" },
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
