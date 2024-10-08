"----------------------------------------------------------------------
" locals 
"----------------------------------------------------------------------
setlocal expandtab 
" setlocal ts=2 sts=2 sw=2


"----------------------------------------------------------------------
" switch function
"----------------------------------------------------------------------
function! s:switch_css(name, values)
	let definition = {}
	let size = len(a:values)
	for index in range(size)
		let inext = index + 1
		let inext = (inext >= size)? 0 : inext
		let word = a:values[index]
		let next = a:values[inext]
		let key = printf('\<%s\>\s*:\s*\<%s\>', a:name, word)
		let val = printf('%s: %s', a:name, next)
		let definition[key] = val
	endfor
	return definition
endfunc
