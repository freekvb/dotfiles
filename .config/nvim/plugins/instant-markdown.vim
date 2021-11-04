Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

let g:instant_markdown_browser = "qutebrowser --target window"
let g:instant_markdown_autostart = 0
nnoremap md :InstantMarkdownPreview<CR>
nnoremap mds :InstantMarkdownStop<CR>
