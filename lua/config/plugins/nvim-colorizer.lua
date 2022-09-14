local colorizer = require("utils").require_plugin("colorizer")

if not colorizer then
    return
end
colorizer.setup({
    user_default_options = {
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "foreground", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false, -- Enable tailwind colors
        virtualtext = "■",
    },
})
