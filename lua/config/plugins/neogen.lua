local neogen = require("utils").require_plugin("neogen")
if not neogen then
    return
end

neogen.setup({
    snippet_engine = "luasnip",
})
