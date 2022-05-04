local M = {}

M.requirePlugin = function(plugin_name)
    local status_ok, plugin_name = pcall(require, plugin_name)
    if not status_ok then
        vim.notify(" Failed to load: " .. plugin_name)
        return nil
    end
    return plugin_name
end

return M
