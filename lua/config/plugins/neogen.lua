local neogen = require("utils").require_plugin("neogen")
if not neogen then
    return
end

local nmap = require("core.keymap").nmap
nmap("<leader>/", "<cmd>Neogen<CR>", { desc = "generate annotation" })

neogen.setup({
    snippet_engine = "luasnip",
})
