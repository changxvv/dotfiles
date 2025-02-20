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


"----------------------------------------------------------------------
" switch.vim
"----------------------------------------------------------------------
let b:switch_custom_definitions = [
			\ s:switch_css('position', ['static', 'fixed', 'absolute', 'relative']),
			\ s:switch_css('display', ['block', 'inline-block', 'none', 'flex', 'grid']),
			\ s:switch_css('flex-direction', ['row', 'row-reverse', 'column', 'column-reverse']),
			\   {
			\      '\<align\>\s*:\s*left': 'align: right',
			\      '\<align\>\s*:\s*right': 'align: center',
			\      '\<align\>\s*:\s*center': 'align: left',
			\   },
			\ ]
