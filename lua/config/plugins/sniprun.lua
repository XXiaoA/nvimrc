local sniprun = require("utils").requirePlugin("sniprun")

if sniprun and sniprun ~= true then
    sniprun.setup {
        display = {
            -- "Classic",
            -- "NvimNotify",
            "VirtualTextOk",
            "LongTempFloatingWindow"
        }
    }
end
