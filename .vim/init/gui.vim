if has('gui_running')
	set gfn=Ligconsolata:h12
	set gfw=Microsoft\ YaHei\ Mono:h12
	set guicursor+=a:blinkon0
	set guioptions=eg
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
" remove signs
"----------------------------------------------------------------------
function! s:GuiSignRemove(...)
	if a:0 == 0 | return | endif
	redir => x
	silent sign place
	redir END
	let lines = split(x, '\n')
	for line in lines
		if line =~ '^\s*line=\d*\s*id=\d*\s*name='
			let name = matchstr(line, '^\s*line=.*name=\zs\w*')
			let id = matchstr(line, '^\s*line=\d*\s*id=\zs\w*')
			for x in range(a:0)
				if name == a:{x + 1}
					silent exec 'sign unplace '.id
				endif
			endfor
		endif
	endfor
endfunc

command! -nargs=+ GuiSignRemove call s:GuiSignRemove(<f-args>)
