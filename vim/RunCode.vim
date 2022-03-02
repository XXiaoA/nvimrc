func! RunCode()
    exec "w"
    if &filetype == 'c'
        exec '!clang "%" -o "%<"'
        exec '!./"%<"'
    elseif &filetype == 'cpp'
        exec '!g++ "%" -o "%<"'
        exec '!./"#<"'
    elseif &filetype == 'python'
        exec '! python3 "%"'
    elseif &filetype == 'pyc'
        exec '! python3 "%"'
    elseif &filetype == 'java'
        " exec '!javac "%"'
        " exec '!java "%<"'
        exec '! java "%"'
    elseif &filetype == 'javascript'
        exec '!node "%"'
    elseif &filetype == 'sh'
        exec '!sh "%"'
    elseif &filetype == 'lua'
        exec '!lua "%"'
    endif
endfunc!
