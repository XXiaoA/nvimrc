local sniprun = require("utils").requirePlugin("sniprun")

if sniprun then
    sniprun.setup({
        display = {
            -- "Classic",
            -- "NvimNotify",
            "VirtualTextOk",
            "LongTempFloatingWindow",
        },
    })
end
