return {
    "robitx/gp.nvim",
    event = "VeryLazy",
    opts = {
        chat_shortcut_respond = { modes = { "n", "x" }, shortcut = "<leader>r" },
        chat_shortcut_delete = { modes = { "n", "x" }, shortcut = "<leaderd" },
        chat_shortcut_stop = { modes = { "n", "x" }, shortcut = "<leader>s" },
        chat_shortcut_new = { modes = { "n", "x" }, shortcut = "<leader>n" },
    },
    keys = {
        { "<leader>pn", "<Cmd>GpChatNew split<CR>", desc = "New Chat" },
        { "<leader>pn", ":<C-u>'<,'>GpChatNew split<CR>", mode = { "x" }, desc = "New Chat" },
        { "<leader>pt", "<Cmd>GpChatToggle split<CR>", desc = "Toggle Chat" },
        { "<leader>pt", ":<C-u>'<,'>GpChatToggle split<CR>", mode = { "x" }, desc = "Toggle Chat" },
        { "<leader>pf", "<Cmd>GpChatFinder<CR>", desc = "Find Chat" },
        { "<leader>pp", ":<C-u>'<,'>GpChatPaste<CR>", mode = { "x" }, desc = "Chat Paste" },
    },
}
