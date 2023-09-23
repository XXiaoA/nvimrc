return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    branch = "v3",
    opts = {},
    config = function(_, opts)
        require("ibl").setup(opts)
    end,
}
