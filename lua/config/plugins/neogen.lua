local neogen = require("utils").requirePlugin("neogen")
if not neogen then
    return
end

neogen.setup({
    snippet_engine = "luasnip",
})
