" ============================================================
" Plugins
" ============================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-rails'
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'ervandew/supertab'
Plugin 'mhinz/vim-signify'
Plugin 'scrooloose/nerdtree'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'w0rp/ale'
Plugin 'lepture/vim-jinja'
call vundle#end()

" ============================================================
" Default settings
" ============================================================
set encoding=utf-8
syn enable
set nocompatible
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
set autoread                    " Auto-reload buffers when files are changed on disk
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode
set path+=**                    " Search down into subfolders

" Create the `tags` file
command! MakeTags !ctags -R .

" ============================================================
" FileType specific changes
" ============================================================
filetype on        " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins

" Python
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
"au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au FileType python set foldmethod=indent foldlevel=99
" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" ============================================================
" Highlighting
" ============================================================
" set dark background and color scheme
colorscheme gruvbox
set background=dark

" highlight modes
hi Visual ctermbg=16 ctermfg=11
hi Search ctermfg=yellow
hi Normal ctermbg=235

" hightlight indentation
au FileType sql setlocal ts=4 sts=4 sw=4
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4 nolist

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
endif

" highlight trailing spaces in annoying red
hi ExtraWhitespace ctermbg=1 guibg=red
call matchadd('ExtraWhitespace', '\s\+$')
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/

" rake debugger statements visible
hi Debug ctermbg=1 guibg=red
call matchadd('Debug', 'breakpoint()')
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<byebug\>"

" airline configuration
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8
let g:airline_theme = 'gruvbox'

" Snippets
let @g = "Obreakpoint()"

" ============================================================
" Functions
" ============================================================
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
