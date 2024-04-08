"----------------------------------------------------------------------
" UltiSnips
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h:h')

let g:UltiSnipsEditSplit = 'context'

let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=['UltiSnips', s:home."/site/ultisnips"]
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = s:home . "/site/ultisnips"

" function! s:ultisnip_init()
" 	inoremap <m-e> <c-r>=UltiSnips#ExpandSnippetOrJump()<cr>
" 	inoremap <m-E> <c-r>=UltiSnips#JumpBackwards()<cr>
" 	inoremap <m-n> <c-r>=UltiSnips#JumpForwards()<cr>
" 	inoremap <m-p> <c-r>=UltiSnips#JumpBackwards()<cr>
" endfunction

" augroup UltiSnipGroup
" 	au!
" 	au VimEnter * call s:ultisnip_init() 
" augroup END

function! UltiSnipQuery()
	call UltiSnips#SnippetsInCurrentScope(1)
	for [key, info] in items(g:current_ulti_dict_info)
		echo key
		echo info
	endfor
endfunc
