vim.loader.enable()

local NVIM_VERSION = require("utils").get_nvim_version()
if NVIM_VERSION ~= "0.11.0" then
    vim.api.nvim_err_writeln("Your nvim version is unexpected")
else
    require("core")
end
