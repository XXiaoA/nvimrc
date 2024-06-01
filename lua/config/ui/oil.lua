return {
    "stevearc/oil.nvim",
    cmd = "Oil",
    init = function()
        if vim.fn.argc() == 1 then
            local stat = vim.uv.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("oil")
            end
        end
    end,
    keys = {
        { "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
    },
    opts = {
        delete_to_trash = true,
        keymaps = {
            ["<C-s>"] = false,
            ["<C-r>"] = "actions.refresh",
            ["<C-l>"] = "actions.select_vsplit",
            q = "actions.close",
        },
    },
    dependencies = { "nvim-web-devicons" },
}
