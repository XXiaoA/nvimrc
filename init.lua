local utils = require("utils")

local NVIM_VERSION = utils.get_nvim_version()
local EXPECTED_VERSION = { "0.8.0" }

require("core")

if not vim.tbl_contains(EXPECTED_VERSION, NVIM_VERSION) then
    vim.notify("Your nvim version is unexpected", vim.log.levels.ERROR)
end
