local utils = require("utils")
local NVIM_VERSION = utils.get_nvim_version()

if NVIM_VERSION ~= "0.8.0" then
    vim.api.nvim_err_writeln("Your nvim version is unexpected")
else
    require("core")
end
