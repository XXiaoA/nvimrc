local colorscheme = require("core.colorscheme")
local utils = require("utils")
local M = {}

M.plugins = {}

function M.boot_strap()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.uv.fs_stat(lazypath) then
        vim.notify("Start cloning lazy.nvim...")
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazypath,
        })
        vim.notify("Clone the lazy.nvim successfully")
    end
    vim.opt.runtimepath:prepend(lazypath)
end

--- add plugin
---@param plugins string|string[]|table[]
function M.add_plugin(plugins)
    if type(plugins) == "string" or type(plugins) == "table" then
        if #plugins > 1 and type(plugins[2]) == "table" then
            ---@diagnostic disable-next-line: param-type-mismatch
            for _, plugin in ipairs(plugins) do
                table.insert(M.plugins, plugin)
            end
        end
        table.insert(M.plugins, plugins)
    end
end

function M.auto_load_modules_packages()
    local config_path = vim.fn.stdpath("config") .. "/"

    for _, path in ipairs({
        config_path .. "lua/config/ui",
        config_path .. "lua/config/lsp",
        config_path .. "lua/config/plugins",
    }) do
        for _, file in ipairs(vim.fn.split(vim.fn.globpath(path, "*"), "\n")) do
            if
                not (
                    file:match("autocmd.lua$")
                    or file:match("setup.lua$")
                    or file:match("lsp/keymaps.lua$")
                )
            then
                local require_name = file:match("nvim/lua/(.*)%.lua")
                if require_name then
                    M.add_plugin(utils.require(require_name))
                end
            end
        end
    end
end

function M.setup()
    M.boot_strap()
    local lazy = require("lazy")
    local opts = {
        defaults = { lazy = true },
        lockfile = vim.fn.stdpath("config") .. "/.lazy-lock.json",
        diff = {
            cmd = "diffview.nvim",
        },
        dev = {
            path = "~/Workspace",
            patterns = { "XXiaoA", "xxiaoa" },
        },
        ui = { border = "single" },
        install = {
            colorscheme = { colorscheme.current_colorscheme, "habamax" },
        },
    }
    M.auto_load_modules_packages()
    lazy.setup(M.plugins, opts)
    require("core.keymap").nmap("<leader>ol", "<cmd>Lazy<cr>", { desc = "Lazy" })
end

return M
