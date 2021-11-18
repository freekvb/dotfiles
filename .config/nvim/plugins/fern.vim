Plug 'lambdalisue/fern.vim'

" fern
nnoremap <leader>t :Fern ~ -drawer -width=30 -toggle<CR><C-w>=
nnoremap <leader>td :Fern . -reveal=% -drawer -width=30 -toggle<CR><C-w>=
let g:fern#disable_default_mappings     = 1
let g:fern#default_hidden               = 1

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> l <Plug>(fern-action-open-or-expand)
  nmap <buffer> M <Plug>(fern-action-mark-toggle)
  nmap <buffer> n <Plug>(fern-action-new-file)
  nmap <buffer> d <Plug>(fern-action-new-dir)
  nmap <buffer> r <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> <nowait> H <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> h <Plug>(fern-action-leave)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END