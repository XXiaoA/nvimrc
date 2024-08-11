return {
    "monkoose/neocodeium",
    event = "VeryLazy",
    opts = {
        silent = true,
    },
    keys = {
        -- stylua: ignore start
        { mode = "i", "<A-g>", function() require("neocodeium").accept() end },
        { mode = "i", "<A-w>", function() require("neocodeium").accept_word() end },
        { mode = "i", "<A-a>", function() require("neocodeium").accept_line() end },
        { mode = "i", "<A-n>", function() require("neocodeium").cycle_or_complete() end },
        { mode = "i", "<A-p>", function() require("neocodeium").cycle_or_complete(-1) end },
        { mode = "i", "<A-c>", function() require("neocodeium").clear() end },
        -- stylua: ignore end
    },
}
