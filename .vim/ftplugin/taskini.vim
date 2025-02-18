"======================================================================
"
" taskini.vim - 
"
" Created by skywind on 2023/09/13
" Last Modified: 2023/09/13 17:02:19
"
"======================================================================
let s:windows = has('win32') || has('win16') || has('win64') || has('win95')


"----------------------------------------------------------------------
" integrity check
"----------------------------------------------------------------------
if exists(':AsyncTask') != 2 || exists(':AsyncRun') != 2
	" force lazy loader to load 
	silent! exec "AsyncRun -mode=load"
	silent! exec "AsyncTask -load"
	if exists(':AsyncTask') != 2 || exists(':AsyncRun') != 2
		runtime! plugin/asyncrun.vim
		runtime! plugin/asynctasks.vim
		if exists(':AsyncTask') != 2 || exists(':AsyncRun') != 2
			finish
		endif
	endif
endif



"----------------------------------------------------------------------
" locals
"----------------------------------------------------------------------
setlocal commentstring=#\ %s
setlocal omnifunc=comptask#omnifunc
