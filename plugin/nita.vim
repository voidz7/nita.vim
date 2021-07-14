" Syntax highlight group
function! SyntaxItem() abort
    let l:syntaxname = synIDattr(synID(line("."), col("."), 1), "name")

    if l:syntaxname != ""
        return printf(" %s ", l:syntaxname)
    else
        return ""
    endif
endfunction

" Readonly flag check
function! ReadOnly() abort
    if &readonly || !&modifiable
        return " [RO] "
    else
        return ""
    endif
endfunction

" Line percentage
function! LinePercent() abort
    return printf("%d%%", line('.') * 100 / line('$'))
endfunction


" Modified flag check
function! Modified() abort
    if &modified
        return " [+] "
    else
        return ""
    endif
endfunction

" File type
function! FileType() abort
    if len(&filetype) == 0
        return "text"
    endif

    return tolower(&filetype)
endfunction


" Always show statusline
set laststatus=2

" Format active statusline
function! ActiveStatusLine() abort
    " Reset statusline
    let l:statusline=""

    " Filename
    let l:statusline.="%1* %t "

    " Show if file is readonly
    let l:statusline.="%2*%{ReadOnly()}"

    " Show if file has been modified
    let l:statusline.="%2*%{Modified()}"


    " Show syntax identifier
    let l:statusline.="%2*%{SyntaxItem()}"

    " Split right
    let l:statusline.="%5*%="

    " Line percentage
    " let l:statusline.="%2* %{LinePercent()} "

    " Line numbers
    let l:statusline.="%2* \ %l/%L "

    " File type
    let l:statusline.="%1* %{FileType()} "

    " Done
    return l:statusline
endfunction

" Format inactive statusline
function! InactiveStatusLine() abort
    " Reset statusline
    let l:statusline=""

    " Filename
    let l:statusline.="%3* %t "

    " Blank
    let l:statusline.="%5*"

    " Done
    return l:statusline
endfunction

" Set active statusline
function! SetActiveStatusLine() abort
    if &ft ==? 'nerdtree'
        return
    endif

    setlocal statusline=
    setlocal statusline+=%!ActiveStatusLine()
endfunction

" Set inactive statusline
function! SetInactiveStatusLine() abort
    if &ft ==? 'nerdtree'
        return
    endif

    setlocal statusline=
    setlocal statusline+=%!InactiveStatusLine()
endfunction

" Autocmd statusline
augroup statusline
    autocmd!
    autocmd WinEnter,BufEnter * call SetActiveStatusLine()
    autocmd WinLeave,BufLeave * call SetInactiveStatusLine()
augroup end

