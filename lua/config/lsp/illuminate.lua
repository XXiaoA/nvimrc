return {
    "RRethy/vim-illuminate",
    event = { "VeryLazy", "LspAttach" },
    config = function()
        require("illuminate").configure({ delay = 200 })
    end,
    keys = {
        {
            "]]",
            function()
                require("illuminate").goto_next_reference()
            end,
            desc = "Next Reference",
        },
        {
            "[[",
            function()
                require("illuminate").goto_prev_reference()
            end,
            desc = "Prev Reference",
        },
    },
}
