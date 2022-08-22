vim.g.mkdp_auto_close = 0

-- open in new window
vim.cmd([[
function OpenMarkdownPreview (url)
  execute "silent ! google-chrome-stable --new-window --app=" . a:url

endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'
]])
