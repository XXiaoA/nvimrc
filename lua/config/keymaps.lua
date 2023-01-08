-- Function for make mapping easier.
local keymap = require("core.keymap")

local nmap = keymap.nmap
local imap = keymap.imap
local xmap = keymap.xmap
local tmap = keymap.tmap
local omap = keymap.omap

-- leader key 为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 退出终端插入模式
tmap("<ESC>", [[<C-\><C-n>]])

-- 移动代码
nmap("<A-up>", ":m .-2<cr>==")
nmap("<A-down>", ":m .+1<cr>==")
imap("<A-up>", "<ESC>:m .-2<cr>==a")
imap("<A-down>", "<ESC>:m .+1<cr>==a")
xmap("<A-up>", ":m '<-2<cr>gv=gv")
xmap("<A-down>", ":m '>+1<cr>gv=gv")

-- 保存/退出
imap("<C-s>", "<C-o>:w<CR>")
imap("<C-q>", "<C-o>:qall<CR>")
nmap("W", ":w<CR>")
nmap("Q", function()
    local ft = vim.api.nvim_buf_get_option(0, "ft")
    if ft == "TelescopePrompt" then
        vim.cmd("qall!")
    else
        vim.cmd.qall()
    end
end, { desc = "Quit the nvim" })

-- 输入模式/选择模式 jj/JJ 退出
xmap("JJ", "<ESC>")
imap("jj", "<ESC>")

-- visual模式下缩进代码
xmap("<", "<gv")
xmap(">", ">gv")

nmap("<leader>wo", "<C-W>o", { desc = "Only left one window" })
nmap("<leader>wd", "<C-W>c", { desc = "Delete current window" })
nmap("<leader>w-", "<C-W>s", { desc = "Split window below" })
nmap("<leader>w|", "<C-W>v", { desc = "Split window right" })
nmap("<leader>w\\", "<C-W>v", { desc = "Split window right" })

-- resize
nmap("<A-l>", ":vertical resize +2<CR>")
nmap("<A-h>", ":vertical resize -2<CR>")
nmap("<A-j>", ":resize +1<CR>")
nmap("<A-k>", ":resize -1<CR>")
nmap("<A-=>", "<C-w>=")

-- ctrl + hjkl  窗口之间跳转
nmap("<C-h>", "<C-w>h", { desc = "Jump to left window" })
nmap("<C-j>", "<C-w>j", { desc = "Jump to below window" })
nmap("<C-k>", "<C-w>k", { desc = "Jump to above window" })
nmap("<C-l>", "<C-w>l", { desc = "Jump to right window" })
tmap("<C-h>", [[<C-\><C-n><C-W>h]])
tmap("<C-j>", [[<C-\><C-n><C-W>j]])
tmap("<C-k>", [[<C-\><C-n><C-W>k]])
tmap("<C-l>", [[<C-\><C-n><C-W>l]])

nmap("<leader>i", "gg=G")

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

-- Remap for dealing with word wrap
nmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
nmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- BUG: doesn't work
imap(",", ",<c-g>u")
imap(".", ".<c-g>u")
imap(";", ";<c-g>u")

-- https://github.com/mhinz/vim-galore#quickly-edit-your-macros
-- Quickly edit your macros
nmap(
    "<leader>m",
    [[:<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>]]
)

-- Quickly add empty lines
nmap("[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>")
nmap("]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>")
