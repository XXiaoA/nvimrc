local use = require("core.packer").add_plugin

-- lspconfig
use({
    "neovim/nvim-lspconfig",
    config = function()
        require("config.lsp.setup")
    end,
})

use({
    "williamboman/mason.nvim",
    branch = "main",
    config = [[require("config.lsp.mason")]],
})
use({ "williamboman/mason-lspconfig.nvim" })

use({
    "ii14/emmylua-nvim",
    after = "nvim-lspconfig",
    ft = "lua",
})

use({
    "glepnir/lspsaga.nvim",
    after = "nvim-lspconfig",
    event = "BufWinEnter",
    config = function()
        require("config.lsp.lspsaga")
    end,
})

use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    event = "BufWinEnter",
    config = [[require("config.lsp.ufo")]],
})

use({
    "simrat39/rust-tools.nvim",
})

use({
    "RRethy/vim-illuminate",
    event = "BufWinEnter",
    config = [[require("config.lsp.illuminate")]],
})
