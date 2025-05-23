"----------------------------------------------------------------------
" 基础设置
"----------------------------------------------------------------------
set hls ic is scs ru nu rnu so=7 bs=2 ai cin ar aw nocp wak=no ttimeout ttm=30 nopaste

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
	set fileencodings=ucs-bom,utf-8,gbk,gb2312,gb18030,iso-8859-2,big5,euc-jp,cp936,latin1


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
set synmaxcol=500


"----------------------------------------------------------------------
" 其他设置
"----------------------------------------------------------------------

" 显示最后一行
set display=lastline

" 允许下方显示目录
set wmnu
set wildoptions+=pum,fuzzy
set wildmode=longest,full

" 延迟绘制
set lazyredraw

" 错误格式
set errorformat+=%.\ %#-->\ %f:%l:%c,[%f:%l]\ ->\ %m,[%f:%l]:%m

" Virtual edit is useful for visual block edit
set virtualedit=block

" 分隔符可视
set listchars=tab:\|\ ,eol:↲,extends:»,precedes:«,nbsp:~,trail:-
set linebreak
set showbreak=↪
set ambiwidth=double

" 设置tags
set tags=./.tags;,.tags

" 文件换行符，默认使用 unix 换行符
set ffs=unix,dos,mac

" 丢失焦点就保存
au FocusLost * silent! wa

" reveal already opened files from the quickfix window 
" instead of opening new buffers
set switchbuf=useopen,newtab

" 禁止响铃
set novisualbell
set belloff=all

" External program to use for grep command
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m
else
    set grepprg=grep\ -nH\ $*
endif


"----------------------------------------------------------------------
" Format 设置
"----------------------------------------------------------------------

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B
"合并注释的时候删除注释符
set formatoptions+=j

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

if has('patch-8.2.0860')
    set nrformats+=unsigned " ignore sign of number when increase or decrease
endif


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
if has('patch-8.2.0001')
	set diffopt+=internal,algorithm:histogram
	set diffopt+=indent-heuristic
endif


"----------------------------------------------------------------------
" 设置代码折叠
"----------------------------------------------------------------------
if has('folding')
	" 允许代码折叠
	set foldenable

	" 代码折叠默认使用缩进
	set fdm=indent

	set foldopen-=hor

	" 默认打开所有缩进
	set foldlevel=99
endif
