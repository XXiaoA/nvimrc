local Comment = require("utils").require_plugin("Comment")

if not Comment then
    return
end

Comment.setup({
    -- ignores empty lines
    ignore = "^$",
})
