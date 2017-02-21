set number
set tabstop=2
set softtabstop=2 expandtab
set shiftwidth=2
syntax on
noremap w b
nnoremap ; :
nnoremap : ;
inoremap <Nul> <C-n>

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" dein.vim
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

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

" Unite
let g:unite_enable_smart_case = 1

" neomake
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_args = ["-Wall", "-Wextra", "--std=c++14", "-pthread", "-ferror-limit=100"]
autocmd BufWritePost * Neomake

" Complete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources.hpp = ['buffer', 'clang']
let g:deoplete#sources#clang#libclang_path="/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" vim-session(save session)
let g:session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 1

" Markdown
let g:vim_markdown_folding_disabled = 1
autocmd BufNewFile,BufRead *.page set filetype markdown

" C++
let g:clang_format#style_options = {"Standard" : "C++11"}
autocmd FileType c,cpp,objc nnoremap <Space><Space> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <Space><Space> :ClangFormat<CR>
