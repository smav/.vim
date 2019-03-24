""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Minimal' vim config
"
" v 0.1 - 20161224
" v 0.2 - 20190208 (vim8 config)
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
"set noshowmatch                 " Dont show matching brackets
"let loaded_matchparen = 1       " I mean it, dont show the brackets!
set matchtime=1                 " Show matching bracket fast
set autoread                    " Read a file if it changes outside of vim
set autoindent                  " Start new line with current lines indent
"set copyindent                  " Use same formatting/tabs as previous indent
"set smartindent                " !! old indent function.. remove?
set scrolloff=999               " Scroll X lines from screen edge
set cmdheight=2                 " Helps avoid 'hit enter'
set helpheight=10               " Help window min size
set laststatus=2                " Always show status line
set modeline
set modelines=10
set ruler                       " Line numbering for y/d command spacing
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " more complex ruler
set nonumber                    " No line numbers, its in the status bar
"set number
"set relativenumber              " Relative line numbers
set pastetoggle=<Ins>           " Paste toggle key, also <leader>p
"set clipboard=unnamed           " make pasting more integrated
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
set background=dark             " Dont blind me
colorscheme iria256             " Use my colorscheme

" Statusline:
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
" https://github.com/blaenk/dots/blob/dfb34f1ad78f5aa25bc486d3c14c9a0ef24094bd/vim/.vimrc#L168
set statusline=                               " clear statusline on vim reload
set statusline+=%#Status#                     " normal colouring
set statusline+=%-n\                          " buffer number
set statusline+=%t\                           " file name
set statusline+=%3*                           " magenta
set statusline+=%{fugitive#statusline()}\     " Git fugitive status
set statusline+=%#Status#                     " normal colouring
set statusline+=[%{strlen(&ft)?&ft:'none'}    " filetype
set statusline+=%#Status#:                    " normal colouring
set statusline+=%{strlen(&fenc)?&fenc:&enc}]\ " encoding
set statusline+=%3*                           " magentaj
set statusline+=%{&paste?'[paste]':''}        " paste mode
set statusline+=%2*                           " red
set statusline+=%{'!'[&ff=='unix']}\          " ! if not unix format
set statusline+=%h%m%r%w                      " flags
set statusline+=%#Status#                     " normal colouring
" Function: display errors from Ale in statusline
function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   return l:counts.total == 0 ? '': printf('E:%d W:%d', l:all_errors, l:all_non_errors)
endfunction
set statusline+=\ %2*
set statusline+=\%{LinterStatus()}
set statusline+=%*
set statusline+=%=                            " right align
set statusline+=%#Status#                     " normal colouring
"set statusline+=%*
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

" Tabs, spaces, wrapping        " Tabs are turned into spaces
" https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=4                   " Number of spaces a <Tab> counts for
set softtabstop=4               " Number of spaces that a <Tab> counts for while editing
set shiftwidth=4                " Number of spaces used for autoindent
set expandtab                   " Tab inserts N spaces

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
"function! OmniPopup(action)
"    if pumvisible()
"        if a:action == 'j'
"            return "\<C-N>"
"        elseif a:action == 'k'
"            return "\<C-P>"
"        endif
"    endif
"    return a:action
"endfunction
"inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
"inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Close omnicomplete preview window on movement in, or when leaving, insert mode
" (when a selection is made)
"
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" The above mapping will change the behavior of the <Enter> key when the popup
" menu is visible. In that case the Enter key will simply select the highlighted
" menu item, just as <C-Y> does.
"""inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"""            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"""
"""inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"""            \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" open omni completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <C-Space> ( pumvisible() ? ( col( '.',) > 1 ? '<Esc>i<Right>' : '<Esc>i',) : '',) .
"            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <S-Space> ( pumvisible() ? ( col( '.',) > 1 ? '<Esc>i<Right>' : '<Esc>i',) : '',) .
"            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

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
"set foldlevelstart=2
"set foldminlines=3

" These commands open folds
set foldopen="block,insert,jump,mark,percent,quickfix,search,tag,undo"


" Mappings
"
" Leader
let mapleader = ","
"let mapleader = "\<SPACE>"
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

" Easier move of code blocks
vnoremap < <gv
vnoremap > >gv

" turn off search highlight - next search re-enables
nnoremap <leader>n :noh<CR>

" Toggle paste mode
nnoremap <leader>p :set invpaste<CR>:set paste?<CR>

" Easier linewise reselection
"nnoremap <leader>v V`]
" Visually select the text that was last selected/pasted
nnoremap <leader>v `[v`]

" Formatting, TextMate-style
nnoremap <leader>q gqap
vmap <leader>q gp
" Use Q for formatting the current paragraph (or selection)
"vmap Q gq

" Sort
vnoremap <leader>s :sort<CR>

" cd to the directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>
"nnoremap <silent> <leader>md :!mkdir -p %:p:h<CR>

" toggle showing of whitespace
nnoremap <leader>w :set list!<CR>
nnoremap <leader>wr :retab<CR>

" Clean whitespace
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Run the command that was just yanked
nnoremap <silent> <leader>rc :@"<CR>

" Sudo to write
cnoremap W!! w !sudo tee % >/dev/null
"cnoreabbrev <expr> W!!
"       \((getcmdtype() == ':' && getcmdline() == 'W!!')
"       \?('!sudo tee % >/dev/null'):('W!!'))

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

    augroup VIM
        " Remove all auto-commands from the group
        autocmd!

        " Reload .vimrc on save
        "autocmd! bufwritepost .vimrc source %
    augroup END

    augroup Firewall
        " Remove all auto-commands from the group
        autocmd!

        autocmd BufRead,BufNewFile /etc/nftables.conf set ft=nftables
        autocmd BufRead,BufNewFile /etc/iptables.conf set ft=iptables
    augroup END

    augroup Python
        " Remove all auto-commands from the group
        autocmd!

        " Below from : https://svn.python.org/projects/python/trunk/Misc/Vim/vimrc
        autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
                    \ softtabstop=4 colorcolumn=79 textwidth=79
                    \ formatoptions+=croq foldmethod=indent fileformat=unix
                    \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with

        " Fix code
        "autocmd FileType python nnoremap <buffer> <silent> <LocalLeader>= :ALEFix<CR>
        autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf3<CR>

        " Python PEP 8
        ""autocmd FileType python syn keyword pythonDecorator True None False self
        "autocmd FileType python let python_highlight_all=1

        " Pipenv install ipdb and ipython for the below, improved debugging
        map <leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

        " Pipfile nicety
        autocmd BufRead,BufNewFile Pipfile set filetype=dosini
        autocmd BufRead,BufNewFile requirements.txt set filetype=dosini
        autocmd BufRead,BufNewFile Pipfile.lock set filetype=json

        " Ansible
        autocmd FileType ansible set shiftwidth=2

        " PyMode takes care of the below now.
        " Use the below highlight group when displaying bad whitespace is desired.
        highlight BadWhitespace ctermbg=red guibg=red

        " Display tabs at the beginning of a line in Python mode as bad.
        autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /^\t\+/
        " Make trailing whitespace be flagged as bad.
        autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
    augroup END

    augroup HTML
        " Remove all auto-commands from the group
        autocmd!

        " indent fix
        autocmd FileType html setlocal indentkeys-=*<Return>
    augroup END

    augroup JS
        " Remove all auto-commands from the group
        autocmd!

        autocmd FileType javascript setl fen
        autocmd FileType javascript setl nocindent

        autocmd FileType javascript imap <c-t> $log();<esc>hi
        autocmd FileType javascript imap <c-a> alert();<esc>hi

        autocmd FileType javascript inoremap <buffer> $r return
        autocmd FileType javascript inoremap <buffer> $f //--- PH<esc>FP2xi

        function! JavaScriptFold() abort
            setl foldmethod=syntax
            setl foldlevelstart=1
            syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

            function! FoldText() abort
                return substitute(getline(v:foldstart), '{.*', '{...}', '')
            endfunction
            setl foldtext=FoldText()
        endfunction

        autocmd FileType javascript call JavaScriptFold()
    augroup END

    augroup YAML
        " Remove all auto-commands from the group
        autocmd!

        autocmd BufRead,BufNewFile *.yml,*yaml set shiftwidth=2
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


" Plugins
" vim8 plugins/packs:
" https://vi.stackexchange.com/questions/9522/what-is-the-vim8-package-feature-and-how-should-i-use-it
" https://stories.abletech.nz/get-rid-of-your-vim-plugin-manager-7c8ff742f643?gi=ad0164db5086#.abnjauzgk
" Specify where you want the plugins stored in the fs.
call plug#begin('~/.vim/plugins')

Plug 'scrooloose/nerdtree'          " File browsing
let NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 35
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F4> :NERDTreeFind<CR>
nnoremap <silent> <F5> :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1
" Quit on opening files from the tree
let NERDTreeQuitOnOpen=1
" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1


Plug 'scrooloose/nerdcommenter'     " Comments
"" Add spaces after comment delimiters by default
"let g:NERDSpaceDelims = 1
"" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
"" Align line-wise comment delimiters flush left instead of following code indentation
"let g:NERDDefaultAlign = 'left'
"" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1
"" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
"" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
"" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


" Utility Plugins
Plug 'godlygeek/tabular'            " Align text
nnoremap <leader>t= :Tabularize /=<CR>
vmap <leader>t= :Tabularize /=<CR>
nnoremap <leader>== :Tabularize /=><CR>
vmap <leader>== :Tabularize /=><CR>
nnoremap <leader>: :Tabularize/:<CR>
vmap <leader>: :Tabularize/:<CR>
" line up but dont move ':' to the middle
nnoremap <leader>:: :Tabularize/:\zs<CR>
vmap <leader>:: :Tabularize/:\zs<CR>


"Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'adelarsq/vim-matchit'         " Match words with %


" Snippets
Plug 'SirVer/ultisnips'             " Snippets Engine
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
Plug 'honza/vim-snippets'           " Snippets code


" Syntax
Plug 'vim-scripts/syslog-syntax-file'
Plug 'vim-scripts/apachelogs.vim'
Plug 'vim-scripts/iptables'
Plug 'nfnty/vim-nftables'
Plug 'vim-scripts/openvpn'
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
Plug 'lepture/vim-jinja'
Plug 'tpope/vim-ragtag'            " HTML/XML Mappings
"Plug 'othree/html5.vim'            " HTML5


Plug 'vimwiki/vimwiki'              " Vimwiki - ERROR github username issue!?
let g:vimwiki_list = [{'path': '~/.vim/wiki/'}]
let g:vimwiki_camel_case = 0


Plug 'pearofducks/ansible-vim'      " Ansible syntax etc
let g:ansible_extra_syntaxes = "sh.vim conf.vim dns.vim dnsmasq.vim jinga2.vim json.vim python.vim sudoers.vim sshconfig.vim sshdconfig.vim yaml.vim"
let g:ansible_attribute_highlight = "ab"
"Available flags (bold are defaults):
"a: highlight all instances of key=
"o: highlight only instances of key= found on newlines
"d: dim the instances of key= found
"b: brighten the instances of key= found
"n: turn this highlight off completely

let g:ansible_name_highlight = 'b'
"d: dim the instances of name: found
"b: brighten the instances of name: found
let g:ansible_extra_keywords_highlight = 1
"Note: This option is enabled when set, and disabled when not set.
"Highlight the following additional keywords in playbooks:
"  register always_run changed_when failed_when no_log args vars delegate_to ignore_errors
"By default we only highlight: include until retries delay when only_if become become_user block rescue always notify


Plug 'mhinz/vim-startify'
Plug 'nvie/vim-flake8'

" IDE autocompletion
Plug 'davidhalter/jedi-vim'
"Plug 'fs111/pydoc.vim.git'         " Python docs

"ALE
"let g:ale_completion_enabled = 1
Plug 'w0rp/ale'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

"let b:ale_linters = ['flake8']
let g:ale_linters = {
\ 'python': ['flake8'],
\}
"let b:ale_fixers = ['prettier', 'eslint']
"let b:ale_fixers = [
"\   'remove_trailing_lines',
"\   'isort',
"\   'ale#fixers#generic_python#BreakUpLongLines',
"\   'yapf',
"\]
" isort, autopep8
let g:ale_fixers = {
\    '*': ['remove_trailing_lines'],
\    'python': [
\       'add_blank_lines_for_python_control_statements',
\       'ale#fixers#generic_python#BreakUpLongLines',
\       'yapf3',
\    ],
\    'html': [],
\    'javascript': ['eslint'],
\}
" \ 'python': ['isort', 'ale#fixers#generic_python#BreakUpLongLines'],
let g:ale_fix_on_save = 0
"let g:ale_sign_error = '✗'
"let g:ale_sign_warning = '⚠'
"let g:ale_set_highlights = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Navigate between errors quickly :help ale-navigation-commands
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)
" Do not lint or fix minified files.
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
" Show 5 lines of errors (default: 10)
"let g:ale_list_window_size = 5
"use quicklist insterad (needs both options)
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
" Quick run via <F9>
nnoremap <F9> :call <SID>compile_and_run()<CR>
function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python3 %"
    endif
endfunction
" asyncrun now has an option for opening quickfix automatically
let g:asyncrun_open = 15


Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1

Plug 'hashivim/vim-terraform' " Terraform syntax/completions
let g:terraform_fmt_on_save=1
let g:terraform_align=1

"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }

" Enable/end VimPlug config
call plug#end()


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

" Text generator
iab loremm "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu. Nulla non quam erat, luctus consequat nisi"
iab loremmm "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu. Nulla non quam erat, luctus consequat nisi. Integer hendrerit lacus sagittis erat fermentum tincidunt. Cras vel dui neque. In sagittis commodo luctus. Mauris non metus dolor, ut suscipit dui. Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum. Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor"

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
iab ntorpy    ntropy
iab Ntorpy    Ntropy
"cmap Q q
"cmap W w
"cmap Wq wq
"cmap WQ wq
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
