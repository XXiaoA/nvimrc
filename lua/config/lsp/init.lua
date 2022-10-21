local use = require("core.packer").add_plugin

-- lspconfig
use({
    "neovim/nvim-lspconfig",
    ft = {
        "lua",
        "python",
        "rust",
        "vim",
        "cpp",
    },
    config = function()
        require("config.lsp.setup")
    end,
})

use({
    "williamboman/mason.nvim",
    after = "nvim-lspconfig",
    branch = "main",
})
use({
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = [[require("config.lsp.mason")]],
})

use({
    "ii14/emmylua-nvim",
    after = "nvim-lspconfig",
    ft = "lua",
})

use({
    "glepnir/lspsaga.nvim",
    after = "nvim-lspconfig",
    config = function()
        require("config.lsp.lspsaga")
    end,
})

use({
    "kevinhwang91/nvim-ufo",
    after = "nvim-lspconfig",
    requires = "kevinhwang91/promise-async",
    config = [[require("config.lsp.ufo")]],
})

use({
    "simrat39/rust-tools.nvim",
})

use({
    "RRethy/vim-illuminate",
    after = "nvim-lspconfig",
    config = [[require("config.lsp.illuminate")]],
})
