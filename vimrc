" ============================================================
" Plugins
" ============================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'morhetz/gruvbox'

Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'

Plugin 'ervandew/supertab'
Plugin 'davidhalter/jedi-vim'
Plugin 'mhinz/vim-signify'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/nerdtree'

Plugin 'ekalinin/Dockerfile.vim'
Plugin 'lepture/vim-jinja'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

Plugin 'nvim-lua/popup.nvim'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
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
" command! MakeTags !ctags -R .

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
" Hightlight on yank
" From https://neovim.io/news/2021/07
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

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

let g:jedi#environment_path = "venv"

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

" gfiles shortcut
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope git_files<cr>
