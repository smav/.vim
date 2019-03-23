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
