--- Collect group definitions from all modules and apply them.
local M = {}

function M.apply()
    local p = require("themes.cedar.palette").get()

    local modules = {
        "themes.cedar.groups.editor",
        "themes.cedar.groups.syntax",
        "themes.cedar.groups.treesitter",
        "themes.cedar.groups.integrations",
    }

    for _, mod in ipairs(modules) do
        for group, spec in pairs(require(mod).get(p)) do
            vim.api.nvim_set_hl(0, group, spec)
        end
    end
end

return M
