local p = require("themes.cedar.palette").get()

local a = function(hue)
    return { fg = p.on_accent, bg = hue, gui = "bold" }
end
local b = { fg = p.fg, bg = p.bg_hl }
local c = { fg = p.fg_alt, bg = p.bg_dim }
local inactive = { fg = p.grey, bg = p.bg_dim }

return {
    normal = { a = a(p.blue), b = b, c = c },
    insert = { a = a(p.green), b = b, c = c },
    visual = { a = a(p.violet), b = b, c = c },
    replace = { a = a(p.red), b = b, c = c },
    command = { a = a(p.teal), b = b, c = c },
    terminal = { a = a(p.orange), b = b, c = c },
    inactive = { a = inactive, b = inactive, c = inactive },
}
