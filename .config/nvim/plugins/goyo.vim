
Plug 'junegunn/goyo.vim'                 " distraction free writing

" toggle goyo
nnoremap <leader>g :Goyo<CR>
function! s:goyo_enter()
    set scrolloff=999
    set nocursorline
    set nocursorcolumn
    set colorcolumn=0
endfunction
function! s:goyo_leave()
    set scrolloff=10
    set cursorline
    hi CursorLine cterm=NONE ctermfg=NONE ctermbg=237
    hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=237
    set cursorcolumn
    hi CursorColumn ctermbg=237
    set colorcolumn=79
    hi ColorColumn ctermbg=237
    hi NormalColor cterm=bold ctermbg=7 ctermfg=237
"    set statusline+=%#NormalColor#%{(g:currentmode[mode()]=='n')?'\ \ normal\ ':''}
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

