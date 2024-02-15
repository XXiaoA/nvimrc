-- Function for make mapping easier.
local keymap = require("core.keymap")

local nmap = keymap.nmap
local imap = keymap.imap
local xmap = keymap.xmap
local tmap = keymap.tmap
local omap = keymap.omap

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Escape in terminal mode
tmap("<ESC>", [[<C-\><C-n>]])

-- Save or quit
nmap("<C-s>", ":w<CR>")
nmap("<C-q>", function()
    local ft = vim.api.nvim_get_option_value("ft", { buf = 0 })
    if ft == "TelescopePrompt" then
        vim.cmd("qall!")
    else
        vim.cmd.qall()
    end
end, { desc = "Quit the nvim" })

xmap("<", "<gv")
xmap(">", ">gv")

nmap("<c-w>-", "<C-W>s", { desc = "Split window below" })
nmap("<c-w>|", "<C-W>v", { desc = "Split window right" })
nmap("<c-w>\\", "<C-W>v", { desc = "Split window right" })

-- resize
nmap("<A-l>", ":vertical resize -2<CR>")
nmap("<A-h>", ":vertical resize +2<CR>")
nmap("<A-j>", ":resize -1<CR>")
nmap("<A-k>", ":resize +1<CR>")
nmap("<A-=>", "<C-w>=")

-- ctrl + hjkl  jump among windows
nmap("<C-h>", "<C-w>h", { desc = "Jump to left window" })
nmap("<C-j>", "<C-w>j", { desc = "Jump to below window" })
nmap("<C-k>", "<C-w>k", { desc = "Jump to above window" })
nmap("<C-l>", "<C-w>l", { desc = "Jump to right window" })
tmap("<C-h>", [[<C-\><C-n><C-W>h]])
tmap("<C-j>", [[<C-\><C-n><C-W>j]])
tmap("<C-k>", [[<C-\><C-n><C-W>k]])
tmap("<C-l>", [[<C-\><C-n><C-W>l]])

-- Toggle spelling check
nmap("<leader>sp", "<cmd>set spell!<CR>", { desc = "Toggle spelling check" })

imap("<M-o>", "<C-O>o")
imap("<M-O>", "<C-O>O")
imap("<M-h>", "<Left>")
imap("<M-l>", "<Right>")
imap("<M-H>", "<C-O>^")
imap("<M-L>", "<C-O>$")

nmap("H", "^")
nmap("L", "$")
omap("H", "^")
omap("L", "$")
xmap("H", "^")
xmap("L", "$")

nmap("<A-p>", "<cmd>pu<CR>")
nmap("<A-P>", "<cmd>pu!<CR>")

nmap("<leader>be", ":noh<CR>", { desc = "Erase Search Highlights" })
nmap("<leader>bn", ":enew<CR>", { desc = "New Buffer" })
nmap("<leader>bt", function()
    local winview = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(winview)
end, { desc = "Remove trailing white spaces" })

-- Remap for dealing with word wrap
nmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
nmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
xmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
xmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

imap(",", ",<c-g>u")
imap(".", ".<c-g>u")
imap(";", ";<c-g>u")
imap(":", ":<c-g>u")

-- https://github.com/mhinz/vim-galore#quickly-edit-your-macros
-- Quickly edit your macros
nmap(
    "<leader>m",
    [[:<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>]],
    { desc = "Modify the register" }
)

nmap("[t", "<CMD>tabNext<CR>", { desc = "Previous tab" })
nmap("]t", "<CMD>tabnext<CR>", { desc = "Next tab" })
nmap("<leader><tab><S-tab>", "[t", { remap = true, desc = "Previous tab" })
nmap("<leader><tab><tab>", "]t", { remap = true, desc = "Next tab" })
nmap("<leader><tab>n", "<CMD>tabnew<CR>", { desc = "Create a tab" })
nmap("<leader><tab>d", "<CMD>tabclose<CR>", { desc = "Close tab" })

imap("<C-v>", "<C-r>+", { desc = "Paste" })

keymap.set_keymap("s")("<BS>", "<BS>:startinsert<CR>")

-- Quickly add empty lines
-- https://github.com/tpope/vim-unimpaired/blob/6d44a6dc2ec34607c41ec78acf81657248580bf1/plugin/unimpaired.vim#L231-L254
nmap("<Plug>(unimpaired-blank-up)", function()
    local cmd = "put!=repeat(nr2char(10), v:count1)|silent ']+"
    if vim.bo.modifiable then
        cmd = cmd .. '|silent! call repeat#set("\\<Plug>(unimpaired-blank-up)", v:count1)'
    end
    vim.cmd(cmd)
end)
nmap("<Plug>(unimpaired-blank-down)", function()
    local cmd = "put =repeat(nr2char(10), v:count1)|silent '[-"
    if vim.bo.modifiable then
        cmd = cmd .. '|silent! call repeat#set("\\<Plug>(unimpaired-blank-down)", v:count1)'
    end
    vim.cmd(cmd)
end)
nmap("[<Space>", "<Plug>(unimpaired-blank-up)", { desc = "Add a empty line up" })
nmap("]<Space>", "<Plug>(unimpaired-blank-down)", { desc = "Add a empty line down" })

nmap("<ESC>", "<CMD>w|e|redraw<CR>")

imap("jj", "<ESC>")
