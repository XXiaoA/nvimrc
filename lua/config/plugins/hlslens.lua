local hlslens = require("utils").requirePlugin("hlslens")
if not hlslens then
    return
end

local map = require("core.keymap").set_keymap
nmap = map("n")

nmap({
    "n",
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
})
nmap({
    "N",
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
})
nmap({ "*", [[*<Cmd>lua require('hlslens').start()<CR>N]] })
nmap({ "#", [[#<Cmd>lua require('hlslens').start()<CR>N]] })
nmap({ "g*", [[g*<Cmd>lua require('hlslens').start()<CR>N]] })
nmap({ "g#", [[g#<Cmd>lua require('hlslens').start()<CR>N]] })
