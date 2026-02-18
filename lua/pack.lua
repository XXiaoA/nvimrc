local M = {}

M.plugin_specs = {}

--- Add plugin
---@param spec any
function M.add_plugin(spec)
    if type(spec) ~= "table" then
        return
    end
    if type(spec[1]) == "table" then
        vim.list_extend(M.plugin_specs, spec)
    else
        table.insert(M.plugin_specs, spec)
    end
end

local base_path = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins")
local offset = #base_path + 2

---@param path string
local function scan_modules(path)
    local handle = vim.uv.fs_scandir(path)
    if not handle then
        return {}
    end

    while true do
        local name, t = vim.uv.fs_scandir_next(handle)
        if not name then
            break
        end
        local fname = vim.fs.joinpath(path, name)
        local ftype = t or vim.uv.fs_stat(fname).type
        if ftype == "directory" then
            scan_modules(fname)
        elseif ftype == "file" and name:sub(-4) == ".lua" then
            local require_result = require("plugins/" .. fname:sub(offset, -5))
            if type(require_result) ~= "table" then
                vim.notify("fail to load plugins/" .. fname:sub(offset, -5) .. ", the file must return a table")
            else
                M.add_plugin(require_result)
            end
        end
    end
end

scan_modules(base_path)

---@diagnostic disable-next-line: param-type-mismatch
local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")
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

require("lazy").setup(M.plugin_specs, {
    defaults = { lazy = true },
    lockfile = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy-lock.json"),
    diff = {
        cmd = "diffview.nvim",
    },
    dev = {
        path = "~/Workspace",
        patterns = { "XXiaoA", "xxiaoa" },
        fallback = true,
    },
    ui = {
        -- https://github.com/folke/lazy.nvim/pull/2072
        backdrop = 100,
        border = "rounded",
    },
    install = {
        colorscheme = { require("colorscheme").current_colorscheme, "habamax" },
    },
})

require("utils").nmap("<leader>ol", "<cmd>Lazy<cr>", { desc = "Lazy" })

return M
