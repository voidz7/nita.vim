if !exists("g:nita_hide_syntax_item")
    let g:nita_hide_syntax_item = 0
endif


function! SyntaxItem() abort
    if g:nita_hide_syntax_item == 1
        return ""
    endif

    let l:syntaxname = synIDattr(synID(line("."), col("."), 1), "name")

    if l:syntaxname != ""
        return printf("%s ", l:syntaxname)
    else
        return ""
    endif
endfunction


function! Modified() abort
    if &modified
        return "[+]\ "
    else
        return ""
    endif
endfunction

set laststatus=2

function! ActiveStatusLine() abort
    let l:statusline=""
    let l:statusline.="%#Search#"
    let l:statusline.="\ %y"
    let l:statusline.="\ %r"
    let l:statusline.="%#CursorLineNr#"
    let l:statusline.="\ %F"
    let l:statusline.="%= "
    let l:statusline.="%#MoreMsg#"
    let l:statusline.="\ %m"
    let l:statusline.="%#SignColumn#"
    let l:statusline.="%{SyntaxItem()}"
    let l:statusline.="%#DiffChange#"
    let l:statusline.="\ %l/%L"
    let l:statusline.="\ [%c]"

    return l:statusline
endfunction

function! InactiveStatusLine() abort
    let l:statusline="%#TabLineSel#"
    let l:statusline=""
    let l:statusline.="%2*\ %t\ "
    let l:statusline.="%3*"

    return l:statusline
endfunction

function! SetActiveStatusLine() abort

    setlocal statusline=
    setlocal statusline+=%!ActiveStatusLine()
endfunction

function! SetInactiveStatusLine() abort

    setlocal statusline=
    setlocal statusline+=%!InactiveStatusLine()
endfunction

augroup statusline
    autocmd!
    autocmd WinEnter,BufEnter * call SetActiveStatusLine()
    autocmd WinLeave,BufLeave * call SetInactiveStatusLine()
augroup end

