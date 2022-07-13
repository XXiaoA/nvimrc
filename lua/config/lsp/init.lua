local lsp_installer = require("utils").requirePlugin("nvim-lsp-installer")

-- 安装列表
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps

-- { key: 语言 value: 配置文件 }
local servers = {
    sumneko_lua = require("config.lsp.config.sumneko_lua"),
    pylsp = require("config.lsp.config.pylsp"),
    clangd = require("config.lsp.config.clangd"),
    vimls = require("config.lsp.config.vimls"),
    marksman = require("config.lsp.config.marksman"),
    rust_analyzer = require("config.lsp.config.rust_analyzer"),
}

function maplsp(mapbuf)
    local opt = {
        noremap = true,
        silent = true,
    }
    -- rename
    mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
    -- code action
    mapbuf("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)

    -- go xx
    mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
    mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
    mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
    mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
    mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)

    -- diagnostic
    mapbuf("n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
    mapbuf("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
    mapbuf("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
    -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
    mapbuf("n", "<gk>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
    mapbuf("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
    -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
end

-- 自动安装 LanguageServers
if lsp_installer then
    for name, _ in pairs(servers) do
        local server_is_found, server = lsp_installer.get_server(name)
        if server_is_found then
            if not server:is_installed() then
                print("Installing " .. name)
                server:install()
            end
        end
    end
    lsp_installer.on_server_ready(function(server)
        local opts = servers[server.name]
        if opts then
            opts.on_attach = function(_, bufnr)
                local function buf_set_keymap(...)
                    vim.api.nvim_buf_set_keymap(bufnr, ...)
                end
                -- 绑定快捷键
                maplsp(buf_set_keymap)
            end
            opts.flags = {
                debounce_text_changes = 150,
            }
            server:setup(opts)
        end
    end)
end
