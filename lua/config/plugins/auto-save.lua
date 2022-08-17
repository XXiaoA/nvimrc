local as = require("utils").requirePlugin("auto-save")
if not as then
    return
end

as.setup({
    condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        local file = vim.api.nvim_buf_get_name(0)
        if
            fn.getbufvar(buf, "&modifiable") == 1
            and utils.not_in(fn.getbufvar(buf, "&filetype"), {})
            and fn.findfile(file, ".") ~= ""
        then
            return true -- met condition(s), can save
        end
        return false -- can't save
    end,
    disabled_patterns = { "wezterm.lua" },
})
