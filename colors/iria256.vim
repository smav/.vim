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


" Deal with errors on startup
if &t_Co != 256 && ! has("gui_running")
  echomsg ""
  echomsg "Error: t_Co=256 could not be set. Terminal requires 256 color support"
  echomsg ""
  finish
endif

set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
      syntax reset
    endif
endif
let g:colors_name = "iria256"

" Default GUI Colours
let s:foreground = "c0c0c0" " #c0c0c0
let s:background = "000000" " #000000
let s:black      = "000000" " #000000
let s:darkest    = "191919" " #191919
let s:select     = "333333" " #333333
let s:line       = "1c1c1c" " #1c1c1c
let s:comment    = "606060" " #606060
let s:greydark   = "222222" " #222222
let s:grey       = "808080" " #808080
let s:greymed    = "A4A4A4" " #A4A4A4
let s:greylight  = "DDDDDD" " #DDDDDD
let s:red        = "df8787" " #df8787
let s:reddark    = "5f0000" " #5f0000
let s:reddiff    = "500000" " #500000
let s:orange     = "e78c45" " #e78c45
let s:orangemed  = "d6b32a" " #d6b32a
let s:orangelight= "dfaf87" " #dfaf87
let s:orangelight2= "f4b95f" " #f4b95f
let s:orangedark = "ff8700" " #ff8700
let s:yellow     = "e7c547"  " #7c547
let s:yellowlight= "faf4c6" " #faf4c6
let s:yellowlight2= "eaeaa8" " #eaeaa8
let s:yellowlight3= "d1d198" " #d1d198
let s:yellowdark = "e6db74" " #e6db74
let s:yellowdark2 = "878B08" " #878B08
let s:yellowdark3 = "AEB405" " #AEB405
let s:green      = "afdf87" " #afdf87
let s:greenlight = "a8eaa8" " #a8eaa8
let s:green2     = "008f00" " #008f00
let s:greendark  = "005f00" " #005f00
let s:greendiff  = "005000" " #005000
let s:aqua       = "70c0b1" " #70c0b1
let s:blue       = "87afdf" " #87afdf
let s:blueold    = "7aa6da" " #7aa6da
let s:bluedark   = "afafdf" " #afafdf
let s:bluediff   = "00005f" " #00005f
let s:bluedeep   = "005fff" " #005fff
let s:purple     = "dfafdf" " #dfafdf
let s:magenta    = "c397d8" " #c397d8
let s:white      = "ffffff" " #ffffff

" Vim Highlighting
fun <SID>do_colours()
    call <SID>X("qfFileName", s:green, "", "")
    call <SID>X("Normal", s:foreground, s:background, "")
    call <SID>X("LineNr", s:comment, "", "")
    call <SID>X("NonText", s:comment, "", "")
    call <SID>X("SpecialKey", s:comment, "", "")
    call <SID>X("Search", s:background, s:yellowlight, "reverse,bold")
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
    call <SID>X("VimComment", s:comment, "", "none")
    call <SID>X("VimOperParen", s:greylight, "", "none")
    call <SID>X("VimLineComment", s:comment, "", "none")
    call <SID>X("VimCommentTitle", s:grey, "", "none")
    call <SID>X("VimFunction", s:yellowlight, "", "")
    call <SID>X("VimFuncSid", s:purple, "", "")
    call <SID>X("VimUserFunc", s:blue, "", "")
    call <SID>X("VimVar", s:purple, "", "bold")
    call <SID>X("VimIsCommand", s:bluedark, "", "")
    call <SID>X("vimOption", s:bluedark, "", "")
    call <SID>X("vimHLGroup", s:bluedark, "", "")
    call <SID>X("vimNotation", s:bluedark, "", "")
    call <SID>X("vimContinue", s:white, "", "")
    call <SID>X("vimMapModKey", s:bluedark, "", "")
    call <SID>X("Error", s:foreground, s:reddark, "")
    call <SID>X("ErrorMsg", s:foreground, s:reddark, "")
    call <SID>X("Folded", s:comment, s:black, "")
    call <SID>X("FoldColumn",s:green, s:darkest, "")
    call <SID>X("VertSplit", s:comment, s:select, "")
    call <SID>X("WildMenu", s:greenlight, s:comment, "")
    call <SID>X("SignColumn", s:foreground, s:greydark, "")
    call <SID>X("ExtraWhitespace", s:reddark, "", "")
    call <SID>X("BadWhitespace", s:reddark, "", "")
    " .diff
    call <SID>X("diffAdded",   s:foreground, s:greendiff, "")
    call <SID>X("diffRemoved", s:foreground, s:reddiff, "")
    " vimdiff
    call <SID>X("diffAdd",    s:greylight, s:greendiff, "")
    call <SID>X("diffDelete", s:black, s:reddiff, "")
    call <SID>X("diffChange", "", s:select, "")
    call <SID>X("diffText",   "", s:black, "")
    call <SID>X("CursorColumn", "", s:black, "none")
    if version >= 700
        call <SID>X("CursorLine", "", s:darkest, "none")
        call <SID>X("CursorColumn", "", s:black, "none")
        call <SID>X("ColorColumn", "", s:darkest, "none")
        call <SID>X("PMenu", s:foreground, s:select, "none")
        call <SID>X("PMenuSel", s:foreground, s:select, "reverse")
        call <SID>X("MatchParen", s:greenlight, s:background, "none")
    end

    " Standard Highlighting
    call <SID>X("SpellBad", s:reddark, "", "")
    call <SID>X("Comment", s:comment, "", "")
    call <SID>X("Number", s:orangelight2, "", "")
    call <SID>X("Float", s:orangelight2, "", "")
    call <SID>X("Constant", s:greenlight, "", "")
    call <SID>X("Character", s:yellowdark, "", "")
    call <SID>X("Boolean", s:greenlight, "", "")
    call <SID>X("String", s:yellowlight2, "", "")
    call <SID>X("Statement", s:blue, "", "")
    call <SID>X("Repeat", s:blue, "", "")
    call <SID>X("Label", s:blue, "", "")
    call <SID>X("Exception", s:blue, "", "")
    call <SID>X("Conditional", s:blue, "", "")
    call <SID>X("PreProc", s:bluedark, "", "")
    call <SID>X("Define", s:greenlight, "", "none")
    call <SID>X("Include", s:greenlight, "", "")
    call <SID>X("Macro", s:greenlight, "", "")
    call <SID>X("PreConduit", s:greenlight, "", "")
    call <SID>X("Type", s:bluedark, "", "none")
    call <SID>X("Structure", s:bluedark, "", "")
    call <SID>X("StorageClass", s:blue, "", "")
    call <SID>X("TypeDef", s:bluedark, "", "")
    call <SID>X("Function", s:bluedark, "", "")
    call <SID>X("Special", s:red, s:reddark, "")
    call <SID>X("Identifier", s:purple, "", "bold")
    call <SID>X("Operator", s:white, "", "none") "s:normal
    call <SID>X("Title", s:greymed, "", "")
    call <SID>X("Delimiter", s:greymed, "", "")
    call <SID>X("Keyword", s:purple, "", "")
    "call <SID>X("Ignore", "444444", "", "")
    call <SID>X("Todo", s:yellowdark, s:greydark, "")
    call <SID>X("shSpecial", s:white, "", "")
    call <SID>X("shCtrlSeq", s:white, "", "")
    call <SID>X("shTestOpr", s:bluedark, "", "")
    call <SID>X("shOperator", s:bluedark, "", "")
    call <SID>X("shRange", s:bluedark, "", "")
    call <SID>X("shExpr", s:greylight, "", "")
    call <SID>X("shVar", s:greylight, "", "bold")
    call <SID>X("shVarAssign", s:white, "", "")
    "call <SID>X("shVariable", s:purple, "", "bold")
    call <SID>X("shDerefVar", s:purple, "", "")
    call <SID>X("shCommandSub", s:greylight, "", "")
    call <SID>X("shStatement", s:bluedark, "", "")
    call <SID>X("shLoop", s:blue, "", "")
    call <SID>X("kshStatement", s:bluedark, "", "")


    " GitCommit Msg
    call <SID>X("gitcommitHeader", s:comment, "", "")
    call <SID>X("gitcommitSelectedType", s:greenlight, "", "")
    call <SID>X("gitcommitSelectedFile", s:greenlight, "", "")
    call <SID>X("gitcommitDiscardedType", s:yellowdark, "", "")
    call <SID>X("gitcommitDiscardedFile", s:yellowdark, "", "")
    call <SID>X("gitcommitUntrackedFile", s:bluedeep, "", "")

    " Markdown
    call <SID>X("markdownError", s:foreground, "", "")
    " PHP
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

    " Ruby
    call <SID>X("rubySymbol", s:green, "", "")
    call <SID>X("rubyConstant", s:yellow, "", "")
    call <SID>X("rubyAttribute", s:blue, "", "")
    call <SID>X("rubyInclude", s:blue, "", "")
    call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
    call <SID>X("rubyCurlyBlock", s:orange, "", "")

    " Python Highlighting (red = not available?)
    call <SID>X("pythonInclude", s:white, "", "")
    call <SID>X("pythonSelf", s:purple, "", "")
    call <SID>X("pythonStatement", s:purple, "", "")
    call <SID>X("pythonConditional", s:purple, "", "")
    call <SID>X("pythonClass", s:bluedark, "", "")
    call <SID>X("pythonFunction", s:blue, "", "")
    call <SID>X("pythonBuiltin", s:white, "", "")
    call <SID>X("pythonBuiltinFunc", s:purple, "", "")
    call <SID>X("pythonBuiltinObj", s:bluedark, "", "")
    call <SID>X("pythonBuiltinType", s:purple, "", "")
    call <SID>X("pythonAttribute", s:red, "", "")
    call <SID>X("pythonDecorator", s:grey, "", "")
    call <SID>X("pythonDecoratorName", s:grey, "", "")
    call <SID>X("pythonImport", s:white, "", "")
    call <SID>X("pythonRun", s:greenlight, "", "")
    call <SID>X("pythonCoding", s:green, "", "")
    call <SID>X("pythonOperator", s:greylight, "", "")
    call <SID>X("pythonExtraOperator", s:greylight, "", "")
    call <SID>X("pythonException", s:purple, "", "")
    call <SID>X("pythonExceptions", s:blue, "", "")
    call <SID>X("pythonBoolean", s:greenlight, "", "")
    call <SID>X("pythonString", s:yellowlight2, "", "")
    call <SID>X("pythonStrInterpRegion", s:yellowdark2, "", "")
    call <SID>X("pythonBytesEscape", s:yellowdark2, "", "")
    call <SID>X("pythonStrFormat", s:yellowdark2, "", "")
    call <SID>X("pythonDot", s:white, "", "")
    call <SID>X("pythonRepeat", s:purple, "", "")
    call <SID>X("pythonDottedName", s:blue, "", "")
    call <SID>X("pythonDocString", s:yellowdark2, "", "")
    call <SID>X("pythonDocTest2", s:yellowdark, "", "")
    " Pip
    call <SID>X("dosiniHeader", s:greylight, "", "")
    call <SID>X("dosiniValue", s:yellowlight3, "", "")

    " Terraform
    call <SID>X("terraResourceTypeBI", s:blue, "", "")
    call <SID>X("terraResourceTypeStr", s:yellowlight, "", "")
    call <SID>X("terraValueString", s:yellowlight, "", "")
    call <SID>X("terraBrackets", s:bluedark, "", "")
    "call <SID>X("terraBraces", s:greydark, "", "")
    call <SID>X("terraResourceName", s:orangelight, "", "")
    call <SID>X("terraDataTypeBI", s:blue, "", "")


    " JavaScript
    call <SID>X("javaScriptBraces", s:foreground, "", "")
    call <SID>X("javaScriptFunction", s:purple, "", "")
    call <SID>X("javaScriptConditional", s:purple, "", "")
    call <SID>X("javaScriptIdentifier", s:bluedark, "", "")
    call <SID>X("javaScriptRepeat", s:purple, "", "")
    call <SID>X("javaScriptNumber", s:orangelight2, "", "")
    call <SID>X("javaScriptMember", s:orangelight2, "", "")
    call <SID>X("javaScriptNull", s:orangelight2, "", "")
    call <SID>X("javaScriptParens", s:bluedark, "", "")

    " Jinja
    call <SID>X("htmlString", s:yellowdark3, "", "")
    call <SID>X("jinjaTagBlock", s:greenlight, "", "")
    call <SID>X("jinjaStatement", s:purple, "", "")
    call <SID>X("jinjaArgument", s:yellowdark3, "", "")
    call <SID>X("jinjaVarBlock", s:greenlight, "", "")
    call <SID>X("jinjaFilter", s:greenlight, "", "")

    " Json
    call <SID>X("jsonKeyword", s:bluedark, "", "")
    call <SID>X("jsonQuote", s:yellow, "", "")
    call <SID>X("jsonBraces", s:bluedark, "", "")
    call <SID>X("jsonString", s:yellowlight3, "", "")
    call <SID>X("jsonEscape", s:yellowdark2, "", "")

    " YAML
    call <SID>X("yamlKeyValueDelimiter", s:white, "", "")
    call <SID>X("yamlBlockMappingKey", s:blue, "", "")
    call <SID>X("yamlBlockCollectionItemStart", s:blue, "", "")
    "call <SID>X("yamlPlainScalar", s:yellowlight3, "", "")
    call <SID>X("yamlDocumentStart", s:white, "", "")
    call <SID>X("yamlFlowString", s:yellowlight2, "", "")
    call <SID>X("yamlAnchor", s:purple, "", "bold")
    call <SID>X("yamlAlias", s:purple, "", "")

    " Ansible
    call <SID>X("ansible_name", s:blue, "", "")
    call <SID>X("ansible_attributes", s:purple, "", "")

    " CSS
    call <SID>X("cssBraces", s:bluedark, "", "")
    call <SID>X("cssFunctionName", s:yellowdark, "", "")
    call <SID>X("cssIdentifier", s:orangelight2, "", "")
    call <SID>X("cssClassName", s:greenlight, "", "")
    call <SID>X("cssColor", s:blue, "", "")
    call <SID>X("cssSelectorOp", s:blue, "", "")
    call <SID>X("cssSelectorOp2", s:blue, "", "")
    call <SID>X("cssImportant", s:greendiff, "", "")
    call <SID>X("cssVendor", s:grey, "", "")
    call <SID>X("cssTextProp", s:bluedark, "", "")
    call <SID>X("cssAnimationProp", s:bluedark, "", "")
    call <SID>X("cssUIProp", s:yellow, "", "")
    call <SID>X("cssTransformProp", s:bluedark, "", "")
    call <SID>X("cssTransitionProp", s:bluedark, "", "")
    call <SID>X("cssPrintProp", s:bluedark, "", "")
    call <SID>X("cssPositioningProp", s:yellow, "", "")
    call <SID>X("cssBoxProp", s:bluedark, "", "")
    call <SID>X("cssFontDescriptorProp", s:bluedark, "", "")
    call <SID>X("cssFlexibleBoxProp", s:bluedark, "", "")
    call <SID>X("cssBorderOutlineProp", s:bluedark, "", "")
    call <SID>X("cssBackgroundProp", s:bluedark, "", "")
    call <SID>X("cssMarginProp", s:bluedark, "", "")
    call <SID>X("cssListProp", s:bluedark, "", "")
    call <SID>X("cssTableProp", s:bluedark, "", "")
    call <SID>X("cssFontProp", s:bluedark, "", "")
    call <SID>X("cssPaddingProp", s:bluedark, "", "")
    call <SID>X("cssDimensionProp", s:bluedark, "", "")
    call <SID>X("cssRenderProp", s:bluedark, "", "")
    call <SID>X("cssColorProp", s:bluedark, "", "")
    call <SID>X("cssGeneratedContentProp", s:bluedark, "", "")
    call <SID>X("cssUnitDecorators", s:foreground, "", "")
    call <SID>X("cssValueLength", s:orangedark, "", "")
    call <SID>X("cssValueNumber", s:orangedark, "", "")
    call <SID>X("cssBorderAttr", s:orangedark, "", "")
    call <SID>X("cssCommonAttr", s:orangedark, "", "")
    call <SID>X("cssTextAttr", s:orangedark, "", "")
    call <SID>X("cssColor", s:yellow, "", "")
    call <SID>X("cssNoise", s:grey, "", "")

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

    " Firewall Highlighting
    call <SID>X("iptablesSaveDirective", s:purple, "", "")
    call <SID>X("iptablesSaveOperation", s:blue, "", "")
    call <SID>X("iptablesSaveTable", s:orange, "", "")
    call <SID>X("iptablesSaveTarget", s:orange, "", "")
    call <SID>X("iptablesBuiltinChain", s:blue, "", "")
    call <SID>X("iptablesCommand", s:purple, "", "")
    call <SID>X("iptablesParam", s:white, "", "")
    call <SID>X("iptablesOperator", s:white, "", "")
    call <SID>X("iptablesModuleName", s:blue, "", "")
    call <SID>X("iptablesModuleType", s:purple, "", "")
    call <SID>X("iptablesString", s:yellowdark, "", "")
    call <SID>X("iptablesComment", s:greydark, "", "")
    call <SID>X("iptablesBadComment", s:reddark, "", "")
    call <SID>X("iptablesTodo", s:yellowdark2, "", "")
    call <SID>X("iptablesLongParam", s:reddark, "", "")

    " XML
    call <SID>X("xmlTag", s:bluedark, "", "")
    call <SID>X("xmlTagName", s:bluedark, "", "")
    call <SID>X("xmlEndTag", s:bluedark, "", "")
endfun


" Main
if has("gui_running") || &t_Co == 88 || &t_Co == 256

    " Returns an approximate grey index for the given grey level
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

    " Returns the actual grey level represented by the grey index
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

    " Returns the palette index for the given grey index
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

    " Returns an approximate colour index for the given colour level
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

    " Returns the actual colour level for the given colour index
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

    " Returns the palette index for the given R/G/B colour indices
    fun <SID>rgb_colour(x, y, z)
        if &t_Co == 88
            return 16 + (a:x * 16) + (a:y * 4) + a:z
        else
            return 16 + (a:x * 36) + (a:y * 6) + a:z
        endif
    endfun

    " Returns the palette index to approximate the given RGB colour levels
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

    " Returns the palette index to approximate the 'rrggbb' hex string
    fun <SID>rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return <SID>colour(l:r, l:g, l:b)
    endfun

    " Sets the highlighting for the given group
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

    call <SID>do_colours()

    " Delete Functions
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

endif
