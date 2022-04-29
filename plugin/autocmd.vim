" Exit nvim when we only have the following types of windows {{{
function! s:quit_current_win() abort
    let l:quit_filetypes = ['NvimTree', 'aerial']

    let l:should_quit = v:true

    let l:tabwins = nvim_tabpage_list_wins(0)

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
augroup END"}}}

" smart number from https://github.com/jeffkreeftmeijer/vim-numbertoggle{{{
augroup numbertoggle                                    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END"}}}
