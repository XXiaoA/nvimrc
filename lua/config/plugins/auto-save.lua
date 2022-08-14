local as = require("utils").requirePlugin("auto-save")
if not as then
    return
end

as.setup({
    disabled_patterns = "wezterm.lua",
})
