local tr = require("utils").require_plugin("nvim-tree")
if not tr then
    return
end

local nmap = require("core.keymap").set_keymap("n")
nmap("<leader>nn", "<cmd>NvimTreeFocus<CR>")
nmap("<leader>nf", "<cmd>NvimTreeFindFile<CR>")
nmap("<A-m>", "<cmd>NvimTreeToggle<cr>")
nmap("<leader>nt", function()
    return require("nvim-tree").toggle(false, true)
end, { desc = "toggle nvim-tree" })

tr.setup({
    view = {
        mappings = {
            list = {
                { key = { "l" }, action = "edit" },
                { key = { "s" }, action = "split" },
                { key = { "v" }, action = "vsplit" },
            },
        },
    },
})
