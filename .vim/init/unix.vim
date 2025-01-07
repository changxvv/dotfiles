set vop=folds,cursor
set cpo-=<
set viminfo+=!
set viewdir=~/.vim/view
set whichwrap=b,s,<,>,[,]
set browsedir=buffer
set keymodel=
set selection=inclusive

" spell
set spelllang=en,cjk
set spellsuggest+=9

" complete
set cpt=.,w,k

if exists('+breakindent')
	set breakindent
endif

set completeopt=menu,menuone,noselect

" enable new-style cursorline (for numbers only)
if exists('+cursorlineopt')
	set cursorlineopt=number cursorline
endif

" new blowfish2 
if has('patch-7.4.500') || v:version >= 800
	if !has('nvim')
		set cryptmethod=blowfish2
	endif
endif

" setup shell 
if &shell =~# 'fish'
	set shell=sh
endif


"----------------------------------------------------------------------
" 文件类型微调
"----------------------------------------------------------------------
augroup AscUnixGroup
	" 清除同组的历史 autocommand
	au!

	au FileType * call s:language_setup()

	" 强制对某些扩展名的 filetype 进行纠正
	au BufNewFile,BufRead *.as setlocal filetype=actionscript
	au BufNewFile,BufRead *.pro setlocal filetype=prolog
	au BufNewFile,BufRead *.es setlocal filetype=erlang
	au BufNewFile,BufRead *.asc setlocal filetype=asciidoc
	au BufNewFile,BufRead *.vl setlocal filetype=verilog
	au BufNewFile,BufRead *.bxrc setlocal filetype=bxrc
	au BufNewFile,BufRead *.odin setlocal filetype=odin
	au BufNewFile,BufRead *.comp setlocal filetype=comp
	au BufNewFile,BufRead *.lua.rename setlocal filetype=lua
	au BufNewFile,BufRead *.fmt setlocal filetype=protogen
	" jsonc纠正
	au BufNewFile,BufRead *.cjson setlocal filetype=jsonc
	au BufNewFile,BufRead coc-settings.json setlocal filetype=jsonc
	au BufNewFile,BufRead .eslintrc.json setlocal filetype=jsonc
	au BufNewFile,BufRead tsconfig*.json setlocal filetype=jsonc
	au BufNewFile,BufRead jsconfig.json setlocal filetype=jsonc
augroup END


"----------------------------------------------------------------------
" language setup (on FileType autocmd)
"----------------------------------------------------------------------
function! s:language_setup()
	" echom "FileType: " . &ft
	if &ft == 'qf'
		setlocal nonumber
	endif
	let tags = expand("~/.vim/tags/") . &ft . '.tags'
	let dict = expand("~/.vim/dict/") . &ft . '.dict'
	if filereadable(tags)
		exec "setlocal tags+=" . fnameescape(tags)
	endif
	if filereadable(dict)
		exec "setlocal dict+=" . fnameescape(dict)
	endif
endfunc


" Persistent folding information
function! s:fold_restore(enable)
	if a:enable == 'true' || a:enable == 'yes' || a:enable != 0
		augroup VimUnixFoldGroup
			au! 
			au BufWrite,VimLeave * silent! mkview
			au BufRead * silent! loadview
		augroup END
	else
		augroup VimUnixFoldGroup
			au!
		augroup END
	endif
endfunc

command! -nargs=1 PersistFoldEnable call s:fold_restore(<q-args>)
