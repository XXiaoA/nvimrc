local lualine = require("utils").require_plugin("lualine")
if not lualine then
    return
end

local get_value = require("utils.yamler").get_value

local function spell()
    return vim.o.spell and "[SPELL]" or ""
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = get_value("lualine_theme"),
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
                source = diff_source,
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
