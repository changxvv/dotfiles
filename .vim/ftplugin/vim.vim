if &modifiable
	set ff=unix
endif

let b:cursorword = 1


"----------------------------------------------------------------------
" mapping
"----------------------------------------------------------------------
noremap <buffer><F11> :<c-u>silent update<cr>:so %<cr>
