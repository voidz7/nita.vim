function! ReadOnly() abort
    if &readonly || !&modifiable
        return "\ \ [RO]"
    else
        return ""
    endif
endfunction

let g:currentmode={
    \ 'n'       : 'nor',
    \ 'no'      : 'nor·op',
    \ 'v'       : 'vis',
    \ 'V'       : 'v·L',
    \ "\<C-V>"  : 'v·B',
    \ 's'       : 'sel',
    \ 'S'       : 's·L',
    \ '^S'      : 's·B',
    \ 'i'       : 'ins',
    \ 'R'       : 'rep',
    \ 'Rv'      : 'v·rep',
    \ 'c'       : 'cmd',
    \ 'cv'      : 'vi.Ex',
    \ 'ce'      : 'Ex',
    \ 'r'       : 'prompt',
    \ 'rm'      : 'more',
    \ 'r?'      : 'confirm',
    \ '!'       : 'sh',
    \ 't'       : 'term'
    \}

function! Modified() abort
    if &modified
        return "\ \ [+]"
    else
        return ""
    endif
endfunction


let NERDTreeStatusline="%1*\ nerdtree\ %3*"

set laststatus=2

function! ActiveStatusLine() abort
    let l:line=''
    let l:line .= '%#SLMode#'
    let l:line .= ' %{g:currentmode[mode()]} '
    let l:line .= '%#SLActive#'
    let l:line .= ' %f  '
    let l:line .= '%y '
    let l:line .= ' %l/%L '
    let l:line .= '%#Blank#'
    let l:line .="%{ReadOnly()}"
    let l:line .="%{Modified()}"

    return l:line
endfunction

function! InactiveStatusLine() abort
    let l:statusline=""
    let l:statusline.="%2*\[%t\]"
    let l:statusline.="%3*"

    return l:statusline
endfunction

function! SetActiveStatusLine() abort
    if &ft ==? 'nerdtree'
        return
    endif

    setlocal statusline=
    setlocal statusline+=%!ActiveStatusLine()
endfunction

function! SetInactiveStatusLine() abort
    if &ft ==? 'nerdtree'
        return
    endif

    setlocal statusline=
    setlocal statusline+=%!InactiveStatusLine()
endfunction

augroup statusline
    autocmd!
    autocmd WinEnter,BufEnter * call SetActiveStatusLine()
    autocmd WinLeave,BufLeave * call SetInactiveStatusLine()
augroup end
