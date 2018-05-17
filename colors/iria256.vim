" Vim color file
"
" Name:       iria256.vim
" Version:    0.3
" Maintainer: Stephen Maver mav@ntropy.net
" Note:       Stole color/structure from "Xoria256" & "Ir_black"
"             The format from "Tomorrow Night Bright"
"             Hex colour conversion functions borrowed from "Desert256"
"             Plus a few misc additions of my own.
" Todo:       Tidy up file for v1
"
" Desert256:  Henry So, Jr.
"             http://www.vim.org/scripts/script.php?script_id=1243
" Xoria:      Dmitriy Y. Zotikov
"             http://www.vim.org/scripts/script.php?script_id=2140
" Ir_black:   Todd Werth
"             http://blog.toddwerth.com/entries/8
" TomorrowNightBright: Chris Kempson
"             https://github.com/ChrisKempson/Tomorrow-Theme
"
" Should work in recent 88 & 256 color terminals.
"
" Color numbers (0-255) see:
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

" Init {{{

" Deal with errors on startup
if &t_Co != 256 && ! has("gui_running")
  echomsg ""
  echomsg "Error: t_Co=256 could not be set. Terminal requires 256 color support"
  echomsg ""
  finish
endif

" Init
set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
      syntax reset
    endif
endif
let g:colors_name = "iria256"
" }}}

" Default GUI Colours {{{
let s:foreground = "c0c0c0"
let s:background = "000000"
let s:black      = "000000"
let s:darkest    = "212121"
let s:select     = "333333"
let s:line       = "1c1c1c"
let s:comment    = "606060"
let s:red        = "df8787"
let s:reddark    = "5f0000"
let s:reddiff    = "500000"
let s:orange     = "e78c45"
let s:orangelight= "dfaf87"
let s:orangedark = "ff8700"
let s:yellow     = "e7c547"
let s:yellowlight= "faf4c6"
let s:yellowdark = "e6db74"
let s:green      = "afdf87"
let s:greendark  = "005f00"
let s:greendiff  = "005000"
let s:aqua       = "70c0b1"
let s:blue       = "87afdf"
let s:blueold    = "7aa6da"
let s:bluedark   = "afafdf"
let s:bluediff   = "00005f"
let s:bluedeep   = "005fff"
let s:purple     = "dfafdf"
let s:magenta    = "c397d8"
let s:white      = "ffffff"
" }}}

" Vim Highlighting {{{
fun <SID>do_colours()
    call <SID>X("Normal", s:foreground, s:background, "")
    call <SID>X("LineNr", s:foreground, "", "")
    call <SID>X("NonText", s:comment, "", "")
    call <SID>X("SpecialKey", s:comment, "", "")
    call <SID>X("Search", s:background, s:yellowdark, "bold")
    call <SID>X("TabLine", s:foreground, s:background, "reverse")
    call <SID>X("StatusLine", s:select, s:foreground, "")
    call <SID>X("StatusLineNC", s:foreground, s:background, "")
    call <SID>X("User1", s:foreground, s:select, "")
    call <SID>X("User2", s:red, s:select, "")
    call <SID>X("User3", s:purple, s:select, "")
    call <SID>X("Visual", "", s:select, "")
    call <SID>X("Directory", s:blue, "", "")
    call <SID>X("ModeMsg", s:yellowdark, "", "")
    call <SID>X("MoreMsg", s:yellowdark, "", "")
    call <SID>X("Question", s:yellowdark, "", "")
    call <SID>X("WarningMsg", s:foreground, s:reddark, "")
    call <SID>X("VimCommand", s:blue, "", "none")
    call <SID>X("VimFunction", s:yellowlight, "", "")
    call <SID>X("VimUserFunc", s:yellowlight, "", "")
    call <SID>X("VimVar", s:purple, "", "")
    call <SID>X("VimIsCommand", s:bluedark, "", "")
    call <SID>X("Error", s:foreground, s:reddark, "")
    call <SID>X("ErrorMsg", s:foreground, s:reddark, "")
    call <SID>X("Folded", s:comment, s:black, "")
    call <SID>X("FoldColumn",s:green, s:darkest, "")
    call <SID>X("VertSplit", s:comment, s:select, "")
    call <SID>X("WildMenu", s:green, s:comment, "")
    call <SID>X("SignColumn", s:orange, "", "")
	" .diff
	call <SID>X("diffAdded",   s:foreground, s:greendark, "")
	call <SID>X("diffRemoved", s:foreground, s:reddark, "")
	" vimdiff
	call <SID>X("diffAdd",    "", s:greendiff, "")
	call <SID>X("diffDelete", s:reddark, s:reddark, "")
	call <SID>X("diffChange", "", s:select, "")
	call <SID>X("diffText",   "", s:black, "")
	call <SID>X("CursorColumn", "", s:black, "none")
    if version >= 700
        call <SID>X("CursorLine", "", s:darkest, "none")
        call <SID>X("CursorColumn", "", s:black, "none")
		call <SID>X("ColorColumn", "", s:darkest, "none")
        call <SID>X("PMenu", s:foreground, s:select, "none")
        call <SID>X("PMenuSel", s:foreground, s:select, "reverse")
        call <SID>X("MatchParen", s:green, s:background, "none")
    end

    " Standard Highlighting
    call <SID>X("Comment", s:comment, "", "")
    call <SID>X("Number", s:orange, "", "")
    call <SID>X("Float", s:orange, "", "")
    call <SID>X("Constant", s:orange, "", "")
    call <SID>X("Character", s:orange, "", "")
    call <SID>X("Boolean", s:orange, "", "")
    call <SID>X("String", s:yellowdark, "", "")
    call <SID>X("Statement", s:blue, "", "")
    call <SID>X("Repeat", s:blue, "", "")
    call <SID>X("Label", s:blue, "", "")
    call <SID>X("Exception", s:blue, "", "")
    call <SID>X("Conditional", s:blue, "", "")
    call <SID>X("PreProc", s:green, "", "")
    call <SID>X("Define", s:green, "", "none")
    call <SID>X("Include", s:green, "", "")
    call <SID>X("Macro", s:green, "", "")
    call <SID>X("PreConduit", s:green, "", "")
    call <SID>X("Type", s:bluedark, "", "none")
    call <SID>X("Structure", s:bluedark, "", "")
    call <SID>X("StorageClass", s:blue, "", "")
    call <SID>X("TypeDef", s:bluedark, "", "")
    call <SID>X("Function", s:bluedark, "", "")
    call <SID>X("Special", s:red, "", "")
    call <SID>X("Identifier", s:purple, "", "none")

    call <SID>X("Operator", s:white, "", "none") "s:normal
    call <SID>X("Title", s:comment, "", "")
    call <SID>X("Delimiter", s:comment, "", "")
    call <SID>X("Keyword", s:purple, "", "")
    "call <SID>X("Ignore", "444444", "", "")
    call <SID>X("Todo", s:background, s:yellowdark, "")

	" GitCommit Msg
	call <SID>X("gitcommitHeader", s:comment, "", "")
	call <SID>X("gitcommitSelectedType", s:green, "", "")
	call <SID>X("gitcommitSelectedFile", s:green, "", "")
	call <SID>X("gitcommitDiscardedType", s:yellowdark, "", "")
	call <SID>X("gitcommitDiscardedFile", s:yellowdark, "", "")
	call <SID>X("gitcommitUntrackedFile", s:bluedeep, "", "")

    " PHP Highlighting
    "call <SID>X("phpRegion", s:white, "", "")
    call <SID>X("phpFunctions", s:bluedark, "", "")
    "classes =?!
    call <SID>X("phpClasses", s:green, "", "")
    "methodsvar = $obj->methodVar->methodVar()
    call <SID>X("phpMethodsVar", s:bluedark, "", "")
    " parent = bracket
    call <SID>X("phpParent", s:bluedark, "", "")
    " '->'
    call <SID>X("phpMemberSelector", s:blue, "", "")
    call <SID>X("phpVarSelector", s:purple, "", "")
    call <SID>X("phpKeyword", s:green, "", "")
    call <SID>X("phpRepeat", s:purple, "", "")
    call <SID>X("phpConditional", s:purple, "", "")
    call <SID>X("phpStatement", s:blue, "", "")
    call <SID>X("phpMemberSelector", s:foreground, "", "")

    " Ruby Highlighting
    call <SID>X("rubySymbol", s:green, "", "")
    call <SID>X("rubyConstant", s:yellow, "", "")
    call <SID>X("rubyAttribute", s:blue, "", "")
    call <SID>X("rubyInclude", s:blue, "", "")
    call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
    call <SID>X("rubyCurlyBlock", s:orange, "", "")

    " Python Highlighting
    call <SID>X("pythonInclude", s:purple, "", "")
    call <SID>X("pythonStatement", s:purple, "", "")
    call <SID>X("pythonConditional", s:purple, "", "")
    call <SID>X("pythonFunction", s:blue, "", "")
    highlight link pythonImport PythonStatement

    " JavaScript Highlighting
    call <SID>X("javaScriptBraces", s:foreground, "", "")
    call <SID>X("javaScriptFunction", s:purple, "", "")
    call <SID>X("javaScriptConditional", s:purple, "", "")
    call <SID>X("javaScriptRepeat", s:purple, "", "")
    call <SID>X("javaScriptNumber", s:orange, "", "")
    call <SID>X("javaScriptMember", s:orange, "", "")

    " Vim Highlighting

    " Vimwiki Highlighting
    call <SID>X("wikiHeader1", s:comment, "", "")
    call <SID>X("wikiHeader2", s:comment, "", "")
    call <SID>X("wikiHeader3", s:comment, "", "")
    call <SID>X("wikiHeader4", s:comment, "", "")
    call <SID>X("wikiHeader5", s:comment, "", "")
    call <SID>X("wikiHeader6", s:comment, "", "")

    " C Highlighting
    call <SID>X("cType", s:yellow, "", "")
    call <SID>X("cStorageClass", s:purple, "", "")

endfun

" }}}

" Main {{{
if has("gui_running") || &t_Co == 88 || &t_Co == 256
    " Colour Functions {{{

    " Returns an approximate grey index for the given grey level {{{
    fun <SID>grey_number(x)
        if &t_Co == 88
            if a:x < 23
                return 0
            elseif a:x < 69
                return 1
            elseif a:x < 103
                return 2
            elseif a:x < 127
                return 3
            elseif a:x < 150
                return 4
            elseif a:x < 173
                return 5
            elseif a:x < 196
                return 6
            elseif a:x < 219
                return 7
            elseif a:x < 243
                return 8
            else
                return 9
            endif
        else
            if a:x < 14
                return 0
            else
                let l:n = (a:x - 8) / 10
                let l:m = (a:x - 8) % 10
                if l:m < 5
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun
    " }}}

    " Returns the actual grey level represented by the grey index {{{
    fun <SID>grey_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 46
            elseif a:n == 2
                return 92
            elseif a:n == 3
                return 115
            elseif a:n == 4
                return 139
            elseif a:n == 5
                return 162
            elseif a:n == 6
                return 185
            elseif a:n == 7
                return 208
            elseif a:n == 8
                return 231
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 8 + (a:n * 10)
            endif
        endif
    endfun
    " }}}

    " Returns the palette index for the given grey index {{{
    fun <SID>grey_colour(n)
        if &t_Co == 88
            if a:n == 0
                return 16
            elseif a:n == 9
                return 79
            else
                return 79 + a:n
            endif
        else
            if a:n == 0
                return 16
            elseif a:n == 25
                return 231
            else
                return 231 + a:n
            endif
        endif
    endfun
    " }}}

    " Returns an approximate colour index for the given colour level {{{
    fun <SID>rgb_number(x)
        if &t_Co == 88
            if a:x < 69
                return 0
            elseif a:x < 172
                return 1
            elseif a:x < 230
                return 2
            else
                return 3
            endif
        else
            if a:x < 75
                return 0
            else
                let l:n = (a:x - 55) / 40
                let l:m = (a:x - 55) % 40
                if l:m < 20
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun
    " }}}

    " Returns the actual colour level for the given colour index {{{
    fun <SID>rgb_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 139
            elseif a:n == 2
                return 205
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 55 + (a:n * 40)
            endif
        endif
    endfun
    " }}}

    " Returns the palette index for the given R/G/B colour indices {{{
    fun <SID>rgb_colour(x, y, z)
        if &t_Co == 88
            return 16 + (a:x * 16) + (a:y * 4) + a:z
        else
            return 16 + (a:x * 36) + (a:y * 6) + a:z
        endif
    endfun
    " }}}

    " Returns the palette index to approximate the given RGB colour levels {{{
    fun <SID>colour(r, g, b)
        " Get the closest grey
        let l:gx = <SID>grey_number(a:r)
        let l:gy = <SID>grey_number(a:g)
        let l:gz = <SID>grey_number(a:b)

        " Get the closest colour
        let l:x = <SID>rgb_number(a:r)
        let l:y = <SID>rgb_number(a:g)
        let l:z = <SID>rgb_number(a:b)

        if l:gx == l:gy && l:gy == l:gz
            " There are two possibilities
            let l:dgr = <SID>grey_level(l:gx) - a:r
            let l:dgg = <SID>grey_level(l:gy) - a:g
            let l:dgb = <SID>grey_level(l:gz) - a:b
            let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
            let l:dr = <SID>rgb_level(l:gx) - a:r
            let l:dg = <SID>rgb_level(l:gy) - a:g
            let l:db = <SID>rgb_level(l:gz) - a:b
            let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
            if l:dgrey < l:drgb
                " Use the grey
                return <SID>grey_colour(l:gx)
            else
                " Use the colour
                return <SID>rgb_colour(l:x, l:y, l:z)
            endif
        else
            " Only one possibility
            return <SID>rgb_colour(l:x, l:y, l:z)
        endif
    endfun
    " }}}

    " Returns the palette index to approximate the 'rrggbb' hex string {{{
    fun <SID>rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return <SID>colour(l:r, l:g, l:b)
    endfun
    " }}}

    " Sets the highlighting for the given group {{{
    fun <SID>X(group, fg, bg, attr)
        if a:fg != ""
            exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
        endif
        if a:bg != ""
            exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
        endif
        if a:attr != ""
            exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
        endif
    endfun
    " }}}
    " }}}

    call <SID>do_colours()

    " Delete Functions {{{
    delf <SID>X
    delf <SID>rgb
    delf <SID>colour
    delf <SID>rgb_colour
    delf <SID>rgb_level
    delf <SID>rgb_number
    delf <SID>grey_colour
    delf <SID>grey_level
    delf <SID>grey_number
    delf <SID>do_colours
    " }}}
endif
" }}}
