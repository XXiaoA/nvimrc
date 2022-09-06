local M = {}
local packer_bootstrap

M.plugins = {}

-- 在没有安装packer的电脑上，自动安装packer插件
function M.init_packer()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        vim.notify("Start cloning packer.nvim...")
        packer_bootstrap = fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
        vim.notify("Clone the packer.nvim successfully")
    end
end

function M.load_plugins()
    return require("packer").startup({
        function(use)
            for _, plugin in ipairs(M.plugins) do
                use(plugin)
            end

            -- Put this at the end after all plugins
            if packer_bootstrap then
                require("packer").sync()
            end
        end,

        config = {
            display = {
                open_fn = function()
                    return require("packer.util").float({ border = "single" })
                end,
            },
        },
    })
end

function M.add_plugin(repo)
    table.insert(M.plugins, repo)
end

return M
