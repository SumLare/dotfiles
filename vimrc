" .vimrc
set encoding=utf-8

syntax on

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-rails'
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'nightsense/snow'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'slim-template/vim-slim.git'
Plugin 'fatih/vim-go'
Plugin 'davidhalter/jedi-vim'
Plugin 'mdempsky/gocode', {'rtp': 'vim/'}
call vundle#end()

set autoindent
set showmatch
set vb
set ruler
set hlsearch
set incsearch
set ignorecase
set smartcase
set cursorline
set number
set relativenumber
set scrolloff=2
set laststatus=2
set list listchars=tab:··,trail:·
set nofoldenable
set clipboard=unnamed
set wildmenu
set nowrap
set noswapfile

" Search down into subfolders
set path+=**

" Create the `tags` file
command! MakeTags !ctags -R .

" Auto-reload buffers when files are changed on disk
set autoread

" Whitespace
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4 nolist

" set dark background and color scheme
colorscheme snow
set background=dark

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
endif

" multi-purpose tab key (auto-complete)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Make those debugger statements painfully obvious
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<debugger\>"

" hightlight line longer than 80 characters
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" trim whitespaces on write
"function! TrimWhiteSpace()
"	%s/\s\+$//e
"endfunction
"autocmd BufWritePre     * :call TrimWhiteSpace()

" powerline configuration
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
let g:powerline_pycmd = 'py3'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
"set term=xterm-256color
set termencoding=utf-8

highlight Visual       ctermbg=3   ctermfg=1
highlight Search ctermfg=yellow
hi Normal     ctermbg=235

" golang stuff

" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['golint', 'errcheck']
