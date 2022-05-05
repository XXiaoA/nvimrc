-- Auto require all files in plugin-config
local all_files =
    vim.api.nvim_exec([[echo split(globpath('$XDG_CONFIG_HOME/nvim/lua/plugin-config/', '*'), '\n')]], true)
all_files = vim.api.nvim_eval(all_files)

for _, file in pairs(all_files) do
    local plugin = string.match(file, "plugin.config/(.+).lua")
    if plugin ~= "init" then
        require(string.format("plugin-config/%s", plugin))
    end
end
-- Load the cache
require("utils").requirePlugin("impatient")
