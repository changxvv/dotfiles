"----------------------------------------------------------------------
" 显示设置
"----------------------------------------------------------------------
" show tab
set showtabline=2

"命令栏高度
set cmdheight=1

" 总是显示侧边栏
set signcolumn=yes

" 设置显示制表符等隐藏字符
set list

" 右下角显示命令
set showcmd

" 默认右边显示水平切割的窗口
set splitright
set splitbelow

if has('patch-9.0.648') || has('nvim-0.9.0')
	set splitkeep=screen
endif

"命令栏历史
set history=2000

"消息显示
set shortmess=aoOtTIc

try
    set matchpairs+=【:】,《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:” " Set matching pairs of characters and highlight matching brackets
catch /^Vim\%((\a\+)\)\=:E474/
endtry

set emoji
set concealcursor=n

"----------------------------------------------------------------------
" 更改样式
"----------------------------------------------------------------------

" 更清晰的错误标注：默认一片红色背景，语法高亮都被搞没了
" 只显示红色或者蓝色下划线或者波浪线
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SpellLocal

if has('gui_running')
	hi! SpellBad gui=undercurl guisp=red
	hi! SpellCap gui=undercurl guisp=blue
	hi! SpellRare gui=undercurl guisp=magenta
	hi! SpellLocal gui=undercurl guisp=cyan
else
	hi! SpellBad term=standout cterm=underline
	hi! SpellCap term=underline cterm=underline
	hi! SpellRare term=underline cterm=underline
	hi! SpellLocal term=underline cterm=underline
endif

"----------------------------------------------------------------------
" GVim Dialogs
"----------------------------------------------------------------------
function! s:Filter_Push(desc, wildcard)
	let g:browsefilter .= a:desc . " (" . a:wildcard . ")\t" . a:wildcard . "\n"
endfunc

let g:browsefilter = ''
call s:Filter_Push("All Files", "*")
call s:Filter_Push("C/C++/Object-C", "*.c;*.cpp;*.cc;*.h;*.hh;*.hpp;*.m;*.mm")
call s:Filter_Push("Python", "*.py;*.pyw")
call s:Filter_Push("Text", "*.txt")
call s:Filter_Push("Vim Script", "*.vim")
