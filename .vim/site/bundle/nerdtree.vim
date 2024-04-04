"----------------------------------------------------------------------
" ignores
"----------------------------------------------------------------------
let s:ignore = ['.obj', '.so', '.a', '~', '.tmp', '.egg', '.class', '.jar']
let s:ignore += ['.tar.gz', '.zip', '.7z', '.bz2', '.rar', '.jpg', '.png']
let s:ignore += ['.chm', '.docx', '.xlsx', '.pptx', '.pdf', '.dll', '.pyd']
let s:ignore += ['.xls', '.mobi', '.mp4', '.mp3']


"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
let NERDTreeIgnore = ['\~$', '\$.*$', '\.swp$', '\.pyc$', '#.\{-\}#$']

for s:extname in s:ignore
	let NERDTreeIgnore += [escape(s:extname, '.~$')]
endfor

let NERDTreeRespectWildIgnore = 1

" let g:vinegar_nerdtree_as_netrw = 1

let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 0

" let g:NERDTreeFileExtensionHighlightFullName = 1
" let g:NERDTreeExactMatchHighlightFullName = 1
" let g:NERDTreePatternMatchHighlightFullName = 1

function! GetRoot(path, ...)
	let markers = ['.root', '.git', '.hg', '.svn', '.project']
	if a:0 > 0
		if type(a:1) == type([])
			let markers = a:1
		endif
	endif
	let strict = (a:0 >= 2)? (a:2) : 0
	let l:hr = s:find_root(a:path, markers, strict)
	if s:windows != 0
		let l:hr = join(split(l:hr, '/', 1), "\\")
	endif
	return l:hr
endfunc

nnoremap <leader>tn :exec "NERDTree " . fnameescape(GetRoot('%'))<cr>
nnoremap <leader>to :NERDTreeFocus<cr>
nnoremap <leader>tm :NERDTreeMirror<cr>
nnoremap <leader>tt :exec "NERDTreeToggle " . fnameescape(GetRoot('%'))<cr>


"----------------------------------------------------------------------
" enable cursorlineopt
"----------------------------------------------------------------------
function! s:init_nerdtree_ft()
	if exists('+cursorlineopt')
		setlocal cursorlineopt=number,line
	endif
endfunc


"----------------------------------------------------------------------
" register event handler
"----------------------------------------------------------------------
augroup MyNERDTreeEvent
	au!
	au FileType nerdtree call s:init_nerdtree_ft()
augroup END
