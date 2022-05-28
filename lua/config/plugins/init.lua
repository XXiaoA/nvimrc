-- Auto require all files in config
local all_files =
    vim.api.nvim_exec([[echo split(globpath('$XDG_CONFIG_HOME/nvim/lua/config/plugins/', '*'), '\n')]], true)
all_files = vim.api.nvim_eval(all_files)

for _, file in pairs(all_files) do
    local plugin = string.match(file, "lua/config/plugins/(.+).lua")
    if plugin ~= "init" then
        if not pcall(require, "config/plugins/" .. plugin) then
            vim.notify(" Failed to load file: lua/config/plugins/" .. plugin .. ".lua", vim.log.levels.WARN)
        end
    end
end
-- Load the cache
require("utils").requirePlugin("impatient")
