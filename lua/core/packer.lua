local M = {}
local plugins = {}

-- 在没有安装packer的电脑上，自动安装packer插件
function M.init_packer()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd("packadd packer.nvim")
    end
end

function M.load_plugins()
    return require("packer").startup(function()
        for _, plugin in ipairs(plugins) do
            use(plugin)
        end
    end)
end

function M.add_plugin(repo)
    table.insert(plugins, repo)
end

return M
