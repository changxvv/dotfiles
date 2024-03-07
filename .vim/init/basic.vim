"----------------------------------------------------------------------
" 基础设置
"----------------------------------------------------------------------
set hls ic is scs ru nu ls=2 so=7 bs=2 ai cin aw ar sr mouse=a nocp wak=no ttimeout ttm=30 nopaste

set cb^=unnamed,unnamedplus

" 设置缩进宽度
set sw=2

" 设置 TAB 宽度
set ts=2

" 禁止展开 tab (noexpandtab)
set noet

" 如果后面设置了 expandtab 那么展开 tab 为多少字符
set softtabstop=0


"----------------------------------------------------------------------
" 编码设置
"----------------------------------------------------------------------
if has('multi_byte')
	" 内部工作编码
	set encoding=utf-8
	set termencoding=utf-8

	" 文件默认编码
	set fileencoding=utf-8

	" 打开文件时自动尝试下面顺序的编码
	set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
endif


"----------------------------------------------------------------------
" 允许 Vim 自带脚本根据文件类型自动设置缩进等
"----------------------------------------------------------------------
if has('autocmd')
	filetype plugin indent on
endif


"----------------------------------------------------------------------
" 语法高亮设置
"----------------------------------------------------------------------
if has('syntax')
	syntax enable
	syntax on
endif


"----------------------------------------------------------------------
" 其他设置
"----------------------------------------------------------------------

" 显示最后一行
set display=lastline

" 允许下方显示目录
set wmnu
set wildoptions+=pum,fuzzy
set wildmode=lastused,full

" 延迟绘制
set lazyredraw

" 错误格式
set errorformat+=%.\ %#-->\ %f:%l:%c,[%f:%l]\ ->\ %m,[%f:%l]:%m

" Virtual edit is useful for visual block edit
set virtualedit=block

" 分隔符可视
set listchars=tab:\|\ ,nbsp:␣,extends:❯,precedes:❮,eol:↲,trail:·
set showbreak=↪

" 设置tags
set tags=./.tags;,.tags

" 文件换行符，默认使用 unix 换行符
set ffs=unix,dos,mac

" 丢失焦点就保存
au FocusLost * silent! wa

" reveal already opened files from the quickfix window 
" instead of opening new buffers
set switchbuf=useopen,newtab


"----------------------------------------------------------------------
" Format 设置
"----------------------------------------------------------------------

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m

" 合并两行中文时，不在中间加空格
set formatoptions+=B

au BufEnter * set fo-=c fo-=r fo-=o

set formatlistpat=^\\s*                     " Optional leading whitespace
set formatlistpat+=[                        " Start character class
set formatlistpat+=\\[({]\\?                " |  Optionally match opening punctuation
set formatlistpat+=\\(                      " |  Start group
set formatlistpat+=[0-9]\\+                 " |  |  Numbers
set formatlistpat+=\\\|                     " |  |  or
set formatlistpat+=[a-zA-Z]\\+              " |  |  Letters
set formatlistpat+=\\)                      " |  End group
set formatlistpat+=[\\]:.)}                 " |  Closing punctuation
set formatlistpat+=]                        " End character class
set formatlistpat+=\\s\\+                   " One or more spaces
set formatlistpat+=\\\|                     " or
set formatlistpat+=^\\s*[-–+o*•]\\s\\+      " Bullet points
" This handles a broader range of lists
" 1.  Typical item the default handles
" a.  An item with an alphabetic character and punctuation
" (2) An item with punctuation preceding and following it
" •   An item consisting of leading punctuation


"----------------------------------------------------------------------
" Diff 设置
"----------------------------------------------------------------------
set diffopt=
set diffopt+=vertical  " show diff in vertical position
set diffopt+=filler  " show filler for deleted lines
if has('patch-8.1.2289')
    set diffopt+=closeoff  " turn off diff when one file window is closed
endif
set diffopt+=context:3  " context for diff
set diffopt+=internal,indent-heuristic,algorithm:patience


"----------------------------------------------------------------------
" 设置代码折叠
"----------------------------------------------------------------------
if has('folding')
	" 允许代码折叠
	set foldenable

	" 代码折叠默认使用缩进
	set fdm=marker

	set foldopen-=hor

	" 默认打开所有缩进
	set foldlevel=99
endif
