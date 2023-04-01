local function diff()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

return {
    "nvim-lualine/lualine.nvim",
    event = "BufEnter",
    dependencies = "nvim-web-devicons",
    opts = {
        options = {
            icons_enabled = true,
            theme = require("utils.yamler").get_value("lualine_theme"),
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
                function()
                    return vim.o.spell and "[SPELL]" or ""
                end,
            },
            lualine_x = { "filetype" },
            lualine_y = { "" },
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
        extensions = { "lazy" },
    },
}
