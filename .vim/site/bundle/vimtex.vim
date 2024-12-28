let g:tex_flavor='latex'
let g:vimtex_complete_enabled = 0
let g:vimtex_syntax_conceal_disable = 1
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
let g:vimtex_view_general_viewer = 'okular'
