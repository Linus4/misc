if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=ucs-bom,utf-8,latin1
endif

set t_ut=           " disable background color erase so that color schemes work properly
set nocompatible    " Use Vim defaults (much better!)

" =========== VUNDLE BEGIN ===========
if(filereadable($HOME . "/.vim/bundle/Vundle.vim/autoload/vundle.vim"))
    filetype off            " required
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'
    " Improved statusline
    Plugin 'vim-airline/vim-airline'
    " Syntax check on write
    Plugin 'scrooloose/syntastic'
    call vundle#end()       " required
endif
 filetype plugin indent on  " required
" ========== VUNDLE END ==========

" ========== INDENTING ==========
set autoindent      " always set autoindenting on
set smartindent     " automatically indent when adding a curly bracket, etc.
set shiftwidth=4    " amount of spaces insertet for tab
set tabstop=4       " number of spaces a tab counts for
set softtabstop=4   " number of spaces that a <Tab> counts for while performing editing operations
set expandtab       " turns tabs into spaces
set smarttab

" ========== INTERFACE ==========
set number          " show line numbers
set relativenumber  " show relative line-numbers
set ruler           " show the cursor position all the time
set showcmd         " Display incomplete commands.
set laststatus=2    " show statusline all the time (for airline)
set colorcolumn=80  " highlight column 80
set splitbelow      " Splits open below
set splitright      " and to the right
set scrolloff=3     " start scrolling 3 lines before edge of viewport
set shortmess+=I    " no splash screen
set shortmess+=W    " don't echo written when writing
set noequalalways   " don't resize windows on :q (for netrw)
set nowrap          " don't wrap lines
set matchpairs+=<:> " show matches for <>-brackets (HTML)

" ========== COLORS / FONTS ==========
" Use truecolors if available
if(has("termguicolors"))
    set termguicolors
    highlight VertSplit gui=none
    highlight Folded guifg=NONE guibg=NONE
    highlight ColorColumn guibg=DarkGrey
else
    highlight VertSplit cterm=none
    highlight Folded ctermfg=none ctermbg=none
    highlight ColorColumn ctermbg=darkgrey
endif
let g:airline_powerline_fonts = 1   " airline patched fonts
" match ErrorMsg '\s\+$'            " flag trailing whitespace
" Use onedark colorscheme, if available
" https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim
if(filereadable($HOME . "/.vim/colors/onedark.vim"))
    colorscheme onedark
endif
set fillchars=vert:┃    " character for vertical split drawing (U+2503)

" ========== SEARCH ==========
set incsearch       " do incremental searching
set ignorecase      " Ignore case when searching
set smartcase       " case-sensitive when using uppercase

" ========== FOLDING =========
set foldmethod=syntax   " Folding type
set foldlevelstart=4    " fold no level per default

" ========== MISC ===========
" set backup            " keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set bs=indent,eol,start	" allow backspacing over everything in insert mode

" ========== SYNTAX HIGHLIGHTING ==========
" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" ========== REMAPS ==========
" toggle fold on current location
nnoremap <s-tab> za
" Automatically append closing curly-brackets
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
" Remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
" leave insert-mode on jj
inoremap jj     <ESC>l

" ========== NETRW ==========
let g:netrw_liststyle=3                             " tree style listing
let g:netrw_banner=0                                " hide banner
let g:netrw_browse_split=4                          " open file in previous window
let g:netrw_winsize=-20                             " default width to 25
let g:netrw_hide=1                                  " hide files matching hide-list
let g:netrw_list_hide='.swp,.swn,.swo,.class,.pyc'  " hide swapfiles in netrw
let g:netrw_bufsettings='norelativenumber nonumber' " hide line-numbers to save space

" ========== AUTOCOMMANDS ==========
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

  " change to directory of current file automatically
  autocmd BufEnter * lcd %:p:h
  " Max textwidth to 80 for python convention
  autocmd BufNewFile,BufRead *.py
      \ set textwidth=79
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

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
let &guicursor = &guicursor . ",a:blinkon0"
