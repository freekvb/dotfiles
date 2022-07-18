Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }


" fzf

" find files by name in home directory
nnoremap <leader>ff :Files ~/<CR>
" find files by name in root directory
nnoremap <leader>fr :Files /<CR>
" find files by name in working directory
nnoremap <leader>fd :Files .<CR>
" find and switch buffers
nnoremap <leader>fb :Buffers<CR>
" find content in current file
nnoremap <leader>f :BLines<CR>
" find content in all buffers
nnoremap <leader>fa :Lines
" find git files in directory
nnoremap <leader>fG :GLines
" find content in all files
nnoremap <leader>fg :Rg<CR>

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Normal'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
