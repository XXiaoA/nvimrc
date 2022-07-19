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

-- function maplsp(mapbuf)
--     local opt = {
--         noremap = true,
--         silent = true,
--     }
--     -- rename
--     mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
--     -- code action
--     mapbuf("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)

--     -- go xx
--     mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
--     mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
--     mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
--     mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
--     mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)

--     -- diagnostic
--     mapbuf("n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
--     mapbuf("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
--     mapbuf("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
--     -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
--     mapbuf("n", "<gk>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
--     mapbuf("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
--     -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
--     -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
--     -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
--     -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- end
