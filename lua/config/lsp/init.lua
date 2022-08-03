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
    event = "VimEnter",
})

-- lsp_signature
use({
    "ray-x/lsp_signature.nvim",
})

use({
    "XXiaoA/lspsaga.nvim",
    branch = "main",
})

use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
})

require("config.lsp.setup")
