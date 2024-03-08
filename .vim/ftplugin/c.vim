if exists('b:ftplugin_init_c')
	if get(b:, 'did_ftplugin', 0) == 2
		finish
	endif
endif

let b:ftplugin_init_c = 1

" prevent vim-plug set ft=? twice
if exists('b:did_ftplugin')
	let b:did_ftplugin = 2
endif

if &ft == 'cpp'
	setlocal commentstring=//\ %s
endif

let b:commentary_format = "// %s"
let b:cursorword = 1
