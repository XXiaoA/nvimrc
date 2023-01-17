local utils = require("utils")
local path = vim.fn.stdpath("config") .. "/lua/scripts/"
local files = vim.fn.split(vim.fn.globpath(path, "*"), "\n")
for _, file in ipairs(files) do
    if not file:match("init.lua$") then
        local require_name = file:match("nvim/lua/(.*)%.lua")
        if require_name then
            utils.require(require_name)
        end
    end
end
