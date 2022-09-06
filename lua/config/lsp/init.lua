local use = require("core.packer").add_plugin

-- lspconfig
use({ "neovim/nvim-lspconfig" })

use({
    "williamboman/mason.nvim",
    branch = "main",
    config = [[require("config.lsp.mason")]],
})
use({ "williamboman/mason-lspconfig.nvim" })

use({
    "ii14/emmylua-nvim",
    ft = "lua",
})

use({
    "glepnir/lspsaga.nvim",
    branch = "main",
})

use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = [[require("config.lsp.ufo")]]
})

use({
    "simrat39/rust-tools.nvim",
})

use({
    "RRethy/vim-illuminate",
    config = [[require("config.lsp.illuminate")]],
})

require("config.lsp.setup")
