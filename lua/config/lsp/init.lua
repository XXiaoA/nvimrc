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
})

use({
    "williamboman/mason.nvim",
    after = "nvim-lspconfig",
    branch = "main",
})
use({
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
        require("config.lsp.mason")
        require("config.lsp.setup")
    end,
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
    after = "promise-async",
    config = [[require("config.lsp.ufo")]],
})

use({
    "kevinhwang91/promise-async",
    after = "nvim-lspconfig",
})

use({
    "simrat39/rust-tools.nvim",
    after = "nvim-lspconfig",
})

use({
    "RRethy/vim-illuminate",
    after = "nvim-lspconfig",
    config = [[require("config.lsp.illuminate")]],
})
