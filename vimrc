if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
filetype off        " required

" set the runtime path to include Vundle and initialize
 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
 Plugin 'VundleVim/Vundle.vim'
" Improved statusline
 Plugin 'vim-airline/vim-airline'
" Syntax check on write
 Plugin 'scrooloose/syntastic'
 call vundle#end()       " required
 filetype plugin indent on   " required


set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

set number		" show line numbers
set relativenumber      " show relative line-numbers
set incsearch		" do incremental searching
set ignorecase      " Ignore case when searching
set smartindent     " Automatically indent when adding a curly bracket, etc.
set showcmd     " Display incomplete commands.

set laststatus=2    " show statusline all the time (for airline)
let g:airline_powerline_fonts = 1   " airline patched fonts

set foldmethod=indent   " Folding type
set foldlevelstart=1    " fold one level per default
set fillchars=vert:┃    " BOX DRWAINGS HEAVY VERTICAL (U+2503)
" BOX DRAWINGS BACKGROUND COLOR
highlight VertSplit cterm=none
" Colorscheme for folds
highlight Folded ctermfg=none ctermbg=none

set scrolloff=3     " start scrolling 3 lines before edge of viewport
set shortmess+=I    " no splash screen
set shortmess+=W    " don't echo "[w]"/"[written]" when writing

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

" Tabs should be converted to a group of 4 spaces.
" This is the official Python convention
" (http://www.python.org/dev/peps/pep-0008/)
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Toggle fold on current position
nnoremap <s-tab> za
" Map ctrl-(h-l) to switch between splits
nnoremap <c-H> <c-W>h
nnoremap <c-J> <c-W>j
nnoremap <c-K> <c-W>k
nnoremap <c-L> <c-W>l

" Splits open below and to the right
set splitbelow
set splitright
