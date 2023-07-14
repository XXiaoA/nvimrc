local M = {
    "stevearc/aerial.nvim",
    keys = { "[f", "]f", "<leader>aa", "<leader>fa" },
}

M.config = function()
    local aerial = require("utils").require("aerial")
    if not aerial then
        return
    end

    aerial.setup({
        backends = { "lsp", "treesitter", "markdown" },
        icons = require("utils.lspkind").icons,
        filter_kind = {
            "Array",
            "Boolean",
            "Class",
            "Constant",
            "Constructor",
            "Enum",
            "EnumMember",
            "Event",
            "Field",
            "File",
            "Function",
            "Interface",
            "Key",
            "Method",
            "Module",
            "Namespace",
            "Null",
            "Number",
            "Object",
            "Operator",
            "Package",
            "Property",
            -- "String",
            "Struct",
            "TypeParameter",
            "Variable",
        },

        show_guides = true,
    })

    local nmap = require("core.keymap").set_keymap("n")
    nmap("[f", "<cmd>AerialPrev<CR>", { desc = "Jump to previous symbol" })
    nmap("]f", "<cmd>AerialNext<CR>", { desc = "Jump to next symbol" })
    nmap("<leader>aa", "<cmd>AerialToggle<CR>", { desc = "Toggle outline" })

    -- telescope support
    local telescope = require("utils").require("telescope")
    if telescope then
        telescope.load_extension("aerial")
        nmap("<leader>fa", "<cmd>Telescope aerial<cr>", { desc = "search document symbols" })
    end
end

return M
