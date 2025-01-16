" 防止重复加载
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif

" 取得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 定义一个命令用来加载文件
command! -nargs=1 InScript exec 'so '. fnameescape(s:home."/<args>")

" 将 vim 目录加入 runtimepath
exec 'set rtp+='. fnameescape(s:home)

" 将 ~/.vim 目录加入 runtimepath (有时候 vim 不会自动帮你加入）
set rtp+=~/.vim

if exists(':packadd')
	exec 'set packpath+=' . fnameescape(s:home . '/site')
endif

"----------------------------------------------------------------------
" 模块加载
"----------------------------------------------------------------------

" 加载基础配置
InScript init/basic.vim

" 加载扩展配置
InScript init/config.vim

" 加载文件搜索和补全时忽略的扩展名
InScript init/ignores.vim

" 加载工具
InScript init/tools.vim

" 自定义按键
InScript init/keymaps.vim

" 插件设置
InScript init/plugins.vim

"其他
InScript init/misc.vim
InScript init/gui.vim

" 界面样式
InScript init/style.vim
InScript init/unix.vim

" 本地设置
if has('nvim') == 0
	let name = expand('~/.vim/local.vim')
else
	if $XDG_CONFIG_HOME != ''
		let name = $XDG_CONFIG_HOME . '/nvim/local.vim'
	else
		let name = expand('~/.config/nvim/local.vim')
	endif
endif

if filereadable(name)
	exec 'source ' . fnameescape(name)
endif

" OptImport
InScript site/opt/angry.vim
InScript site/opt/after_object.vim

if has('gui_running')
	InScript site/opt/hexhigh.vim
endif

call after_object#enable(['r', 'R'], '=', ':', '-', '#', ' ', '/', ';', '(', ')')

" 插件加载
if !exists('g:bundle_group')
	let g:bundle_group = []
endif

let g:bundle_group += ['basic']
let g:bundle_group += ['inter']
let g:bundle_group += ['high', 'opt']
let g:bundle_group += ['ale', 'floaterm', 'matchup', 'cursorword', 'tex', 'lightline', 'copilot', 'coc']

if len(g:bundle_group) > 0
	InScript bundle.vim
endif

" 主题加载
set bg=dark
set t_Co=256
colorscheme edge
let g:lightline.colorscheme = 'edge'
