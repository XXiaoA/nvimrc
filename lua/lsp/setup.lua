local lsp_installer = require("utils").requirePlugin("nvim-lsp-installer")

-- 安装列表
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- { key: 语言 value: 配置文件 }
local servers = {
    sumneko_lua = require "lsp.lua", -- /lua/lsp/lua.lua
    pylsp = require "lsp.python", -- /lua/lsp/python.lua
    clangd = require "lsp.c",
    vimls = require "lsp.vim"
}


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
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
                -- 绑定快捷键
                require('keybindings').maplsp(buf_set_keymap)
            end
            opts.flags = {
                debounce_text_changes = 150,
            }
            server:setup(opts)
        end
    end)
end
