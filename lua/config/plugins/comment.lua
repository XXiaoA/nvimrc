local Comment = require("utils").require("Comment")

if not Comment then
    return
end

Comment.setup({
    -- ignores empty lines
    ignore = "^$",
})
