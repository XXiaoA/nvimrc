local hlslens = require("utils").require_plugin("hlslens")
if not hlslens then
    return
end
require('hlslens').setup()

local map = require("core.keymap").set_keymap
local nmap = map("n")

nmap("n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
nmap("N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
nmap("*", [[*<Cmd>lua require('hlslens').start()<CR>N]])
nmap("#", [[#<Cmd>lua require('hlslens').start()<CR>N]])
nmap("g*", [[g*<Cmd>lua require('hlslens').start()<CR>N]])
nmap("g#", [[g#<Cmd>lua require('hlslens').start()<CR>N]])
