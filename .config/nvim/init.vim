syntax on
set t_Co=256

set autoindent          " 改行時に自動でインデントする
set smartindent
set encoding=utf-8
set fileencodings=utf-8,utf-16le,iso-2022-jp,cp932,sjis,euc-jp,ucs-2

set tabstop=4           " タブを何文字の空白に変換するか
set shiftwidth=4        " 自動インデント時に入力する空白の数
set expandtab           " タブ入力を半角スペースにする
set clipboard=unnamed   " yank した文字列をクリップボードにコピー
set hls                 " 検索した文字をハイライトする

set nobackup            " バックアップファイルを作らない
set noswapfile          " スワップファイルを作らない
set showcmd             " 入力中のコマンドをステータスに表示する

set cursorline          " 現在の行を強調表示
set visualbell          " ビープ音を可視化
set showmatch           " 括弧入力時の対応する括弧を表示
set laststatus=2        " ステータスラインを常に表示
set wildmode=list:longest " コマンドラインの補完

set ignorecase          " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase           " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch           " 検索文字列入力時に順次対象文字列にヒットさせる
set wrapscan            " 検索時に最後まで行ったら最初に戻る
set hlsearch            " 検索語をハイライト表示

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

let g:python3_host_prog = '~/scoop/apps/python/current/python'

"powerline settings
let g:airline_theme = 'wombat'               " テーマの指定
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
let g:airline_powerline_fonts = 1            " Powerline Fontsを利用

"format .rs file automatically when u save
let g:rustfmt_autosave = 1

" ime off
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
call dein#add('nanotee/zoxide.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('ryanoasis/vim-devicons')
call dein#add('rust-lang/rust.vim')
call dein#add('cohama/lexima.vim')
syntax enable
filetype plugin indent on

set termguicolors
set background=dark
colorscheme iceberg

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
 call dein#install()
endif
