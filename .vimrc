"
" Default setting
"
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif


"
" Vundle
"
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
"set rtp+=~/.vim/vundle/
"#call vundle#rc()
" Program
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'AnsiEsc.vim'
" Utility
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'banyan/recognize_charcode.vim'
NeoBundle 'Shougo/neocomplcache'
" Syntax
NeoBundle 'haml.zip'
NeoBundle 'JavaScript-syntax'
NeoBundle 'jQuery'
NeoBundle 'nginx.vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'leshill/vim-json'
NeoBundle 'yuroyoro/vim-python'
NeoBundle 'yuroyoro/vim-scala'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-stylus'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
  \ }

filetype plugin indent on

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif



" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" " インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

"
" Module configuration
"
let g:Powerline_symbols = 'fancy'
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END
command! Pt :set paste!
set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー
set wildmode=list:full     " リスト表示，最長マッチ
set history=1000           " コマンド・検索パターンの履歴数
set complete+=k            " 補完に辞書ファイル追加



cnoremap <C-p> <Up>
cnoremap <Up>  <C-p>
cnoremap <C-n> <Down>
cnoremap <Down>  <C-n>

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
let g:quickrun_config._ = {'runner' : 'vimproc'}


imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

inoremap <expr><Up> neocomplcache#close_popup()."\<Up>"
inoremap <expr><Down> neocomplcache#close_popup()."\<Down>"
inoremap <expr><Left> neocomplcache#close_popup()."\<Left>"
inoremap <expr><Right> neocomplcache#close_popup()."\<Right>"

"
" Global configuration
"
set laststatus=2
set showcmd
set showmatch
set matchtime=1
set ignorecase
set smartcase
set wildmenu
set wildchar=<TAB>
set wildmode=full:list
set ruler
set number
set notitle
set autowrite
set hidden
set scrolloff=5
set history=50
set autoread
set incsearch
set hlsearch
set nowrap
set t_Co=256
nmap <ESC><ESC> ;nohlsearch<CR><ESC>
set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END


"
" Key remap
"
nnoremap ; :
set virtualedit=block
set backspace=indent,eol,start
set t_kD=[3~
set list
set listchars=tab:›\ ,eol:\ ,trail:~
if has('syntax')
  augroup InsertHook
  autocmd!
  autocmd InsertEnter * call s:StatusLine('Enter')
  autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif


"
" Status highlight
"
let g:hi_insert = 'highlight StatusLine ctermfg=white ctermbg=magenta cterm=none'
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction
function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


"
" Moveto last edited line
"
au BufWritePost * mkview
autocmd BufReadPost * loadview


"
" File handling
"
set fileencodings=utf-8
set fileformats=unix,dos
set encoding=utf-8
set fileformat=unix
filetype plugin on
au BufRead,BufNewFile *.twig  set ft=jinja.html
au BufRead,BufNewFile *.less  set ft=less
au BufRead,BufNewFile *.json  set ft=json
au BufRead,BufNewFile *.txt   set ft=markdown
au BufRead,BufNewFile *.txt   set foldmethod=marker
au BufRead,BufNewFile *.scala set ft=java.scala
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile /etc/nginx/configs/* set ft=nginx

"
" Coloring
"
syntax enable
let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1
set background=dark
colorscheme smyck
function! ActivateInvisibleIndicator()
  hi SpecialKey cterm=NONE ctermfg=darkgray guifg=darkgray
  hi ZenkakuSpace cterm=underline ctermfg=red gui=underline guifg=#FF0000
  match ZenkakuSpace /　/
endfunction
augroup InvisibleIndicator
  autocmd!
  autocmd BufEnter * call ActivateInvisibleIndicator()
augroup END


"
" Indentation
"
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 3
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=grey


"
" Remove trail
"
autocmd BufWritePre * :%s/\s\+$//ge

"
" Auto Commands
"
autocmd FileType quickrun AnsiEsc
autocmd BufWrite *.rb  :QuickRun
autocmd BufWrite *.js  :QuickRun
autocmd BufWrite *.coffee :QuickRun


"------------------------------------
"" indent_guides
"------------------------------------
"" インデントの深さに色を付ける
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1

hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
au FileType coffee,ruby,javascript,python IndentGuidesEnable
nmap <silent><Leader>ig <Plug>IndentGuidesToggle
