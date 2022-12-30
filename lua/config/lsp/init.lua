local use = require("core.pack").add_plugin

-- lspconfig
use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    ft = {
        "lua",
        "python",
        "rust",
        "vim",
        "cpp",
    },
    dependencies = {
        "mason.nvim",
        "mason-lspconfig.nvim",
        "rust-tools.nvim",
    },
})

use({
    "williamboman/mason.nvim",
    branch = "main",
})
use({
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("config.lsp.mason")
        require("config.lsp.setup")
    end,
})

use({
    -- workspace library for sumneko_lua
    "ii14/emmylua-nvim",
})

use({
    "glepnir/lspsaga.nvim",
    event = "VeryLazy",
    config = function()
        require("config.lsp.lspsaga")
    end,
})

use({
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = "promise-async",
    config = function()
        require("config.lsp.ufo")
    end,
})

use({
    "kevinhwang91/promise-async",
})

use({
    "simrat39/rust-tools.nvim",
    ft = "rust",
})

use({
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
        require("config.lsp.illuminate")
    end,
})

use({
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = true,
})

use({
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
})
