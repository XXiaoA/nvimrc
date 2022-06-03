-- Auto require all files in config
local all_files = vim.api.nvim_exec(
    [[echo split(globpath('$XDG_CONFIG_HOME/nvim/lua/config/plugins/', '*'), '\n')]],
    true
)
all_files = vim.api.nvim_eval(all_files)

for _, file in pairs(all_files) do
    local plugin_name = string.match(file, "lua/config/plugins/(.+).lua")

    if plugin_name ~= "init" then
        local status_ok, plugin = pcall(require, "config/plugins/" .. plugin_name)
        if not status_ok then
            vim.notify(" Failed to load file: lua/config/plugins/" .. plugin_name .. ".lua", vim.log.levels.WARN)
            vim.notify(plugin, vim.log.levels.WARN)
        end
    end
end
-- Load the cache
require("utils").requirePlugin("impatient")
