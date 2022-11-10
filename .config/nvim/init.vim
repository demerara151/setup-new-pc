syntax on
set t_Co=256

set tabstop=4           " タブを何文字の空白に変換するか
set shiftwidth=4        " 自動インデント時に入力する空白の数
set expandtab           " タブ入力を半角スペースにする
set nobackup            " バックアップファイルを作らない
set noswapfile          " スワップファイルを作らない

set cursorline          " 現在の行を強調表示
set visualbell          " ビープ音を可視化
set showmatch           " 括弧入力時の対応する括弧を表示
set wildmode=list:longest " コマンドラインの補完
set ignorecase          " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase           " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan            " 検索時に最後まで行ったら最初に戻る

set relativenumber      " line number = relative
set spelllang=en_us     " specify language for spell check. `:set spell` to use this feature

" yank した文字列をクリップボードにコピー
set clipboard+=unnamedplus

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

let g:python3_host_prog = '~/scoop/apps/python/current/python'

"powerline settings
let g:airline_theme = 'wombat'               " テーマの指定
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
let g:airline_powerline_fonts = 1            " Powerline Fontsを利用

"format .rs file automatically when u save
let g:rustfmt_autosave = 1

" neovim for vscode setting
if exists('g:vscode')
    finish
endif

" Auto IME off when you exit insert mode
if executable('zenhan')
autocmd InsertLeave * :call system('zenhan 0')
autocmd CmdlineLeave * :call system('zenhan 0')
endif

if &compatible
  set nocompatible " Be iMproved
endif

" Required:
" Add the dein installation directory into runtimepath
set runtimepath+=~\AppData\Local\nvim\dein\repos\github.com\Shougo\dein.vim

" Required:
call dein#begin('~\AppData\Local\nvim\dein')

" Let dein manage dein
call dein#add('~\AppData\Local\nvim\dein\repos\github.com\Shougo\dein.vim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Add or remove your plugins here like this:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('rust-lang/rust.vim')
call dein#add('arcticicestudio/nord-vim') " Favorite theme
call dein#add('cohama/lexima.vim') " Auto paren close function
call dein#add('preservim/nerdtree')
call dein#add('ryanoasis/vim-devicons')

set termguicolors
colorscheme nord

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
 call dein#install()
endif
