vim.cmd("cabbrev man <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Man' : 'man')<CR>")
