local hlslens = require("utils").requirePlugin("hlslens", false)
if not hlslens then
    return nil
end

local map = require("utils").map

map("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
map("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>N]])
map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>N]])
map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>N]])
map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>N]])
