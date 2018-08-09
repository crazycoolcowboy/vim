set nocompatible "behave as vim not vi

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'  "syntax checker and more
Plugin 'sjl/gundo.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype off
filetype indent on
filetype plugin on

syntax enable

set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
set directory=~/.vim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)

"hides menu bar and toolbar in gvim 

set guioptions=acg 

"Disable cursor blink 
set gcr=a:blinkon0              

"shows results as you search 
set incsearch  

"ignore case while searching 
set ignorecase 

"highlights all matched results 
set hlsearch 

"will perform case insensitive search until it encounters a capital letter 
set smartcase 

"wraps line after they hit end
set wrapscan

 " don't update the display while executing macros 
set lazyredraw                  

"it will set virtual edit allowing u to move around invalid places 
set virtualedit=all 

"in command line when tab is pressed show all matching commands
set wildmenu 

" Do not require exact case for completion 
set wildignorecase  

" remember more commands and search history 
set history=1000                

" use many muchos levels of undo 
set undolevels=1000             

"improving backspace and delete
set backspace=indent,eol,start

"show line number
set number

"treats numbers as decimal when incremeting and decrementing using <C-a> and
"<C-x>
set nrformats=

"splitting a window will put the new window below current one
set splitbelow

"splitting will cause new window to right of current one
set splitright

"show the cursor position in status bar
set ruler

"always show status bar
set laststatus=2

 "highlights ( { [ etc 
set showmatch 

" Resize splits when the window is resized
au VimResized * :wincmd =


" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END


 " makes the current directory as pwd 
set autochdir   

 " if files is changed locally load it immediately 
set autoread	

"nerd tree plugin customization
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"this keeps cursor 2 line below or top as we move  
set scrolloff=2 

" Add ignorance of whitespace to diff
set diffopt+=iwhite


"to enter Unicode character go in insert mode press ctrl-v and type the unicode character
"ctrl-v u00ac represents ¬
"ctrl-v u25b8 represents ▸
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set listchars=eol:¬

"this will suppress errors incase i switch to next buffer without saving current one 
set hidden 

"show auto-complete menu even for single match
set completeopt=menu,menuone
                    
"this will set command height to 2
set ch=2

"my custom mappings 

" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk

"indent code with visual mode intact
vmap > >gv
vmap < <gv

"set leader key as single quote
let mapleader=','

 " Turn off highlight search 
nnoremap <leader>n :nohls<CR>

 "mapping to toggle displaying  special characters 
nnoremap <leader>l :set list!<CR> 

nnoremap <silent> <leader>s :set spell!<CR>
"to save file in insert mode and switch to command
inoremap <C-s> <esc>:w<CR> 

nnoremap <leader>f :Files<CR> 
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>g :GundoToggle<CR>
" Edit the vimrc file
nmap <silent> <leader>ev :vert split $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" use - and + to resize horizontal splits
noremap <M-s>  <C-W>-
noremap <M-w>  <C-W>+

" and for vsplits with alt-< or alt->
noremap <M-a> <C-W>>
noremap <M-d> <C-W><

"use M-q instead of esc to go to command mode
inoremap <M-q> <esc>
noremap <M-q> <esc>

"----------------------------------------------------------------
"Bubbling part of code up and down using timpope unimpaired plugin

"Moving single line of code up and down in normal mode
"M - for alt key, C - for Ctrl key, S - for Shift key
nmap <M-k> [e
nmap <M-j> ]e

"Moving multiple selected lines up and down
vmap <M-k> [egv
vmap <M-j> ]egv

" disable arrow keys
   map <up> <nop>
   map <down> <nop>
   map <left> <nop>
   map <right> <nop>
   imap <up> <nop>
   imap <down> <nop>
   imap <left> <nop>
   imap <right> <nop>


"ALE setting  w0rp/ale
let g:ale_linters = { 'javascript': ['eslint'] }

"----------------------------------------------------------------

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
"vnoremap <silent> * :call VisualSelection('f')<CR>
"vnoremap <silent> # :call VisualSelection('b')<CR>
"
"
"function! VisualSelection(direction) range
"    let l:saved_reg = @"
"    execute "normal! vgvy"
"
"    let l:pattern = escape(@", '\\/.*$^~[]')
"    let l:pattern = substitute(l:pattern, "\n$", "", "")
"
"    if a:direction == 'b'
"        execute "normal ?" . l:pattern . "^M"
"    elseif a:direction == 'gv'
"        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
"    elseif a:direction == 'replace'
"        call CmdLine("%s" . '/'. l:pattern . '/')
"    elseif a:direction == 'f'
"        execute "normal /" . l:pattern . "^M"
"    endif
"
"    let @/ = l:pattern
"    let @" = l:saved_reg
"endfunction
"
"
" Set the status line the way i like it
"set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]
" Status line
"set laststatus=2
"set statusline=
"set statusline+=Buf:#%n\                         " buffer number
"set statusline+=%f\                             " filename
"set statusline+=%h%m%r%w                        " status flags
"if isdirectory(expand("~/.vim/bundle/vim-fugitive", ":p"))
"    set statusline+=%{fugitive#statusline()}        " git status
"endif
"if isdirectory(expand("~/.vim/bundle/syntastic", ":p"))
"    set statusline+=%{SyntasticStatuslineFlag()}    " syntastic status - makes sense with :Errors
"endif
"set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
"set statusline+=%=                              " right align remainder
"set statusline+=0x%-8B                          " character value
"set statusline+=%-14(%l,%c%V%)                  " line, character
"set statusline+=%<%P                            " file position
"

"Indentation
"set tabstop=4 
"set softtabstop=4
"set shiftwidth=4
"set noexpandtab	
"set autoindent 
"set smartindent 

