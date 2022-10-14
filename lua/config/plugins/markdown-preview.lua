vim.g.mkdp_auto_close = 0

-- open in new window
if vim.fn.executable("google-chrome-stable") == 1 then
    vim.cmd([[
    function OpenMarkdownPreview (url)
      execute "silent ! google-chrome-stable --new-window --app=" . a:url
    endfunction
    let g:mkdp_browserfunc = 'OpenMarkdownPreview'
    ]])
end
