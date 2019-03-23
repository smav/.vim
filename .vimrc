""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Minimal' vim config
"
" v 0.1 - 20161224
" v 0.2 - 20190208 (vim8 config)
" simplified/remove dependencies - 20190323
"
" A refactoring based on vim8 features and
"
" http://liuchengxu.org/posts/use-vim-as-a-python-ide/
"
" With ideas from :
"
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://weierophinney.net/matthew/archives/249-Vim-Toolbox,-2010-Edition.html
" https://github.com/spf13/spf13-vim
" https://github.com/amix/vimrc
" plus many other pseudo-random google hits

" This config is expected to be git cloned to ~/.vim, & ~/.vimrc symlink created
" It will create folders in ~/.vim/tmp, load/save plugins from ~/.vim/plugins
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Basic file syntax/indenting (required for later config)
filetype plugin indent on
syntax enable

" Paths - keep most vim generated files in one place
call functions#SetupFolders()              " from spf13, in autoload
"set nobackup                    " disable backups
"set noswapfile                  " disable swapfiles
set undofile
set undoreload=100
set viminfo='20,f1,<500,:5,/5,h,n~/.vim/.viminfo

" Session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" Core settings
set history=100                 " vim command history
set hidden                      " Allow for easier buffer save
set timeoutlen=450              " Shorten timeouts
set ttyfast                     " Faster redraw
set lazyredraw                  " Dont update screen when running macros
set showmode                    " Show if in insert, visual etc modes
set showcmd                     " Show comand entered in last line
set matchtime=1                 " Show matching bracket fast
set autoread                    " Read a file if it changes outside of vim
set autoindent                  " Start new line with current lines indent
"set copyindent                  " Use same formatting/tabs as previous indent
set scrolloff=999               " Scroll X lines from screen edge
set cmdheight=2                 " Helps avoid 'hit enter'
set helpheight=10               " Help window min size
set laststatus=2                " Always show status line
set modeline
set modelines=10
set ruler                       " Line numbering for y/d command spacing
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " more complex ruler
set nonumber                    " No line numbers, its in the status bar
"set number                      " Line numbers on
"set relativenumber              " Relative line numbers
set pastetoggle=<Ins>           " Paste toggle key, also <leader>p
set clipboard=unnamed           " make pasting more integrated

"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

" Assume global replace - :%s/foo/bar/g to revert to one per line
set gdefault
"set cpoptions+=ceI              " Copy/select options
set shortmess+=flmnrxoOTIa      " abbrev. of messages, no vim intro screen
set comments=sl:/*,mb:\ *,ex:\ */,O://,b:#,:%,:XCOMM,n:>,fb:- " comment regex


" Sound
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" System specific settings
set shell=/bin/bash             " Default shell to start with :shell
set shellslash                  " Unix path char
set fileformats=unix,dos,mac    " detect all


" Look and Feel
set titlestring=%f title        " Display filename in terminal window
set synmaxcol=16384             " Dont highlight big files
set background=dark             " Dont blind me
colorscheme iria256             " Use my colorscheme


" Statusline  - Optimised 80char(vimdiff)
" Improvements - move to function? ..
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
" https://github.com/blaenk/dots/blob/dfb34f1ad78f5aa25bc486d3c14c9a0ef24094bd/vim/.vimrc#L168
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%#Status#                     " normal colouring
set statusline+=%-n\                          " buffer number
set statusline+=%t\                          " file name
set statusline+=%3*                           " magenta
set statusline+=%#Status#                     " normal colouring
set statusline+=[%{strlen(&ft)?&ft:'none'}    " filetype
set statusline+=%#Status#:                   " normal colouring
set statusline+=%{strlen(&fenc)?&fenc:&enc}]\ " encoding
set statusline+=%3*                           " magentaj
set statusline+=%{&paste?'[paste]':''}      " paste mode
set statusline+=%2*                           " red
set statusline+=%{'!'[&ff=='unix']}\          " ! if not unix format
set statusline+=%h%m%r%w                      " flags
set statusline+=%#Status#                   " normal colouring
set statusline+=\ %2*
set statusline+=%*
set statusline+=%=                            " right align
set statusline+=%#Status#                   " normal colouring
set statusline+=%*
set statusline+=[%{synIDattr(synID(line('.',),col('.',),1,),'name',)}]\  " Vim syntax type
set statusline+=[%p%%\ L:%l/%L\ C:%c]\              " line info
"set statusline+=[Col:%c\ A:%b]\                  " char count/ascii code"


" visual marker for textwidth
if exists('+colorcolumn')
    set colorcolumn=79
else
    if has("autocmd")
        autocmd BufWinEnter * let w:m2=matchadd('Comment', '\%>80v.\+', -1)
    endif
endif

" Highlight the current line and column
" Diasbled - can slow window redraws
set nocursorline
set nocursorcolumn


" Whitespace
set listchars=tab:»·,trail:·    " Show tabs and trailing spaces.
"set list
set nolist                      " dont show whitespace by default ,w to toggle
set diffopt+=iwhite             " Add ignorance of whitespace to diff
set fillchars=""                " Remove the bar gap in diff output

" Tabs, spaces, wrapping        " Tabs are turned into spaces
" https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=4                   " Number of spaces a <Tab> counts for
set softtabstop=4               " Number of spaces that a <Tab> counts for while editing
set shiftwidth=4                " Number of spaces used for autoindent
set expandtab                   " Tab inserts N spaces
"set smarttab                    "

set shiftround                  " Use a multiple of shiftwidth indenting with '<' and '>'"
set wrap                        " Wrap long lines
set textwidth=79                " Adhere to good console code style
set formatoptions=tcroqln1j       " Text auto-formatting options
" t       Auto-wrap text using textwidth
" c       Auto-wrap comments using textwidth, inserting the current comment
"         leader automatically.
" r       Automatically insert the current comment leader after hitting
"         <Enter> in Insert mode.
" o       Automatically insert the current comment leader after hitting 'o' or
"         'O' in Normal mode.
" q       Allow formatting of comments with "gq".
"         Note that formatting will not change blank lines or lines containing
"         only the comment leader.  A new paragraph starts after such a line,
"         or when the comment leader changes.
" l       Long lines are not broken in insert mode: When a line was longer than
"         'textwidth' when the insert command started, Vim does not
"         automatically format it.
" n       When formatting text, recognize numbered lists.
" 1       Don't break a line after a one-letter word.  It's broken before it
"         instead (if possible).
" j       Where it makes sense, remove a comment leader when joining lines.  For
"         example, joining:


" Autocomplete
" Command line completion - behave more like bash completion
set wildmenu
"set wildmode=list:longest
set wildmode=list:longest,full
set wildignore+=*~,*.pdf,*.swp,*.o,*.py[co]
" Remove the 'u' option, scan dict when in spell mode
set complete+=kspell

" Omnicomplete  - insert mode completion (or use cmake/YouCompleteMe ?)
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone ",preview
set pumheight=16 " Popup menu height

" Expansions/Spelling
"
" Omni completion
" Complete for any language we have a autoload/*complete.vim for
set ofu=syntaxcomplete#Complete


" Movement
set backspace=indent,eol,start  " Backspace over everything
set virtualedit=all             " Allow cursor to move to 'illegal' areas

" redefine x for virtualEdit
" for a more natural/vim-like delete behaviour
function! Redefine_x_ForVirtualEdit() abort
    if &ve != "" && col('.') >= col('$')
        normal $
    endif
endfu!
silent! unmap x
nnoremap <silent>x x:call Redefine_x_ForVirtualEdit()<CR>

" Convenient movement instead of 0 / $
" http://blog.learnr.org/post/59098925/configuring-vim-some-more
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $
"nnoremap Y y$

" jump to next editor row, rather than next line - long line fix
nnoremap j gj
nnoremap k gk

" Search
"
" Use Power search
nnoremap / /\v
vnoremap / /\v

set ignorecase " ignore case on search
set smartcase  " unless search term has caps
set incsearch  " find match as term is typed
set hlsearch   " highlight all matches
set wrapscan   " Search wraps to start of file

" Next/Previous term - center screen on searhTerm line
nnoremap n nzzzv
nnoremap N Nzzzv


" Buffers
" buffer switching on arrow keys
map <Right> :bnext<CR>
imap <Right> <ESC>:bnext<CR>
map <Left> :bprev<CR>
imap <Left> <ESC>:bprev<CR>

" Easier split window navigation
"noremap <C-h>  <C-w>h
"noremap <C-j>  <C-w>j
"noremap <C-k>  <C-w>k
"noremap <C-l>  <C-w>l


" Folding
set foldmethod=indent
set foldlevel=99

" These commands open folds
set foldopen="block,insert,jump,mark,percent,quickfix,search,tag,undo"


" Mappings
"
" Leader
let mapleader = ","
let maplocalleader = ","

" Faster Esc
inoremap jk <ESC>
" Similarly ":" takes two keystrokes ";" takes one
" map the latter to the former in normal mode to get to the commandline faster
nnoremap ; :

" Move a visual block through the text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Bulk move of code blocks
vnoremap < <gv
vnoremap > >gv

" turn off search highlight - next search re-enables
nnoremap <leader>n :noh<CR>

" Toggle paste mode
nnoremap <leader>p :set invpaste<CR>:set paste?<CR>

" Visually select the text that was last selected/pasted
nnoremap <leader>v `[v`]

" Formatting, TextMate-style
nnoremap <leader>q gqap
vmap <leader>q gp

" Sort
vnoremap <leader>s :sort<CR>

" cd to the directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>
"nnoremap <silent> <leader>md :!mkdir -p %:p:h<CR>

" toggle showing of whitespace
nnoremap <leader>w :set list!<CR>
" replace tabs with spaces
nnoremap <leader>wr :retab<CR>

" Clean whitespace
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Run the command that was just yanked
nnoremap <silent> <leader>rc :@"<CR>

" Sudo to write
cnoremap W!! w !sudo tee % >/dev/null

" Make the current file executable
nnoremap ,x :w<CR>:!chmod a+x %<Cr>:e<CR>


" F-keys

" spell toggle
"nnoremap <F6> :setlocal spell! spelllang=en_gb<CR>
"imap <F6> <Esc><F6>

" Show the Vim Syntax type currently under the cursor
nnoremap <F6> :echo "hi<".synIDattr(synID(line(".",),col(".",),1,),"name",).'>trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" 
            \ . synIDattr( synIDtrans( synID( line( ".",), col( ".",), 1,)), "name",) . ">"<CR>

" F7/F8 are mapped in tmux - dont use them

" Maps to make handling windows a bit easier
"noremap <silent> <F9>  :resize -10<CR>
"noremap <silent> <F10> :resize +10<CR>
"noremap <silent> <F12> :vertical resize +10<CR>
"noremap <silent> <leader>s8 :vertical resize 83<CR>
"noremap <silent> <F11> :vertical resize -10<CR>


" Filetypes/Autocmd
set encoding=utf-8              " UTF8
set termencoding=utf-8          " terminal encoding
if has("autocmd")
    " Create augroups to namespace/manage options properly
    augroup AllFiles
        " Remove all auto-commands from the group
        autocmd!

        " Autoload/save views (saves fold state)
        autocmd BufWritePost *
                    \   if expand('%') != '' && &buftype !~ 'nofile'
                    \|      mkview
                    \|  endif
        autocmd BufRead *
                    \   if expand('%') != '' && &buftype !~ 'nofile'
                    \|      silent loadview
                    \|  endif

        " Always open file at the last known cursor position.
        " Don't jump when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \ exe "normal g`\"" |
                    \ endif

        " Highlight trailing whitespace and tab characters. Note that the foreground
        " colors are overridden here, so this only works with the "set list" settings
        " Sets color to red
        "autocmd ColorScheme * highlight ExtraWhitespace ctermfg=red guifg=red
        "highlight ExtraWhitespace ctermfg=red guifg=red cterm=bold gui=bold
        "match ExtraWhitespace /\s\+$\|\t/
    augroup END

    augroup Python
        " Remove all auto-commands from the group
        autocmd!

        " Below from : https://svn.python.org/projects/python/trunk/Misc/Vim/vimrc
        autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
                    \ softtabstop=4 colorcolumn=79 textwidth=79
                    \ formatoptions+=croq foldmethod=indent fileformat=unix
                    \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with

        " Python PEP 8
        ""autocmd FileType python syn keyword pythonDecorator True None False self
        autocmd FileType python let python_highlight_all=1

        " Pipfile nicety
        autocmd BufRead,BufNewFile Pipfile set filetype=dosini
        autocmd BufRead,BufNewFile requirements.txt set filetype=dosini
        autocmd BufRead,BufNewFile Pipfile.lock set filetype=json

        " PyMode takes care of the below now.
        " Use the below highlight group when displaying bad whitespace is desired.
        highlight BadWhitespace ctermbg=red guibg=red

        " Display tabs at the beginning of a line in Python mode as bad.
        autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /^\t\+/
        " Make trailing whitespace be flagged as bad.
        autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
    augroup END

    augroup Git
        " Remove all auto-commands from the group
        autocmd!

        " Always start a gitcommit on the first line
        autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
    augroup END

    " Web Server syntax
    augroup Apache
        " Remove all auto-commands from the group
        autocmd!

        autocmd BufRead,BufNewFile /etc/apache2/*conf set ft=apache
        autocmd BufRead,BufNewFile /etc/apache2/sites-available/* set ft=apache
        autocmd BufRead,BufNewFile /etc/apache2/sites-enabled/* set ft=apache
    augroup END
    augroup Nginx
        " Remove all auto-commands from the group
        autocmd!

        autocmd BufRead,BufNewFile /etc/nginx/*conf set ft=nginx
        autocmd BufRead,BufNewFile /etc/nginx/sites-available/* set ft=nginx
        autocmd BufRead,BufNewFile /etc/nginx/sites-enabled/* set ft=nginx
    augroup END

endif


" Digraphs
" Alpha   α
imap <c-l><c-a> <c-k>a*
" Beta    β
imap <c-l><c-b> <c-k>b*
" Gamma   γ
imap <c-l><c-g> <c-k>g*
" Delta   δ
imap <c-l><c-d> <c-k>d*
" Epslion ε
imap <c-l><c-e> <c-k>e*
" Lambda  λ
imap <c-l><c-l> <c-k>l*
" Eta     η
imap <c-l><c-y> <c-k>y*
" Theta   θ
imap <c-l><c-h> <c-k>h*
" Mu      μ
imap <c-l><c-m> <c-k>m*
" Rho     ρ
imap <c-l><c-r> <c-k>r*
" Pi      π
imap <c-l><c-p> <c-k>p*
" Phi     φ
imap <c-l><c-f> <c-k>f*

" Useful abbrevs
" File and path name stuff
iab xpath <c-r>=expand("%:p")<CR>
iab xfile <c-r>=expand("%:t:r")<CR>
iab xdir <c-r>=expand("%:p:h")<CR>
" Dates
iab xdate <c-r>=strftime("%y/%m/%d %H:%M:%S")<CR>
iab xtime <c-r>=strftime("%H:%M")<CR>
"iab YISODATE <c-r>=strftime("%Y-%M-%d")<CR>
"iab YDATE    <c-r>=strftime("%a %d %b %T %Z %Y")<CR>
"iab YFDATE   <c-r>=strftime("%a %b %d %T %Y")<CR>
"iab YTIME    <c-r>=strftime("%d %b %Y %T")<CR>
"iab YDate    <c-r>=strftime("%d %b %Y")<CR>
"iab Ydate    <c-r>=strftime("%b %d")<CR>
"iab YTime    <c-r>=strftime("%H:%M:%S")<CR>
cnoreabbrev W w
cnoreabbrev W! w!
cnoreabbrev Wa wa
cnoreabbrev Wq wq
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev Q q
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Qa! qa!
cnoreabbrev Qall qall
cnoreabbrev Qa qa
