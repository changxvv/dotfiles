let g:lightline = {}

let g:lightline.active = {
			\ 'left': [['mode', 'paste'],
			\          ['git_branch', 'readonly', 'absolutepath', 'modified'],
			\          ['buffers_count', 'coc_status', 'gutentags']],
			\ 'right': [['lineinfo'],
			\           ['fileformat', 'fileencoding', 'filetype']]
			\ }

let g:lightline.inactive = {
			\ 'left': [['filename']],
			\ 'right': [['lineinfo']]
			\ }


let g:lightline.tabline = {
			\ 'left': [['tabs']],
			\ 'right': []
			\ }
let g:lightline.tab = {
			\ 'active': ['tab_number', 'filename', 'modified'],
			\ 'inactive': ['tab_number', 'filename', 'modified']
			\ }

let g:lightline.component_function = {
			\ 'mode': 'LightlineMode',
			\ 'git_branch': 'LightlineFugitive',
			\ 'readonly': 'LightlineReadonly',
			\ 'buffers_count': 'BuffersCount',
			\ 'gutentags': 'gutentags#statusline',
			\ 'coc_status': 'coc#status'
			\ }

function! LightlineMode()
	if &bt != ''
		if &ft == 'qf' 
			return 'Quickfix'
		elseif &ft == 'dirvish'
			return 'Dirvish'
		endif
	endif
	return &filetype ==# 'unite' ? 'Unite' :
				\ &filetype ==# 'vimfiler' ? 'VimFiler' :
				\ &filetype ==# 'vimshell' ? 'VimShell' :
				\ lightline#mode()
endfunc

function! LightlineFugitive()
	if exists('*FugitiveHead')
		let branch = FugitiveHead()
		return branch !=# '' ? ' '.branch : ''
	endif
	return ''
endfunction

function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction

function! BuffersCount()
	let term_count = has('nvim') ? 0 : len(filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"'))
	let changed_buffer = len(filter(getbufinfo(), 'v:val.changed == 1')) - term_count
	let all_buffer = len(getbufinfo({'buflisted':1}))
	return changed_buffer . '/' . all_buffer
endfunc
