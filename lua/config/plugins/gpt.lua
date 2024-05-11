return {
    "robitx/gp.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>pn", "<Cmd>GpChatNew split<CR>", desc = "New Chat" },
        { "<leader>pn", ":<C-u>'<,'>GpChatNew split<CR>", mode = { "x" }, desc = "New Chat" },
        { "<leader>pt", "<Cmd>GpChatToggle split<CR>", desc = "Toggle Chat" },
        { "<leader>pt", ":<C-u>'<,'>GpChatToggle split<CR>", mode = { "x" }, desc = "Toggle Chat" },
        { "<leader>pf", "<Cmd>GpChatFinder<CR>", desc = "Find Chat" },
        { "<leader>pp", ":<C-u>'<,'>GpChatPaste<CR>", mode = { "x" }, desc = "Chat Paste" },
    },
}
