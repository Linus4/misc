if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=ucs-bom,utf-8,latin1
endif

" ========== MISC ===========
set nocompatible        " Use Vim defaults (much better!)
" set backup            " keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set bs=indent,eol,start	" allow backspacing over everything in insert mode
" disable beeping
set noerrorbells
set vb t_vb=
set t_ut=               " disable background color erase so that color schemes work properly
set path+=**            " search in all subdirectories recursively (fuzzy files)

" =========== VUNDLE BEGIN ===========
if(filereadable($HOME . "/.vim/bundle/Vundle.vim/autoload/vundle.vim"))
    filetype off            " required
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'
    " Improved statusline
    " Plugin 'vim-airline/vim-airline'
    " Syntax check on write
    Plugin 'scrooloose/syntastic'
    " vimproc dependency for ghcmod
    " interactive command execution
    Plugin 'Shougo/vimproc.vim'
    " GHCMOD for Haskell
    Plugin 'eagletmt/ghcmod-vim'
    call vundle#end()       " required
endif
" ========== VUNDLE END ==========
filetype plugin indent on  " turn on vim's plugins

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
set showcmd         " Display incomplete commands.
set colorcolumn=80  " highlight column 80
set cursorline      " highlight current line
set splitbelow      " Splits open below
set splitright      " and to the right
set scrolloff=3     " start scrolling 3 lines before edge of viewport
set shortmess+=I    " no splash screen
set noequalalways   " don't resize windows on :q (for netrw)
set nowrap          " don't wrap lines
set matchpairs+=<:> " show matches for <>-brackets (HTML)
set wildmenu        " turn on the wildmenu (command mode completion)
set wildignore=*.class,*.o,*.pyc,*.swp,*.swn,*.swo

" ========== COLORS / FONTS ==========
" Use onedark colorscheme, if available
" https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim
if(filereadable($HOME . "/.vim/colors/onedark.vim"))
    colorscheme onedark
endif

" Use truecolors if available
if(has("termguicolors"))
    " necessary to use truecolors in tmux
    if &term =~# '^screen'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    set termguicolors
endif

highlight VertSplit gui=none cterm=none
highlight Folded guifg=NONE guibg=NONE ctermfg=none ctermbg=none
highlight ColorColumn guibg=#282C34 ctermbg=darkgrey
highlight StatusLineNC guibg=#2C323C
highlight User7 guifg=#EE0000 guibg=#2C323C ctermfg=red ctermbg=236
if has("autocmd")
    " overwrite colorscheme to make it more obvious which split has focus
    autocmd ColorScheme * highlight StatusLineNC guibg=#2C323C
    autocmd ColorScheme * highlight User7 guifg=#EE0000 guibg=#2C323C ctermfg=red ctermbg=236
endif
" let g:airline_powerline_fonts = 1   " airline patched fonts
" match ErrorMsg '\s\+$'            " flag trailing whitespace
set fillchars=vert:┃    " character for vertical split drawing (U+2503)

" ========== STATUSLINE ==========
set laststatus=2                " show statusline all the time
set statusline=

set statusline+=%7*             " switch to User7 highlight group
set statusline+=▶▶\             " UTF-8 character
set statusline+=%*              " reset highlight group

set statusline+=[%n]\           " buffer number
set statusline+=%<              " truncate point
set statusline+=%t              " full path
set statusline+=%m%r%w          " modified/readonly flag
set statusline+=%=              " split point for left and right groups
" set statusline+=%{&ff}\         " file format
set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}\       "Encoding
set statusline+=%y\             " file type
set statusline+=%3l             " current line
set statusline+=/%L\            " total lines
set statusline+=%4v\            " virtual column number
" Syntastic flags in statusline
if(filereadable($HOME . "/.vim/bundle/syntastic/plugin/syntastic.vim"))
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
endif

" ========== SEARCH ==========
set incsearch           " do incremental searching
set ignorecase          " Ignore case when searching
set smartcase           " case-sensitive when using uppercase

" ========== FOLDING =========
set foldmethod=syntax   " Folding type
set foldlevelstart=10   " fold no level per default

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
" inoremap jj     <ESC>l
" compile automatically (C)
nnoremap <Leader>c  :!gcc -Wall -std=c11 %<CR>
" <Leader><Leader> open last buffer
nnoremap <Leader><Leader> <C-^>
" Avoid typing q! by typing qq
cnoremap qq     q!
" to first / last character in line
nnoremap H      ^
nnoremap L      $
" sudo wirte
command! W :w !sudo tee %

" ========== NETRW ==========
let g:netrw_liststyle=3                             " tree style listing
let g:netrw_banner=0                                " hide banner
let g:netrw_browse_split=4                          " open file in previous window
let g:netrw_winsize=-20                             " default width to 20
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
  " autocmd BufEnter * lcd %:p:h
  " Max textwidth to 80 for python convention
  autocmd BufNewFile,BufRead *.py
      \ set textwidth=79
  " Settings for html, css
  autocmd BufNewFile,BufRead *.htm,*.html,*.css
      \ set shiftwidth=2 tabstop=2 softtabstop=2 noautoindent nosmartindent nosmarttab
  " Use ant to build java projects
  autocmd BufNewFile,BufRead *.java
      \ set makeprg=ant\ -f\ ..
  " Display colorcolumn on active window only
  autocmd WinLeave * set colorcolumn=0
  autocmd WinEnter * set colorcolumn=80
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
set nohlsearch
