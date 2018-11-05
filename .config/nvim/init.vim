set number
set tabstop=2
set softtabstop=2 expandtab
set shiftwidth=2
syntax on
noremap w b
inoremap <Nul> <C-n>

" For US(ANSI) Keyboard
nnoremap ; :
nnoremap : ;

autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

filetype plugin indent on

" Settings "

" Plugins "
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

Plug 'w0rp/ale' " Asynchronous Lint
Plug 'itchyny/lightline.vim' " Statusline
Plug 'tomtom/tcomment_vim' " Comment
Plug 'rhysd/vim-clang-format' " Code Format

Plug 'w0ng/vim-hybrid' " Color Scheme

" Syntax
Plug 'wannesm/wmgraphviz.vim' 
Plug 'kchmck/vim-coffee-script'
Plug 'rcmdnk/vim-markdown' 
Plug 'dag/vim-fish'

call plug#end()

packloadall
silent! helptags ALL

" Color
set background=dark
colorscheme hybrid
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


" Markdown
let g:vim_markdown_folding_disabled = 1
autocmd BufNewFile,BufRead *.page set filetype markdown

" C++
let g:clang_format#style_options = {
      \"Standard" : "C++11",
      \"AlignAfterOpenBracket" : "true",
      \"AlignConsecutiveAssignments" : "true",
      \"AlignTrailingComments" : "true",
      \"AllowShortBlocksOnASingleLine" : "true",
      \"PointerAlignment" : "Left",
      \"DerivePointerAlignment" : "false"
      \}
autocmd FileType c,cpp,objc nnoremap <Space><Space> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <Space><Space> :ClangFormat<CR>

" Javascript
au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
autocmd FileType javascript nnoremap <Space><Space> :ClangFormat<CR>
autocmd FileType javascript vnoremap <Space><Space> :ClangFormat<CR>

