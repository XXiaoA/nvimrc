return {
    "RRethy/vim-illuminate",
    event = { "VeryLazy", "LspAttach" },
    config = function()
        require("illuminate").configure({
            delay = 200,
            modes_allowlist = { "n" },
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        })
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
