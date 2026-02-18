return {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        tabout = { enable = true, hopout = true },
        space2 = { enable = true },
        fastwarp = {
            multi = true,
            {},
            { faster = true, map = "<C-A-e>", cmap = "<C-A-e>" },
        },
        config_internal_pairs = {
            { "(", ")", nft = { "yuck" } },
            { "{", "}", nft = { "yuck" } },
            { "[", "]", nft = { "yuck" } },
        },
    },
}
