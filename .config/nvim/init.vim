set number
set tabstop=2
set softtabstop=2 expandtab
set shiftwidth=2
syntax on
noremap w b
nnoremap ; :
nnoremap : ;
inoremap <Nul> <C-n>


" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

" Settings "

" Color
set background=dark
colorscheme hybrid
highlight Normal ctermbg=none
highlight LineNr ctermfg=grey

" Indent
" let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Unite
let g:unite_enable_smart_case = 1

" neomake
autocmd! BufWritePost * Neomake
let g:neomake_cpp_enable_markers=['clang']
let g:neomake_cpp_clang_args = ["-std=c++14", "-Wextra", "-Wall", "-fsanitize=undefined","-g"]

" Complete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path="/usr/lib/libclang.so"

" vim-session(save session)
let g:session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
let g:session_autoload = 'yes'
let g:session_autosave = 'no'
autocmd! BufWritePost * SaveSession

" C/C++
set cinoptions=g1
autocmd FileType c,cpp ClangFormatAutoEnable
