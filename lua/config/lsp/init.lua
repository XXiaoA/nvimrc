local mason_lspconfig = require("utils").requirePlugin("mason-lspconfig")
if not mason_lspconfig then
    return
end

-- 安装列表
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
    "sumneko_lua",
    "pylsp",
    "rust_analyzer",
    "vimls",
    "marksman",
}

mason_lspconfig.setup({
    ensure_installed = servers,
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({})
    end,
})

local nmap = require("core.keymap").set_keymap("n")

-- rename
nmap({ "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" })
-- code action
nmap({ "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>" })

-- go xx
nmap({ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" })
nmap({ "gh", "<cmd>lua vim.lsp.buf.hover()<CR>" })
nmap({ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" })
nmap({ "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" })
nmap({ "gr", "<cmd>lua vim.lsp.buf.references()<CR>" })

-- diagnostic
nmap({ "go", "<cmd>lua vim.diagnostic.open_float()<CR>" })
nmap({ "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>" })
nmap({ "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>" })
-- nmap({'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>'})
nmap({ "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>" })
nmap({ "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>" })
-- nmap({ '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>'})
-- nmap({ '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>'})
-- nmap({ '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'})
-- nmap({ '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>'})
