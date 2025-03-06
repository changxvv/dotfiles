let g:lightline = {}

let g:lightline.active = {
			\ 'left': [['mode', 'paste'],
			\          ['git_branch', 'absolutepath'],
			\          ['buffers_count', 'status', 'gutentags']],
			\ 'right': [['lineinfo'], ['coc_status', 'ale_status', 'percent'],
			\           ['fileformat', 'fileencoding', 'filetype']]
			\ }

let g:lightline.inactive = {
			\ 'left': [['absolutepath'], ['status']],
			\ 'right': [['lineinfo'], ['percent']]
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
			\ 'status': '[%R%H%W]',
			\ 'absolutepath': '%F',
			\ 'paste': '%{&paste?"PASTE":""}',
			\ 'modified': '%M',
			\ 'lineinfo': '%3l/%L:%-2v',
			\ 'fileformat': '%{&ff}',
			\ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
			\ 'fileencoding': '%{(&fenc!=#""?&fenc:&enc).(&bomb?",BOM":"")}',
			\ 'filename': '%t',
			\ }

let g:lightline.component_function = {
			\ 'mode': 'LightlineMode',
			\ 'git_branch': 'LightlineFugitive',
			\ 'buffers_count': 'LightlineBuffersCount',
			\ 'gutentags': 'gutentags#statusline',
			\ 'coc_status': 'coc#status',
			\ 'ale_status': 'LightlineAleStatus'
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

function! LightlineBuffersCount()
	let term_count = has('nvim') ? 0 : len(filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"'))
	let current_buffer = bufnr('%')
	let all_buffer = len(getbufinfo({'buflisted':1}))
	return current_buffer . '(' . all_buffer . ')'
endfunc

function! LightlineAleStatus()
	if getbufvar(bufnr(''), 'ale_linted', 0) == 0
		return ''
	endif

	let l:counts = ale#statusline#Count(bufnr(''))
	let l:all_errors = l:counts.error + l:counts.style_error
	let l:all_non_errors = l:counts.total - l:all_errors

	return l:counts.total == 0 ? '✓' : printf(
				\ 'E:%d W:%d',
				\ all_errors,
				\ all_non_errors,
				\ )
endfunction
