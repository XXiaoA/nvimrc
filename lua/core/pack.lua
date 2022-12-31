local colorscheme = require("core.colorscheme")
local M = {}

M.plugins = {}

function M.boot_strap()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
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

function M.load_plugins()
    local lazy = require("lazy")
    local opts = {
        defaults = { lazy = true },
        lockfile = vim.fn.stdpath("config") .. "/.lazy-lock.json",
        dev = {
            path = "~/Workspace",
            patterns = { "XXiaoA", "xxiaoa" },
        },
        ui = { border = "single" },
        install = {
            colorscheme = { colorscheme.current_colorscheme(), "habamax" },
        },
    }
    lazy.setup(M.plugins, opts)
    require("core.keymap").nmap("<leader>l", "<cmd>Lazy<cr>", { desc = lazy })
end

function M.add_plugin(repo)
    table.insert(M.plugins, repo)
end

return M
