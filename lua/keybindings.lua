-- Function for make mapping easier.
local map = require("utils").map


-- leader key 为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 退出终端插入模式
map("t", "<ESC>", [[<C-\><C-n>]])

-- 移动代码
map("n", "<A-up>", ":m .-2<cr>")
map("n", "<A-down>", ":m .+1<cr>")
map("i", "<A-up>", "<ESC>:m .-2<cr>i")
map("i", "<A-down>", "<ESC>:m .+1<cr>i")
map("v", "<A-up>", ":m '<-2<cr>gv")
map("v", "<A-down>", ":m '>+1<cr>gv")

-- 移动到行首/行末
map("i", "<C-h>", "<ESC>I")
map("i", "<C-l>", "<ESC>A")

-- 保存/退出
map("i", "<C-s>", "<ESC>:w<CR>")
map("i", "<C-q>", "<ESC>:qall<CR>")
map("n", "W", ":w<CR>")
map("n", "Q", ":qall<cr>")

-- ctrl u / ctrl + d  只移动10行，默认移动半屏
map("n", "<C-u>", "10k")
map("n", "<C-d>", "10j")

-- 输入模式/选择模式 jj/JJ 退出
map("v", "JJ", "<ESC>")
map("i", "jj", "<ESC>")
map("i", "JJ", "<ESC>")

-- visual模式下缩进代码
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 分屏快捷键
map("n", "sv", ":vsp<CR>")
map("n", "sh", ":sp<CR>")

-- 关闭当前
map("n", "sc", "<C-w>c")
-- 关闭其他
map("n", "so", "<C-w>o") -- close others

-- 比例控制
map("n", "s.", ":vertical resize +20<CR>")
map("n", "s,", ":vertical resize -20<CR>")
map("n", "s=", "<C-w>=")
map("n", "sj", ":resize +10<CR>")
map("n", "sk", ":resize -10<CR>")

-- ctrl + hjkl  窗口之间跳转
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("t", "<C-h>", [[<C-\><C-n><C-W>h]])
map("t", "<C-j>", [[<C-\><C-n><C-W>j]])
map("t", "<C-k>", [[<C-\><C-n><C-W>k]])
map("t", "<C-l>", [[<C-\><C-n><C-W>l]])

map("n", "<leader>i", "gg=G")
