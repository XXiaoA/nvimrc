local use = require("core.packer").add_plugin

-- lspconfig
use({ "neovim/nvim-lspconfig" })

use({
    "williamboman/mason.nvim",
    branch = "main",
    config = function()
        require("config.lsp.mason")
    end,
})
use({ "williamboman/mason-lspconfig.nvim" })

use({
    "ii14/emmylua-nvim",
    event = "VimEnter",
})

-- lsp_signature
use({
    "ray-x/lsp_signature.nvim",
    after = "emmylua-nvim",
    config = "require('config.lsp.lsp-signature')",
})

use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    after = "emmylua-nvim",
    config = [[require("config.lsp.lspsaga")]],
})

use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    event = "VimEnter",
    config = [[require("config.lsp.ufo")]],
})

require("config.lsp.setup")
