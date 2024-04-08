"----------------------------------------------------------------------
" airline setup me
"----------------------------------------------------------------------
function AirlineSetupMe(font)
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_powerline_fonts = 0
	let g:airline_exclude_preview = 1
	let g:airline_section_b = '%n'
	let g:airline_section_z = '%l/%L:%v'
	let g:airline_theme='edge'

	if a:font 
		let g:airline_powerline_fonts = 1
		if !exists('g:airline_symbols')
			let g:airline_symbols = {}
		endif
		let g:airline_symbols.branch = "\ue0a0"
		let g:airline_symbols.readonly = "\ue0a2"
		let g:airline_symbols.maxlinenr = "\ue0a1"
		if has('win32') || has('win95') || has('win64') || has('win16')
			if has('gui_running') && &rop =~ 'directx'
				let g:airline_symbols.linenr = ''
				let g:airline_symbols.maxlinenr = ''
			endif
		endif
	endif

	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#show_close_button = 0
	let g:airline#extensions#tabline#show_tab_count = 0
	let g:airline#extensions#tabline#tabs_label = ''
	let g:airline#extensions#tabline#buffers_label = ''
	let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#tab_nr_type = 1
	let g:airline#extensions#tabline#fnamemod = ':t'
	let g:airline#extensions#branch#enabled = 0
	let g:airline#extensions#syntastic#enabled = 0
	let g:airline#extensions#fugitiveline#enabled = 0
	let g:airline#extensions#csv#enabled = 0
	let g:airline#extensions#vimagit#enabled = 0
endfunc


call AirlineSetupMe(get(g:, 'airline_font', 0))
