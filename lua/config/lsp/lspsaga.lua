local saga = require("utils").requirePlugin("lspsaga")
if not saga then
    return
end

-- use custom config
saga.init_lsp_saga({})
