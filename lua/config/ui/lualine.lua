local lualine = require("utils").require_plugin("lualine")
local utils = require("utils")

if not lualine then
    return
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
        lualine_b = { "diff", "diagnostics" }, -- "branch"
        lualine_c = { "filename" },
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
