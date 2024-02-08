" Open Explore in new tab with current directory
function! Open_Explore(where)
	let l:path = expand("%:p:h")
	if l:path == ''
		let l:path = getcwd()
	endif
	if a:where < 0
		exec 'Rexplore'
	elseif a:where == 0
		exec 'Explore '
	elseif a:where == 1
		exec 'Vexplore! '
	elseif a:where == 2
		exec 'Texplore'
	endif
endfunc

function! Open_Browse(where)
	let l:path = expand("%:p:h")
	if l:path == '' | let l:path = getcwd() | endif
	if exists('g:browsefilter') && exists('b:browsefilter')
		if g:browsefilter != ''
			let b:browsefilter = g:browsefilter
		endif
	endif
	if a:where == 0
		exec 'browse e '.fnameescape(l:path)
	elseif a:where == 1
		exec 'browse vnew '.fnameescape(l:path)
	else
		exec 'browse tabnew '.fnameescape(l:path)
	endif
endfunc

" delete buffer keep window
function! s:BufferClose(bang, buffer)
	let l:bufcount = bufnr('$')
	let l:switch = 0 	" window which contains target buffer will be switched
	if empty(a:buffer)
		let l:target = bufnr('%')
	elseif a:buffer =~ '^\d\+$'
		let l:target = bufnr(str2nr(a:buffer))
	else
		let l:target = bufnr(a:buffer)
	endif
	if l:target <= 0
		echohl ErrorMsg
		echomsg "cannot find buffer: '" . a:buffer . "'"
		echohl NONE
		return 0
	endif
	if !getbufvar(l:target, "&modifiable")
		echohl ErrorMsg
		echomsg "Cannot close a non-modifiable buffer"
		echohl NONE
		return 0
	endif
	if empty(a:bang) && getbufvar(l:target, '&modified')
		echohl ErrorMsg
		echomsg "No write since last change (use :BufferClose!)"
		echohl NONE
		return 0
	endif
	if bufnr('#') > 0	" check alternative buffer
		let l:aid = bufnr('#')
		if l:aid != l:target && buflisted(l:aid) && getbufvar(l:aid, "&modifiable")
			let l:switch = l:aid	" switch to alternative buffer
		endif
	endif
	if l:switch == 0	" check non-scratch buffers
		let l:index = l:bufcount
		while l:index >= 0
			if buflisted(l:index) && getbufvar(l:index, "&modifiable")
				if strlen(bufname(l:index)) > 0 && l:index != l:target
					let l:switch = l:index	" switch to that buffer
					break
				endif
			endif
			let l:index = l:index - 1	
		endwhile
	endif
	if l:switch == 0	" check scratch buffers
		let l:index = l:bufcount
		while l:index >= 0
			if buflisted(l:index) && getbufvar(l:index, "&modifiable")
				if l:index != l:target
					let l:switch = l:index	" switch to a scratch
					break
				endif
			endif
			let l:index = l:index - 1
		endwhile
	endif
	if l:switch  == 0	" check if only one scratch left
		if strlen(bufname(l:target)) == 0 && (!getbufvar(l:target, "&modified"))
			echo "This is the last scratch" 
			return 0
		endif
	endif
	let l:ntabs = tabpagenr('$')
	let l:tabcc = tabpagenr()
	let l:wincc = winnr()
	let l:index = 1
	while l:index <= l:ntabs
		exec 'tabn '.l:index
		while 1
			let l:wid = bufwinnr(l:target)
			if l:wid <= 0 | break | endif
			exec l:wid.'wincmd w'
			if l:switch == 0
				exec 'enew!'
				let l:switch = bufnr('%')
			else
				exec 'buffer '.l:switch
			endif
		endwhile
		let l:index += 1
	endwhile
	exec 'tabn ' . l:tabcc
	exec l:wincc . 'wincmd w'
	exec 'bdelete! '.l:target
	return 1
endfunction

command! -bang -nargs=? BufferClose call s:BufferClose('<bang>', '<args>')

" open explorer/finder
function! Show_Explore()
	let l:locate = expand("%:p:h")
	if has('win32') || has('win64') || has('win16')
		exec "!start /b cmd.exe /C explorer.exe ".shellescape(l:locate)
	endif
endfunc


function! Tools_BellUnix()
    let l:t_ti = &t_ti
    let l:t_te = &t_te
    let &t_ti = ""
    let &t_te = ""
    silent !printf "\a"
    redraw!
    let &t_ti = l:t_ti
    let &t_te = l:t_te
endfunc

function! Tools_BellConflict()
	silent exec 'norm! \<ESC>'
endfunc


function! Tools_SwitchSigns()
	if (!has('signs')) || (!has('patch-7.4.2210'))
		return 0
	endif
	if &signcolumn == 'auto'
		set signcolumn=yes
		echo ':signcolumn=yes'
	elseif &signcolumn == 'yes'
		set signcolumn=no
		echo ':signcolumn=no'
	else
		set signcolumn=auto
		echo ':signcolumn=auto'
	endif
endfunc

" 0:up, 1:down, 2:pgup, 3:pgdown 4:top, 5:bottom, 
function! Tools_QuickfixCursor(mode)
	function! s:quickfix_cursor(mode)
		if &buftype == 'quickfix'
			if a:mode == 0
				exec "normal! \<c-y>"
			elseif a:mode == 1
				exec "normal! \<c-e>"
			elseif a:mode == 2
				exec "normal! ".winheight('.')."\<c-y>"
			elseif a:mode == 3
				exec "normal! ".winheight('.')."\<c-e>"
			elseif a:mode == 4
				normal! gg
			elseif a:mode == 5
				normal! G
			elseif a:mode == 6
				exec "normal! \<c-u>"
			elseif a:mode == 7
				exec "normal! \<c-d>"
			elseif a:mode == 8
				exec "normal! k"
			elseif a:mode == 9
				exec "normal! j"
			endif
		endif
	endfunc
	let l:winnr = winnr()			
	noautocmd silent! windo call s:quickfix_cursor(a:mode)
	noautocmd silent! exec ''.l:winnr.'wincmd w'
endfunc

" 0:up, 1:down, 2:pgup, 3:pgdown, 4:top, 5:bottom
function! Tools_PreviousCursor(mode)
	if winnr('$') <= 1
		return
	endif
	noautocmd silent! wincmd p
	if a:mode == 0
		exec "normal! \<c-y>"
	elseif a:mode == 1
		exec "normal! \<c-e>"
	elseif a:mode == 2
		exec "normal! ".winheight('.')."\<c-y>"
	elseif a:mode == 3
		exec "normal! ".winheight('.')."\<c-e>"
	elseif a:mode == 4
		normal! gg
	elseif a:mode == 5
		normal! G
	elseif a:mode == 6
		exec "normal! \<c-u>"
	elseif a:mode == 7
		exec "normal! \<c-d>"
	elseif a:mode == 8
		exec "normal! k"
	elseif a:mode == 9
		exec "normal! j"
	endif
	noautocmd silent! wincmd p
endfunc


function! Tools_ListMeta(mapmode, upper)
	let text = []
	for i in range(26)
		let ch = nr2char(char2nr(a:upper? 'A' : 'a') + i)
		redir => x
		exec "silent ". a:mapmode . " <M-" . ch . ">"
		redir END
		let x = substitute(x, '^\s*\(.\{-}\)\s*\n*$', '\1', '')
		let h = "<M-". ch . ">     "
		if x =~ 'No mapping found'
			let text += [h . "                 ---<free>---"]
		else
			for y in split(x, '\n')
				let z = substitute(y, '\n', '', 'g')
				let text += [h .z]
			endfor
		endif
	endfor
	call sort(text)
	for x in text
		echo x
	endfor
endfunc


command! -nargs=1 -bang AscListMeta 
			\ call Tools_ListMeta(<q-args>, <bang>0)


"----------------------------------------------------------------------
" https://github.com/lilydjwg/dotvim 
"----------------------------------------------------------------------
function! GetPatternAtCursor(pat)
	let col = col('.') - 1
	let line = getline('.')
	let ebeg = -1
	let cont = match(line, a:pat, 0)
	while (ebeg >= 0 || (0 <= cont) && (cont <= col))
		let contn = matchend(line, a:pat, cont)
		if (cont <= col) && (col < contn)
			let ebeg = match(line, a:pat, cont)
			let elen = contn - ebeg
			break
		else
			let cont = match(line, a:pat, contn)
		endif
	endwhile
	if ebeg >= 0
		return strpart(line, ebeg, elen)
	else
		return ""
	endif
endfunc


"----------------------------------------------------------------------
" Remove some path from $PATH
"----------------------------------------------------------------------
function! s:RemovePath(path) abort
	let windows = 0
	let path = a:path
	let sep = ':'
	let parts = []
	if has('win32') || has('win64') || has('win32unix') || has('win95')
		let windows = 1
		let path = tolower(path)
		let path = asclib#string#replace(path, '\', '/')
		let sep = ';'
	endif
	for n in split($PATH, sep)
		let key = n
		if windows != 0 
			let key = tolower(key)
			let key = asclib#string#replace(key, '\', '/')
		endif
		if key != path 
			let parts += [n]
		endif
	endfor
	let text = join(parts, sep)
	let $PATH = text
endfunc

command! -nargs=1 EnvPathRemove call s:RemovePath(<q-args>)
