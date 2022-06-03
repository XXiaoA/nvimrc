local Comment = require("utils").requirePlugin("Comment")

if Comment and Comment ~= true then
    Comment.setup({
        -- ignores empty lines
        ignore = "^$",

        mappings = {
            extended = true,
        },
    })
end
