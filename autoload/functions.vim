" Utility Functions

" Create vim support folders
"stolen form spf13
function! functions#SetupFolders() abort
    " this will create a backup, undo, swap and views folders in $home/$prefix
    let separator = "."
    let parent = $HOME
    let prefix = '.vim/tmp'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    " tmp dir first
    let directory = parent . '/' . prefix . "/"
    if exists("*mkdir")
        if !isdirectory(directory)
            call mkdir(directory)
        endif
    endif
    if !isdirectory(directory)
        echo "warning: unable to create backup directory: " . directory
        echo "try: mkdir -p " . directory
    endif

    " make and set vim tmp dirs
    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . '/' . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "warning: unable to create backup directory: " . directory
            echo "try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction

" Custom fold text
function! functions#MyFoldText() abort
	" for now, just don't try if version isn't 7 or higher
	if v:version < 701
		return foldtext()
	endif
	" clear fold from fillchars to set it up the way we want later
	let &l:fillchars = substitute(&l:fillchars,',\?fold:.','','gi')
	let l:numwidth = (v:version < 701 ? 8 : &numberwidth)
	if &fdm=='diff'
		let l:linetext=''
		let l:foldtext='---------- '.(v:foldend-v:foldstart+1).' lines the same ----------'
		let l:align = winwidth(0)-&foldcolumn-(&nu ? Max(strlen(line('$'))+1, l:numwidth) : 0)
		let l:align = (l:align / 2) + (strlen(l:foldtext)/2)
		" note trailing space on next line
		setlocal fillchars+=fold:\
	elseif !exists('b:foldpat') || b:foldpat==0
		let l:foldtext = ' '.(v:foldend-v:foldstart).' lines folded'.v:folddashes.'|'
		let l:endofline = (&textwidth>0 ? &textwidth : 80)
		let l:linetext = strpart(getline(v:foldstart),0,l:endofline-strlen(l:foldtext))
		let l:align = l:endofline-strlen(l:linetext)
		setlocal fillchars+=fold:-
	elseif b:foldpat==1
		let l:align = winwidth(0)-&foldcolumn-(&nu ? Max(strlen(line('$'))+1, l:numwidth) : 0)
		let l:foldtext = ' '.v:folddashes
		let l:linetext = substitute(getline(v:foldstart),'\s\+$','','')
		let l:linetext .= ' ---'.(v:foldend-v:foldstart-1).' lines--- '
		let l:linetext .= substitute(getline(v:foldend),'^\s\+','','')
		let l:linetext = strpart(l:linetext,0,l:align-strlen(l:foldtext))
		let l:align -= strlen(l:linetext)
		setlocal fillchars+=fold:-
	endif
	return printf('%s%*s', l:linetext, l:align, l:foldtext)
endfunction

" Custom fold text - basic
function! functions#MyFoldText_basic() abort
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . ' ' . foldedlinecount . ' lines'
endfunction

" Custom fold text - kept for inspiration
function! functions#MyFoldText2() abort
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction

" redefine x for virtualEdit 
" for a more natural/vim-like delete behaviour
"function! functions#Redefine_x_ForVirtualEdit() abort
"  if &ve != "" && col('.') >= col('$')
"    normal $
"  endif
"endfu!
"silent! unmap x
"nnoremap <silent>x x:call Redefine_x_ForVirtualEdit()<CR>

" TrimWhiteSpace - Remove trailing whitespace from the end of file
function! functions#TrimWhiteSpace() abort
	" Substitute trailing white space
	%s/\s*$//
	" Return cursor to last position
	''
endfunction

" Below are for use in a vim statusline

" WordCount - Count the words in current buffer
" from http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
function! functions#WordCount() abort
  let s:old_status = v:statusmsg
  exe "silent normal g\<c-g>"
  " Add some error checking
  if (v:statusmsg != "--No lines in buffer--")
    let s:word_count = str2nr(split(v:statusmsg)[11])
  else
    let s:word_count = 0
  endif
  let v:statusmsg = s:old_status
  return s:word_count
endfunction

" SynStack - Show syntax highlighting groups for word under cursor
"nmap <C-P> :call <SID>SynStack()<CR>
function! <SID>SynStack() abort
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" HasPaste
" Echos PASTE or '', for use in statusbar
"function! functions#HasPaste()
"    if &paste
"        return 'PASTE'
"    else
"        return ''
"    endif
"endfunction