""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Minimal' vim config
"
" v 0.1 - 20161224
"
" A refactoring of my .vimrc, with ideas from :
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://weierophinney.net/matthew/archives/249-Vim-Toolbox,-2010-Edition.html
" https://github.com/spf13/spf13-vim
" https://github.com/amix/vimrc
" plus many other pseudo-random google hits
"
" This config is expected to be git cloned to ~/.vim, & ~/.vimrc symlink created
" It will create folders in ~/.vim/tmp, load/save plugins from ~/.vim/plugins
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Init {{{
set nocompatible                " disable vi compatibility

" Read in utility functions
if filereadable(expand("~/.vim/.vimrc-functions"))
    source ~/.vim/.vimrc-functions
endif

" Paths
call SetupFolders()
set nobackup                    " disable backups by default
set undofile
set undoreload=100
set viminfo='20,f1,<500,:5,/5,h,n~/.vim/.viminfo

" Pre-reqs
filetype plugin on
filetype indent on
syntax enable
" }}}

" Basics {{{
set history=100                 " vim command history
set hidden                      " Allow for easier buffer save
set timeoutlen=450              " Shorten timeouts
set ttyfast                     " Faster redraw
set lazyredraw                  " Dont update screen when running macros
set showmode                    " Show if in insert, visual etc modes
set showcmd                     " Show comand entered in last line
"set noshowmatch                 " Dont show matching brackets
"let loaded_matchparen = 1       " I mean it, dont show the brackets!
set matchtime=1                 " Show matching bracket fast
set autoread                    " Read a file if it changes outside of vim
set autoindent                  " Start new line with current lines indent
set copyindent                  " Use same formatting/tabs as previous indent
set smartindent
set scrolloff=999               " Scroll X lines from screen edge
set cmdheight=2                 " Helps avoid 'hit enter'
set helpheight=10               " Help window min size
set laststatus=2                " Always show status line
set ruler                       " Line numbering for y/d command spacing
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " more complex ruler
set nonumber                    " No line numbers, its in the status bar
"set number
"set relativenumber              " Relative line numbers
set pastetoggle=<Ins>           " Paste toggle key, use ,p
set backspace=indent,eol,start  " Backspace over everything
set virtualedit=all             " Allow cursor to move to 'illegal' areas
"set cpoptions+=ceI              " Copy/select options
set shortmess+=flmnrxoOTIa      " abbrev. of messages, no vim intro screen
set comments=sl:/*,mb:\ *,ex:\ */,O://,b:#,:%,:XCOMM,n:>,fb:- " comment regex

" Assume global replace - :%s/foo/bar/g to revert to one per line
set gdefault

" Sound {{{
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" }}}

" System specific settings {{{
set shell=/bin/bash             " Default shell to start with :shell
set shellslash                  " Unix path char
set fileformats=unix            " only detect unix format, ^M with dos file
" }}}
" }}}

" Look and Feel {{{
set titlestring=%f title        " Display filename in terminal window

syntax enable
"set synmaxcol=16384             " Dont highlight big files
set background=dark             " Dont blind me
colorscheme iria256             " Use my colorscheme

" Lightline status bar settings in .vimrc-plugins

" Statusline (using lightline plugin now) - Optimised 80char(vimdiff)
"set statusline=   " clear the statusline for when vimrc is reloaded
"set statusline+=%1*                          " normal colouring
"set statusline+=%-n\                         " buffer number
"set statusline+=%-F\                         " file name
"set statusline+=%3*                         " magenta
"set statusline+=[%{strlen(&ft)?&ft:'none'}    " filetype
"set statusline+=%1*:                         " normal colouring
"set statusline+=%{strlen(&fenc)?&fenc:&enc}]\ " encoding
"set statusline+=%{HasPaste()}               "
"set statusline+=%2*                             " red
"set statusline+=%{'!'[&ff=='unix']}\         " ! if not unix format
"set statusline+=%h%m%r%w                     " flags
"set statusline+=%1*                          " normal colouring
"set statusline+=%=                           " right align
""set statusline+=[%{&fileformat}]\            " file format
"set statusline+=[%{synIDattr(synID(line('.'),col('.'),1),'name')}]\  " highlight/syntax object
"set statusline+=%{fugitive#statusline()}\
"set statusline+=[C:%c,%b]\                     " char count/ascii code"
"set statusline+=[L:%l/%L\ %p%%]         " line info

" visual marker for textwidth
if exists('+colorcolumn')
    set colorcolumn=80
else
    if has("autocmd")
        au BufWinEnter * let w:m2=matchadd('Comment', '\%>80v.\+', -1)
    endif
endif

" Highlight the current line and column
" Diasbled - can make window redraws painfully slow
set nocursorline
set nocursorcolumn
" }}}

" Whitespace {{{
"       Ctrl-K >> for »
"       Ctrl-K .M for ·
"       Ctrk-K 0M for M
"       Ctrk-K sB for ª
"       (use :dig for list of digraphs)
set listchars=tab:»·,trail:·    " Show tabs and trailing spaces.
"set list
set nolist                      " dont show whitespace by default ,w to toggle
set diffopt+=iwhite             " Add ignorance of whitespace to diff
set fillchars=""                " Remove the bar gap in diff output
" }}}

" Tabs, spaces, wrapping {{{
set shiftwidth=4                " Number of spaces used for autoindent
set tabstop=4                   " Number of spaces a <Tab> counts for
set softtabstop=4               " Number of spaces that a <Tab> counts for while editing
"set noexpandtab                 " Tab inserts <Tab> not N spaces
set expandtab                   " Tab inserts N spaces
set smarttab                    "
set shiftround                  " Use a multiple of shiftwidth indenting with '<' and '>'"
set wrap                        " Wrap long lines
set textwidth=80                " Adhere to good console code style
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

" }}}

" Autocomplete {{{
" Command line completion - behave more like bash completion
set wildmenu
"set wildmode=list:longest
set wildmode=list:longest,full
set wildignore+=*~,*.pdf,*.swp,*.o,*.py[co]

" Remove the 'u' option, scan dict too
set complete=.,w,b,t,k,d

" Omnicomplete  - insert mode completion (or use cmake/YouCompleteMe ?)
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone ",preview
set pumheight=16 " Popup menu height

" Close omnicomplete preview window on movement in,
" or when leaving, insert mode
" (when a selection is made)
"
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" The above mapping will change the behavior of the <Enter> key when the popup 
" menu is visible. In that case the Enter key will simply select the highlighted
" menu item, just as <C-Y> does.
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

" }}}

" Searching {{{

" Use Power search
nnoremap / /\v
vnoremap / /\v

set ignorecase " ignore case on search
set smartcase  " unless search term has caps
set incsearch  " find match as term is typed
set hlsearch   " highlight all matches
set wrapscan   " Search wraps to start of file

" I think the below is handled better in PHP5 repo now - testing to see
" grab from http://lerdorf.com/funclist.txt
"set dictionary+=~/.vim/php-functions.txt
"set thesaurus+=~/.vim/mythesaurus.txt


" Next/Previous term - center screen on searhTerm line
nnoremap n nzz
nnoremap N Nzz
" }}}

" Buffers & Movement {{{
" Convenient movement instead of 0 / $
" http://blog.learnr.org/post/59098925/configuring-vim-some-more
map H ^
map L $
"nnoremap Y y$

" jump to next editor row, rather than next line - long line fix
nnoremap j gj
nnoremap k gk

" buffer switching on arrow keys
map <Right> :bnext<CR>
imap <Right> <ESC>:bnext<CR>
map <Left> :bprev<CR>
imap <Left> <ESC>:bprev<CR>

" Easier split window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" }}}

" Folding {{{
set foldmethod=indent
set foldlevelstart=2
set foldminlines=3

" These commands open folds
set foldopen="block,insert,jump,mark,percent,quickfix,search,tag,undo"

" Folding and unfolding
map <leader>f :set foldmethod=indent<CR>zM<CR>
map <leader>F :set foldmethod=manual<CR>zR<CR>
map <leader>m :set foldmethod=marker<CR>

" space opens folds
nnoremap <Space> za
nnoremap zo zCzO
set foldtext=MyFoldText()

" }}}

" Mappings {{{

" Leader
let mapleader = ","
"let maplocalleader = "\\"
let maplocalleader = ","

" Faster Esc
inoremap jk <ESC>

" Similarly : takes two keystrokes ; takes one
" map the latter to the former
" in normal mode to get to the commandline faster
nnoremap ; :

" Move a visual block through the text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" turn off search highlight - next search re-enables
map <leader>n :noh<CR>

" Toggle paste mode
nmap <leader>p :set invpaste<CR>:set paste?<CR>

"toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" Easier linewise reselection
"nnoremap <leader>v V`]
" Visually select the text that was last edited/pasted
nmap <leader>v `[v`]

" toggle showing of whitespace
nmap <leader>w :set list!<CR>

" Formatting, TextMate-style
nnoremap <leader>q gqap
vmap <leader>q gp
" Use Q for formatting the current paragraph (or selection)
"vmap Q gq

" Buffer commands
noremap <silent> <leader>bd :bd<CR>
" Delete all buffers
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<CR>

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
"nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Clean whitespace
map <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Run the command that was just yanked
nmap <silent> <leader>rc :@"<CR>

" TextMate-Style Autocomplete
"inoremap <ESC> <C-P>
"inoremap <S-ESC> <C-N>

" Edit vim stuff
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e $MYVIMRC<CR>
nnoremap <leader>eb <C-w>s<C-w>j<C-w>L:e ~/.bashrc<CR>
nnoremap <leader>es <C-w>s<C-w>j<C-w>L:e ~/.vim/snippets/<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Sudo to write
cmap W!! w !sudo tee % >/dev/null
"cnoreabbrev <expr> W!!
"       \((getcmdtype() == ':' && getcmdline() == 'W!!')
"       \?('!sudo tee % >/dev/null'):('W!!'))

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Make the current file executable
nmap ,x :w<CR>:!chmod a+x %<Cr>:e<CR>

" I can't type
"cmap Q q
"cmap W w
cmap Wq wq
cmap WQ wq

"}}}

" F-keys {{{

" F5 - NerdTree

" spell toggle
nmap <F6> :setlocal spell! spelllang=en_gb<CR>
imap <F6> <Esc><F6>

" F7/F8 are mapped in tmux - dont use them

" Maps to make handling windows a bit easier
noremap <silent> <F9>  :resize -10<CR>
noremap <silent> <F10> :resize +10<CR>
noremap <silent> <F11> :vertical resize -10<CR>
noremap <silent> <F12> :vertical resize +10<CR>
noremap <silent> <leader>s8 :vertical resize 83<CR>

" Parenthesis/bracket
"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>O
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i

" Inspired by http://sphinx.pocoo.org/rest.html#sections
" Creating underline/overline headings for markup languages
nnoremap <leader>1 yyPVr=jyypVr=
nnoremap <leader>2 yyPVr*jyypVr*
nnoremap <leader>3 yypVr=
nnoremap <leader>4 yypVr-
nnoremap <leader>5 yypVr^
nnoremap <leader>6 yypVr"
" }}}

" Filetypes/Autocmd {{{
set encoding=utf-8              " UTF8
set termencoding=utf-8          " terminal encoding
if has("autocmd")
    " All Files {{{
    " Autoload/save views (saves fold state)
    autocmd BufWritePost *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      mkview
    \|  endif
    autocmd BufRead *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      silent loadview
    \|  endif

    " When editing a file, always jump to the last known cursor position.
    " Don't jump when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" |
    \ endif

    autocmd FileWritePre * :call TrimWhiteSpace()
    "autocmd FileAppendPre * :call TrimWhiteSpace()
    "autocmd FilterWritePre * :call TrimWhiteSpace()
    "autocmd BufWritePre * :call TrimWhiteSpace()

    " Highlight trailing whitespace and tab characters. Note that the foreground
    " colors are overridden here, so this only works with the "set list" settings
    " Sets color to red
    "autocmd ColorScheme * highlight ExtraWhitespace ctermfg=red guifg=red
    "highlight ExtraWhitespace ctermfg=red guifg=red cterm=bold gui=bold
    "match ExtraWhitespace /\s\+$\|\t/
    " }}}

    " YCM {{{
    "au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<CR>"
    "au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<CR>"
    " }}}

    " Vim {{{
    au FileType vim set foldmethod=marker
    au BufRead,BufNewFile .vimrc set foldmethod=marker
    " }}}

    " Python PEP 8 {{{
    " Syntax
    au FileType python syn keyword pythonDecorator True None False self
    au FileType python let python_highlight_all=1

    " Below from : https://svn.python.org/projects/python/trunk/Misc/Vim/vimrc

    " Number of spaces that a pre-existing tab is equal to.
    " For the amount of space used for a new tab use shiftwidth.
    au BufRead,BufNewFile *py,*pyw,*.c,*.h set shiftwidth=4

    " fold = indent
    au BufRead,BufNewFile *py,*pyw,*.c,*.h set foldmethod=indent

    " Use the below highlight group when displaying bad whitespace is desired.
    highlight BadWhitespace ctermbg=red guibg=red

    " Display tabs at the beginning of a line in Python mode as bad.
    au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
    " Make trailing whitespace be flagged as bad.
    au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

    " Wrap text after a certain number of characters
    " Python: 79
    " C: 79
    au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

    " Turn off settings in 'formatoptions' relating to comment formatting.
    " - c : do not automatically insert the comment leader when wrapping based on
    "    'textwidth'
    " - o : do not insert the comment leader when using 'o' or 'O' from command mode
    " - r : do not insert the comment leader when hitting <Enter> in insert mode
    " Python: not needed
    " C: prevents insertion of '*' at the beginning of every line in a comment
    "au BufRead,BufNewFile *.sh,*.py,*.php,*.md,*.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

    " Use UNIX (\n) line endings.
    " Only used for new files so as to not force existing files to change their
    " line endings.
    " Python: yes
    " C: yes
    au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

    " Ansible {{{
    autocmd FileType ansible set shiftwidth=2
    " }}}

    " YML {{{
    au BufRead,BufNewFile *.yml,*yaml set shiftwidth=2
    " }}}

    " }}}

    " PHP {{{
    augroup Php
      au!
      "Include html vim stuff
      au BufNewFile,BufRead,BufEnter *.php,*.phps,*.ctp set filetype=php.html

      " Use pman for 'K' - Required pman be installed!
      "au BufNewFile,BufRead,BufEnter *.php,*.phps,*.ctp set keywordprg=pman

      " error formating
      au FileType php set errorformat=%m\ in\ %f\ on\ line\ %l
      au FileType php noremap <leader>l :!/usr/bin/php -l %<CR>

      " run file with PHP CLI
      autocmd FileType php noremap <leader>m :w!<CR>:!/usr/bin/php %<CR>

      " Drupal *.module and *.install files.
      au BufRead,BufNewFile *.module set filetype=php.html
      au BufRead,BufNewFile *.install set filetype=php.html

      " Cakephp
      au BufRead,BufNewFile *.ctp set filetype=php.html

      " Performance tweaks for big files
      "let php_folding=0
      " let php_strict_blocks = 0
    augroup END
    " }}}

    " HTML {{{
    " indent fix
    autocmd FileType html setlocal indentkeys-=*<Return>
    " }}}

    " JS {{{
    au FileType javascript call JavaScriptFold()
    au FileType javascript setl fen
    au FileType javascript setl nocindent

    au FileType javascript imap <c-t> $log();<esc>hi
    au FileType javascript imap <c-a> alert();<esc>hi

    au FileType javascript inoremap <buffer> $r return
    au FileType javascript inoremap <buffer> $f //--- PH<esc>FP2xi

    function! JavaScriptFold()
        setl foldmethod=syntax
        setl foldlevelstart=1
        syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

        function! FoldText()
            return substitute(getline(v:foldstart), '{.*', '{...}', '')
        endfunction
        setl foldtext=FoldText()
    endfunction
    "}}}

    " Git commit {{{
    " Always start a gitcommit on the first line
    au FileType gitcommit call setpos('.', [0, 1, 1, 0])
    " }}}

    " Web Server syntax {{{
    augroup apache
        au!
        au BufRead,BufNewFile /etc/apache2/*conf set ft=apache
        au BufRead,BufNewFile /etc/apache2/sites-available/* set ft=apache
        au BufRead,BufNewFile /etc/apache2/sites-enabled/* set ft=apache
    augroup END
    augroup nginx
        au!
        au BufRead,BufNewFile /etc/nginx/*conf set ft=nginx
        au BufRead,BufNewFile /etc/nginx/sites-available/* set ft=nginx
        au BufRead,BufNewFile /etc/nginx/sites-enabled/* set ft=nginx
    augroup END
    " }}}

    " Filetype Workarounds {{{
    " Temporary workaround to Better-CSS-Syntax-for-Vim
    " See https://github.com/ChrisYip/Better-CSS-Syntax-for-Vim/issues/9
    " for more information
    autocmd BufNewFile,BufRead *.scss set filetype=css
    autocmd BufNewFile,BufRead *.sass set filetype=css
    " }}}
endif

" }}}

" Plugins {{{
" Specify where you want the plugins stored in the fs.
call plug#begin('~/.vim/plugins')
" Core Plugins
Plug 'itchyny/lightline.vim'        " Status line
Plug 'scrooloose/nerdtree'          " File browsing
Plug 'scrooloose/nerdcommenter'     " Comments
Plug 'scrooloose/syntastic'         " Syntax checking
" Utility Plugins
Plug 'godlygeek/tabular'            " Align text
Plug 'tpope/vim-surround'
"Plug 'sjl/gundo.vim'                " GundoToggle
"Plug 'tpope/vim-fugitive'          " Git integration
Plug 'matchit.zip'                  " Match words with %
" Snippets
Plug 'SirVer/ultisnips'             " Snippets Engine
Plug 'honza/vim-snippets'           " Snippets code
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' } " Popup menu/completion 
" ^ Sematic c-lang support 'install.py --clang-completer' - requires: cmake build-essentials python-dev python3-dev
" Syntax
Plug 'vim-scripts/syslog-syntax-file'
Plug 'vim-scripts/apachelogs.vim'
Plug 'vim-scripts/iptables'
Plug 'vim-scripts/openvpn'
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
" Python Plugins
"Plug 'hdima/python-syntax'         " Improved Python syntax
"Plug 'sentientmachine/Pretty-Vim-Python' " Improved Python syntax old + vars
Plug 'hynek/vim-python-pep8-indent' " Better Python Indent
Plug 'andviro/flake8-vim'           " Python PEP 8
"Plug 'davidhalter/jedi-vim'         " Python IDE autocomplete
"Plug 'fs111/pydoc.vim.git'         " Python docs
"Plug 'tpope/vim-ragtag'            " HTML/XML Mappings
"Plug 'othree/html5.vim'             " HTML5
Plug 'ChrisYip/Better-CSS-Syntax-for-Vim' " CSS
Plug 'pearofducks/ansible-vim'      " Ansible syntax etc
Plug 'lepture/vim-jinja'
Plug 'vimwiki/vimwiki'              " Vimwiki - ERROR github username issue!?
" Enable/end VimPlug config
call plug#end()
" Read in plugin settings
if filereadable(expand("~/.vim/.vimrc-plugins"))
    source ~/.vim/.vimrc-plugins
endif
"}}}

" Expansions/Spelling {{{

" Omni completion {{{
" Complete for any language we have a autoload/*complete.vim for
set ofu=syntaxcomplete#Complete

"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}

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

"Useful abbrevs
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

" Text generator
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu. Nulla non quam erat, luctus consequat nisi
iab loremm Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu. Nulla non quam erat, luctus consequat nisi. Integer hendrerit lacus sagittis erat fermentum tincidunt. Cras vel dui neque. In sagittis commodo luctus. Mauris non metus dolor, ut suscipit dui. Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum. Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

" Fix constant spelling mistakes
iab teh       the
iab Teh       The
iab taht      that
iab Taht      That
iab alos      also
iab Alos      Also
iab aslo      also
iab Aslo      Also
iab becuase   because
iab Becuase   Because
iab shoudl    should
iab Shoudl    Should

" }}}

" vim:set foldmethod=marker
