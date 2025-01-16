let g:lightline = {}

let g:lightline.active = {
			\ 'left': [['mode', 'paste'],
			\          ['git_branch', 'readonly', 'absolutepath'],
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
			\ 'active': ['tabnum', 'filename', 'modified'],
			\ 'inactive': ['tabnum', 'filename', 'modified']
			\ }

let g:lightline.component = {
			\ 'absolutepath': '%F',
			\ 'paste': '%{&paste?"PASTE":""}',
			\ 'readonly': '%{&readonly?"":""}',
			\ 'modified': '%M',
			\ 'lineinfo': '%3l/%L:%-2c',
			\ 'fileformat': '%{&ff}',
			\ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
			\ 'fileencoding': '%{(&fenc!=#""?&fenc:&enc).(&bomb?",BOM":"")}',
			\ 'filename': '%t',
			\ }

let g:lightline.component_function = {
			\ 'mode': 'LightlineMode',
			\ 'git_branch': 'LightlineFugitive',
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

function! BuffersCount()
	let term_count = has('nvim') ? 0 : len(filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"'))
	let current_buffer = bufnr('%')
	let all_buffer = len(getbufinfo({'buflisted':1}))
	return current_buffer . '(' . all_buffer . ')'
endfunc
