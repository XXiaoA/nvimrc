local M = {}

M.requirePlugin = function(plugin_name)
    local status_ok, plugin = pcall(require, plugin_name)
    if not status_ok then
        vim.notify(" Failed to load: " .. plugin_name, vim.log.levels.WARN)
        return nil
    else
        return plugin
    end
end

return M
