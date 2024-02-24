return {
    "stevearc/aerial.nvim",
    keys = {
        { "[f", "<cmd>AerialPrev<CR>", desc = "Previous symbol" },
        { "]f", "<cmd>AerialNext<CR>", desc = "Next symbol" },
        { "<leader>aa", "<cmd>AerialToggle<CR>", desc = "Toggle aerial" },
    },
    opts = {
        backends = { "lsp", "treesitter", "markdown" },
        icons = require("utils.lspkind").icons,
        show_guides = true,
    },
}
