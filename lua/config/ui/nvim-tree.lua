return {
    "kyazdani42/nvim-tree.lua",
    event = "BufEnter",
    dependencies = "nvim-web-devicons",
    config = {
        view = {
            mappings = {
                list = {
                    { key = { "l" }, action = "edit" },
                    { key = { "s" }, action = "split" },
                    { key = { "v" }, action = "vsplit" },
                },
            },
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
    },

    keys = {
        { "<leader>nn", "<cmd>NvimTreeToggle<CR>" },
        {
            "<A-m>",
            function()
                require("nvim-tree").toggle(false, true)
            end,
            desc = "toggle nvim-tree",
        },
    },
}
