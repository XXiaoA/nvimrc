local nmap = require("core.keymap").set_keymap("n")

nmap("<A-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
nmap("<A-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')

vim.g.Illuminate_ftblacklist = { "gitcommit", "neo-tree", "aerial", "dashboard" }
