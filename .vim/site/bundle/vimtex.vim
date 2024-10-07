let g:tex_flavor='latex'
set conceallevel=1
let g:tex_conceal='abmg'
let g:vimtex_syntax_conceal = {'math_bounds': 0}
let g:vimtex_compiler_latexmk_engines = {
	\ '_'                : '-xelatex',
	\ 'pdflatex'         : '-pdf',
	\ 'xelatex'          : '-xelatex',
	\}
let g:vimtex_compiler_latexmk = {
	\ 'build_dir' : '',
	\ 'callback' : 1,
	\ 'continuous' : 1,
	\ 'executable' : 'latexmk',
	\ 'hooks' : [],
	\ 'options' : [
	\   '-verbose',
	\   '-file-line-error',
	\   '-shell-escape',
	\   '-synctex=1',
	\   '-interaction=nonstopmode',
	\ ],
	\}
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode = 0
