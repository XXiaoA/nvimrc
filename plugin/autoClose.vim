" Quit Nvim if we have only one window, and its filetype match our pattern.
function! s:quit_current_win() abort
    let l:quit_filetypes = ['NvimTree', 'aerial']

    let l:should_quit = v:true

    let l:tabwins = nvim_tabpage_list_wins(0)

    if len(l:tabwins) != 1
        let l:tabwins = l:tabwins[:-2]
    endif
    for w in l:tabwins
        let l:buf = nvim_win_get_buf(w)
        let l:bf = getbufvar(l:buf, '&filetype')

        if index(l:quit_filetypes, l:bf) == -1
            let l:should_quit = v:false
        endif
    endfor

    if l:should_quit
        qall
    endif
endfunction

augroup auto_close_win
    autocmd!
    autocmd BufEnter * call s:quit_current_win()
augroup END
