"----------------------------------------------------------------------
" settings
"----------------------------------------------------------------------
let g:fzf_layout={'window': {'width':0.9, 'height':0.6}}
let g:fzf_buffers_jump = 1 " [Buffers] Jump to the existing window if possible
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"' " [[B]Commits] Customize the options used by 'git log'
let g:fzf_files_options = '--preview "rougify {2..} | head -'.&lines.'"'
let g:fzf_tags_command = 'ctags -R' " [Tags] Command to generate tags file
let g:fzf_commands_expect = 'alt-enter,ctrl-x' " [Commands] --expect expression for directly executing the command
let g:fzf_preview_window = ['right:50%:hidden:nowrap', '?']

" `g:fzf_action`, `g:fzf_layout`, `g:fzf_colors`, `g:fzf_history_dir` will be used in `fzf#wrap()`
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit',
            \ 'ctrl-s': 'FzfFilesWithFilePath',
            \ 'alt-bs': 'FzfPreLevel',
            \}

func s:enter_file_root(file)
    " call fzf#run(fzf#wrap('ls', {'source': 'ls', 'dir': '/Users/hanley/.vim'}))
    let dir = fnamemodify(a:file, ':p:h')
    call fzf#vim#files(dir, fzf#vim#with_preview())
endfunction


"----------------------------------------------------------------------
" asynctasks
"----------------------------------------------------------------------
function! s:fzf_sink(what)
	let p1 = stridx(a:what, '<')
	if p1 >= 0
		let name = strpart(a:what, 0, p1)
		let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
		if name != ''
			exec "AsyncTask ". fnameescape(name)
		endif
	endif
endfunc

function! s:fzf_task()
	let rows = asynctasks#source(&columns * 48 / 100)
	let source = []
	for row in rows
		let name = row[0]
		let source += [name . '  ' . row[1] . '  : ' . row[2]]
	endfor
	let opts = { 'source': source, 'sink': function('s:fzf_sink'),
				\ 'options': '+m --nth 1 --inline-info --tac' }
	if exists('g:fzf_layout')
		for key in keys(g:fzf_layout)
			let opts[key] = deepcopy(g:fzf_layout[key])
		endfor
	endif
	call fzf#run(opts)
endfunc

command! -nargs=0 AsyncTaskFzf call s:fzf_task()


