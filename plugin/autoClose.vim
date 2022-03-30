function s:autoClose()
    let l:closeFileTypes = ['NvimTree', 'aerial']
    let l:shouldQuit = v:true
    let l:tabwins = nvim_tabpage_list_wins(0)
    for i in l:tabwins
        let l:buf = nvim_win_get_buf(i)
        let l:bf = getbufvar(l:buf, '&filetype')
        if index(l:closeFileTypes, l:bf) == -1
            let l:shouldQuit = v:false
        endif
    endfor
    if l:shouldQuit == v:true
        qall
    endif
endfunction

augroup AUTOClose
    autocmd WinEnter * call s:autoClose()
augroup END
