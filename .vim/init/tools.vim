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


" calculate the md5
ca Hash w !cpp -dD -P -fpreprocessed \| tr -d '[:space:]' \| md5sum \| cut -c-8


"----------------------------------------------------------------------
" remove trailing white-spaces
"----------------------------------------------------------------------
command! -nargs=0 StripTrailingWhitespace call s:StripTrailingWhitespace()
function! s:StripTrailingWhitespace()
	let _s=@/
	let l = line(".")
	let c = col(".")
	" do the business:
	exec '%s/\r$\|\s\+$//e'
	" clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunc


"----------------------------------------------------------------------
" cd to file directory
"----------------------------------------------------------------------
command! -nargs=0 CdToFileDir call s:CdToFileDir()
function! s:CdToFileDir()
	if &buftype == '' && expand('%') != ''
		silent exec 'cd ' . fnameescape(expand('%:p:h'))
		exec 'pwd'
	endif
endfunc


"----------------------------------------------------------------------
" cd to project root
"----------------------------------------------------------------------
command! -nargs=0 CdToProjectRoot call s:CdToProjectRoot()
function! s:CdToProjectRoot()
	if &buftype == '' && expand('%') != ''
		let root = asclib#path#get_root(expand('%:p'))
		silent exec 'cd ' . fnameescape(root)
		exec 'pwd'
	endif
endfunc


"----------------------------------------------------------------------
" list loaded scripts
"----------------------------------------------------------------------
command! -nargs=0 ScriptNames call s:ScriptNames()
function! s:ScriptNames()
	redir => x
	silent scriptnames
	redir END
	tabnew
	let save = @0
	let @0 = x
	exec 'normal "0Pggdd'
	let @0 = save
	setlocal nomodified
endfunc



"----------------------------------------------------------------------
" sudo write
"----------------------------------------------------------------------
command! -nargs=0 -bang SudoWrite call s:SudoWrite('<bang>')
function! s:SudoWrite(bang) abort
	let t = expand('%')
	if !empty(&bt)
		echohl ErrorMsg
		echo "E382: Cannot write, 'buftype' option is set"
		echohl None
	elseif empty(t)
		echohl ErrorMsg
		echo 'E32: No file name'
		echohl None
	elseif !executable('sudo')
		echohl ErrorMsg
		echo 'Error: not find sudo executable'
		echohl None
	elseif executable('tee') == 0 && executable('busybox') == 0
		echohl ErrorMsg
		echo 'Error: not find tee/busybox executable'
		echohl None
	else
		let e = executable('tee')? 'tee' : 'busybox tee'
		exec printf('w%s !sudo %s %s > /dev/null', a:bang, e, shellescape(t))
		if !v:shell_error
			edit!
		endif
	endif
endfunc


"----------------------------------------------------------------------
" break long lines to small lines of 76 characters.
"----------------------------------------------------------------------
command! -nargs=1 LineBreaker call s:LineBreaker(<q-args>)
function! s:LineBreaker(width)
	let width = &textwidth
	let p1 = &g:formatprg
	let p2 = &l:formatprg
	let &textwidth = str2nr(a:width)
	set formatprg=
	setlocal formatprg=
	exec 'normal ggVGgq'
	let &textwidth = width
	let &g:formatprg = p1
	let &l:formatprg = p2
endfunc


"----------------------------------------------------------------------
" http://www.drchip.org/astronaut/vim/index.html#Maps 
"----------------------------------------------------------------------
command! -nargs=0 DisplayHighlightGroup call s:DisplayHighlightGroup()
function! s:DisplayHighlightGroup() abort
	let h1 = synIDattr(synID(line("."), col("."),1), "name")
	let h2 = synIDattr(synID(line("."), col("."),0), "name")
	let h3 = synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")
	echo printf('hi<%s> trans<%s> lo<%s>', h1, h2, h3)
endfunc


"----------------------------------------------------------------------
" DiffOrig command
"----------------------------------------------------------------------
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # |
				\ 0d_ | diffthis | wincmd p | diffthis
endif


"----------------------------------------------------------------------
" display side by side diff in a new tabpage
" usage: DiffSplit <left_file> <right_file>
"----------------------------------------------------------------------
command! -nargs=+ -complete=file DiffSplit call s:DiffSplit(<f-args>)
function! s:DiffSplit(...) abort
	if a:0 != 2
		echohl ErrorMsg
		echom 'ERROR: Require two file names.'
		echohl None
	else
		exec 'tabe ' . fnameescape(a:1)
		exec 'rightbelow vert diffsplit ' . fnameescape(a:2)
		setlocal foldlevel=20
		exec 'wincmd p'
		setlocal foldlevel=20
		exec 'normal! gg]c'
	endif
endfunc


"----------------------------------------------------------------------
" Shougo: AddNumber
"----------------------------------------------------------------------
command! -range -nargs=1 AddNumbers
			\ call s:AddNumbers((<line2>-<line1>+1) * eval(<args>))
function! s:AddNumbers(num)
	let prev_line = getline('.')[: col('.')-1]
	let next_line = getline('.')[col('.') :]
	let prev_num = matchstr(prev_line, '\d\+$')
	if prev_num != ''
		let next_num = matchstr(next_line, '^\d\+')
		let new_line = prev_line[: -len(prev_num)-1] .
					\ printf('%0'.len(prev_num).'d',
					\    max([0, prev_num . next_num + a:num])) . 
					\    next_line[len(next_num):]
	else
		let new_line = prev_line . substitute(next_line, '\d\+',
					\ "\\=printf('%0'.len(submatch(0)).'d',
					\         max([0, submatch(0) + a:num]))", '')
	endif

	if getline('.') !=# new_line
		call setline('.', new_line)
	endif
endfunc


"----------------------------------------------------------------------
" AsyncRun
"----------------------------------------------------------------------
command! -bang -nargs=* -complete=file Make AsyncRun -program=make -once=1 -strip=1 @ <args>

command! -bang -bar -nargs=* Gpush execute 'AsyncRun<bang> -cwd=' .
	  \ fnameescape(FugitiveGitDir()) '-post=echo\ "done" git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'AsyncRun<bang> -cwd=' .
	  \ fnameescape(FugitiveGitDir()) '-post=echo\ "done" git fetch' <q-args>

command! Ghistory :0Gclog! -- %
