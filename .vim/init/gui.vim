if has('gui_running')
	set gfn=Ligconsolata:h12
	set gfw=Microsoft\ YaHei\ Mono:h12
	set guicursor+=a:blinkon0
	set guioptions=e
endif


"----------------------------------------------------------------------
"- FontBoldOff
"----------------------------------------------------------------------
function! s:FontBoldOff()
	let hid = 1
	while 1
		let hln = synIDattr(hid, 'name')
		if !hlexists(hln) | break | endif
		if hid == synIDtrans(hid) && synIDattr(hid, 'bold')
			let atr = ['underline', 'undercurl', 'reverse', 'inverse', 'italic', 'standout']
			call filter(atr, 'synIDattr(hid, v:val)')
			let gui = empty(atr) ? 'NONE' : join(atr, ',')
			exec 'highlight ' . hln . ' gui=' . gui
		endif
		let hid += 1
	endwhile
endfunc

command! FontBoldOff call s:FontBoldOff()


"----------------------------------------------------------------------
" Update Highlight
"----------------------------------------------------------------------
function! s:GuiThemeHighlight()
	highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE 
		\ gui=NONE guifg=DarkGrey guibg=NONE
	highlight Pmenu guibg=darkgrey guifg=black
endfunc

command! -nargs=0 GuiThemeHighlight call s:GuiThemeHighlight()


"----------------------------------------------------------------------
" GUI detection
"----------------------------------------------------------------------
let g:asc_gui = 0

if has('gui_running')
	let g:asc_gui = 1
elseif has('nvim')
	if exists('g:GuiLoaded')
		if g:GuiLoaded != 0
			let g:asc_gui = 1
		endif
	elseif exists('*nvim_list_uis') && len(nvim_list_uis()) > 0
		let uis = nvim_list_uis()[0]
		let g:asc_gui = get(uis, 'ext_termcolors', 0)? 0 : 1
	elseif exists("+termguicolors") && (&termguicolors) != 0
		let g:asc_gui = 1
	endif
endif


"----------------------------------------------------------------------
"- GUI Setting
"----------------------------------------------------------------------
if has('nvim') && (has('win32') || has('win64'))
	set guioptions-=L
	set mouse=a
	set showtabline=2
	set laststatus=2
	set signcolumn=yes
	set number
	set t_Co=256
	let g:config_vim_tab_style = 3
endif


"----------------------------------------------------------------------
" Purify NVim-Qt
"----------------------------------------------------------------------
function! s:GuiPureNVim()
	if has('nvim') && g:asc_gui
		call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
		call rpcnotify(0, "Gui", "Option", "Popupmenu", 0)
	endif
endfunc

command! -nargs=0 GuiPureNVim call s:GuiPureNVim()
