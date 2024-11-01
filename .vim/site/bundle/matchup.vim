" vim-matchup conflicts with matchit, should disable matchit
let g:loaded_matchit = 1

" disable modifying statusline
let g:matchup_matchparen_offscreen = {}

if has('patch-8.1.1500') || has('nvim')
	let g:matchup_matchparen_offscreen.method = 'popup'
endif


" disable modifying statusline
let g:matchup_matchparen_offscreen = {}
