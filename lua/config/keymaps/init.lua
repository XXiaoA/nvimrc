-- Function for make mapping easier.
local map = require("core.keymap").set_keymap

local nmap = map("n")
local imap = map("i")
local xmap = map("x")
local tmap = map("t")
local omap = map("o")

-- leader key 为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 退出终端插入模式
tmap("<ESC>", [[<C-\><C-n>]])

-- 移动代码
nmap("<A-up>", ":m .-2<cr>")
nmap("<A-down>", ":m .+1<cr>")
imap("<A-up>", "<ESC>:m .-2<cr>i")
imap("<A-down>", "<ESC>:m .+1<cr>i")
xmap("<A-up>", ":m '<-2<cr>gv")
xmap("<A-down>", ":m '>+1<cr>gv")

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

-- 分屏快捷键
nmap("sv", ":vsp<CR>")
nmap("sh", ":sp<CR>")

-- 关闭当前
nmap("sc", "<C-w>c")
-- close others
nmap("so", "<C-w>o")

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
imap("<M-i>", "<Left>")
imap("<M-a>", "<Right>")
imap("<M-I>", "<C-O>^")
imap("<M-A>", "<C-O>$")

nmap("H", "^")
nmap("L", "$")
omap("H", "^")
omap("L", "$")
xmap("H", "^")
xmap("L", "$")

xmap("ir", 'i[')
xmap("ar", 'a[')
xmap("ia", 'i<')
xmap("aa", 'a<')
omap("ir", 'i[')
omap("ar", 'a[')
omap("ia", 'i<')
omap("aa", 'a<')
