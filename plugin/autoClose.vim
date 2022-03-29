function s:autoClose(ftype)
    if winnr('$') >= 1 && getbufvar(winbufnr(winnr()), "&filetype") == a:ftype |qall|endif
endfunction

augroup AUTOClose
    " 退出侧边等
    autocmd WinEnter * call s:autoClose('NvimTree')
    autocmd WinEnter * call s:autoClose('aerial')
augroup END
