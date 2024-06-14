"----------------------------------------------------------------------
" UltiSnips
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h:h')

let g:UltiSnipsEditSplit = 'context'

let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=['UltiSnips', s:home."/site/ultisnips"]
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = s:home . "/site/ultisnips"

function! UltiSnipQuery()
	call UltiSnips#SnippetsInCurrentScope(1)
	for [key, info] in items(g:current_ulti_dict_info)
		echo key
		echo info
	endfor
endfunc
