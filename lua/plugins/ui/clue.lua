return {
    "echasnovski/mini.clue",
    event = "VeryLazy",
    config = function()
        local miniclue = require("mini.clue")
        miniclue.setup({
            clues = {
                { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
                { mode = "n", keys = "<leader><tab>", desc = "+Tab" },
                { mode = "n", keys = "<leader>a", desc = "+Aerial" },
                { mode = "n", keys = "<leader>c", desc = "+Colorscheme" },
                { mode = "n", keys = "<leader>f", desc = "+Find" },
                { mode = "n", keys = "<leader>o", desc = "+Open" },
                { mode = "n", keys = "<leader>g", desc = "+Git" },
                { mode = "n", keys = "<leader>gt", desc = "+Toggle" },
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),
            },
            triggers = {
                { mode = "n", keys = "<Leader>" }, -- Leader triggers
                { mode = "x", keys = "<Leader>" },
                { mode = "n", keys = "[" }, -- mini.bracketed
                { mode = "n", keys = "]" },
                { mode = "x", keys = "[" },
                { mode = "x", keys = "]" },
                { mode = "i", keys = "<C-x>" }, -- Built-in completion
                { mode = "n", keys = "g" }, -- `g` key
                { mode = "x", keys = "g" },
                { mode = "n", keys = "'" }, -- Marks
                { mode = "n", keys = "`" },
                { mode = "x", keys = "'" },
                { mode = "x", keys = "`" },
                { mode = "n", keys = '"' }, -- Registers
                { mode = "x", keys = '"' },
                { mode = "i", keys = "<C-r>" },
                { mode = "c", keys = "<C-r>" },
                { mode = "n", keys = "<C-w>" }, -- Window commands
                { mode = "n", keys = "z" }, -- `z` key
                { mode = "x", keys = "z" },
            },
            window = {
                delay = 400,
                config = {
                    width = "auto",
                    border = "rounded",
                },
            },
        })
    end,
}
