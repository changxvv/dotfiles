"----------------------------------------------------------------------
" term compatible
"----------------------------------------------------------------------
if asclib#platform#has('win')
	if has('nvim') == 0 && has('gui_running') == 0
		" fix: https://github.com/vim/vim/issues/13956
		exec 'set t_ut='
	endif
elseif asclib#platform#has_wsl()
	" fixed: vim will enter replace mode in wsl with cmd window
	exec 'set t_u7='
endif

"----------------------------------------------------------------------
" 备份设置
"----------------------------------------------------------------------

" 允许备份
set backup

" 保存时备份
set writebackup

" 备份文件地址，统一管理
set backupdir=~/.vim/tmp

" 备份文件扩展名
set backupext=.bak

" 禁用交换文件
set noswapfile

" 禁用 undo文件
set noundofile

if !has('nvim')
	set ttymouse=sgr
	set balloonevalterm
endif

" 创建目录，并且忽略可能出现的警告
let path = expand('~/.vim/tmp')
	if isdirectory(path) == 0
		silent! call mkdir(path, 'p', 0755)
endif

set maxmempattern=5000

if has('patch-9.0.1921')
    set jumpoptions=stack
endif

if has('arabic')
    set noarabicshape
endif


"----------------------------------------------------------------------
" 配置微调
"----------------------------------------------------------------------

" 修正 ScureCRT/XShell 以及某些终端乱码问题，主要原因是不支持一些
" 终端控制命令，比如 cursor shaping 这类更改光标形状的 xterm 终端命令
" 会令一些支持 xterm 不完全的终端解析错误，显示为错误的字符，比如 q 字符
" 如果你确认你的终端支持，不会在一些不兼容的终端上运行该配置，可以注释
if has('nvim')
	set guicursor=
elseif (!has('gui_running')) && has('terminal') && has('patch-8.0.1200')
	let g:termcap_guicursor = &guicursor
	set guicursor=
	if has('patch-8.2.2345')
		execute "set <FocusGained>=\<Esc>[I"
		execute "set <FocusLost>=\<Esc>[O"
	endif
endif

" MARK: These settings must be placed before setting the colorscheme. It is also important that the value of the vim term variable is not changed after these settings.
" Styled and colored underline support
let &t_AU = "\e[58:5:%dm"
let &t_8u = "\e[58:2:%lu:%lu:%lum"
let &t_Us = "\e[4:2m"
let &t_Cs = "\e[4:3m"
let &t_ds = "\e[4:4m"
let &t_Ds = "\e[4:5m"
let &t_Ce = "\e[4:0m"
" Strikethrough
let &t_Ts = "\e[9m"
let &t_Te = "\e[29m"
" Truecolor support
let &t_8f = "\e[38:2:%lu:%lu:%lum"
let &t_8b = "\e[48:2:%lu:%lu:%lum"
let &t_RF = "\e]10;?\e\\"
let &t_RB = "\e]11;?\e\\"
" Bracketed paste
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
let &t_PS = "\e[200~"
let &t_PE = "\e[201~"
" Cursor control
let &t_RC = "\e[?12$p"
let &t_SH = "\e[%d q"
let &t_RS = "\eP$q q\e\\"
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[1 q"
let &t_VS = "\e[?12l"
" Focus tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"
" Window title
let &t_ST = "\e[22;2t"
let &t_RT = "\e[23;2t"

" 打开文件时恢复上一次光标所在位置
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\ exe "normal! g`\"" |
	\ endif


"----------------------------------------------------------------------
" terminal turn
"----------------------------------------------------------------------
if has('unix')
	" disable modifyOtherKeys
	if exists('+t_TI') && exists('+t_TE')
		let &t_TI = ''
		let &t_TE = ''
	endif
	let s:uname = system('uname')
	let s:xterm = 0
	if s:uname =~ "FreeBSD"
		let s:xterm = 1
	endif
	" restore screen after quitting
	if s:xterm != 0
		if &term =~ "xterm"
			let &t_ti="\0337\033[r\033[?47h"
			let &t_te="\033[?47l\0338"
			if has("terminfo")
				let &t_Sf="\033[3%p1%dm"
				let &t_Sb="\033[4%p1%dm"
			else
				let &t_Sf="\033[3%dm"
				let &t_Sb="\033[4%dm"
			endif
		endif
		set restorescreen
	endif
endif
