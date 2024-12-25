"----------------------------------------------------------------------
" 计算当前 init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

if !exists(':IncScript')
	command! -nargs=1 IncScript exec 'so ' . fnameescape(s:home .'/<args>')
endif

function! bundle#path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc

function! s:path(path)
	return bundle#path(a:path)
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
let g:bundle_enabled = {}
for key in g:bundle_group | let g:bundle_enabled[key] = 1 | endfor
let s:enabled = g:bundle_enabled

call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))


"----------------------------------------------------------------------
" 默认插件 
"----------------------------------------------------------------------
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'bootleq/vim-cycle'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'

" color scheme
Plug 'sainnhe/edge'

if has('nvim') == 0 && v:version >= 900
	Plug 'monkoose/vim9-stargate'
	IncScript site/bundle/stargate.vim
else
	Plug 'easymotion/vim-easymotion'
	IncScript site/bundle/easymotion.vim
endif

nnoremap gb= :Tabularize /=<CR>
vnoremap gb= :Tabularize /=<CR>
nnoremap gb/ :Tabularize /\/\//l4c1<CR>
vnoremap gb/ :Tabularize /\/\//l4c1<CR>
nnoremap gb* :Tabularize /\/\*/l4c1<cr>
vnoremap gb* :Tabularize /\/\*/l4c1<cr>
nnoremap gb, :Tabularize /,/r0l1<CR>
vnoremap gb, :Tabularize /,/r0l1<CR>
nnoremap gbl :Tabularize /\|<cr>
vnoremap gbl :Tabularize /\|<cr>
nnoremap gbc :Tabularize /#/l4c1<cr>
vnoremap gbc :Tabularize /#/l4c1<cr>
nnoremap gb<bar> :Tabularize /\|<cr>
vnoremap gb<bar> :Tabularize /\|<cr>
nnoremap gbr :Tabularize /\|/r0<cr>
vnoremap gbr :Tabularize /\|/r0<cr>

nmap gz <Plug>Sneak_s
nmap gZ <Plug>Sneak_S
nmap \ <Plug>Sneak_;
vmap gz <Plug>Sneak_s
vmap gZ <Plug>Sneak_S
xmap gz <Plug>Sneak_s
xmap gZ <Plug>Sneak_S

IncScript site/bundle/dirvish.vim
IncScript site/bundle/cycle.vim


"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if has_key(s:enabled, 'basic')
	Plug 't9md/vim-choosewin'
	Plug 'tpope/vim-rhubarb'
	Plug 'mhinz/vim-startify'
	Plug 'terryma/vim-expand-region'
	Plug 'skywind3000/vim-dict'
	Plug 'tommcdo/vim-exchange'
	Plug 'tommcdo/vim-lion'
	Plug 'tpope/vim-eunuch'
	
	Plug 'pprovost/vim-ps1', { 'for': 'ps1' }
	Plug 'tbastos/vim-lua', { 'for': 'lua' }
	Plug 'vim-python/python-syntax', { 'for': ['python'] }
	Plug 'pboettch/vim-cmake-syntax', { 'for': ['cmake'] }
	Plug 'skywind3000/vim-flex-bison-syntax', { 'for': ['yacc', 'lex'] }
	Plug 'lark-parser/vim-lark-syntax'
	Plug 'nathangrigg/vim-beancount', { 'for': 'bean' }
	Plug 'dylon/vim-antlr'
	Plug 'beyondmarc/hlsl.vim'
	if has('patch-9.0.1767') == 0
		Plug 'peterhoeg/vim-qml'
	endif
	Plug 'neovimhaskell/haskell-vim'
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }
	Plug 'jamessan/vim-gnupg'
	Plug 'preservim/vim-markdown'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

	Plug 'kana/vim-textobj-user'
	Plug 'kana/vim-textobj-syntax'
  Plug 'kana/vim-textobj-entire'
	Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
	Plug 'bps/vim-textobj-python', {'for': 'python'}
	Plug 'jceb/vim-textobj-uri'
	Plug 'sgur/vim-textobj-parameter'

	if mapcheck('ii', 'v') == ''
		Plug 'kana/vim-textobj-indent'
	endif

	if has_key(s:enabled, 'targets')
		Plug 'wellle/targets.vim'
		IncScript site/bundle/targets.vim
	endif
	
	if has('python3') || has('python')
		Plug 'Yggdroot/LeaderF'
		Plug 'tamago324/LeaderF-filer'
		Plug 'voldikss/LeaderF-emoji'
		IncScript site/bundle/leaderf.vim
	endif

	let g:tex_conceal = ""
	let g:vim_markdown_math = 1
	let g:vim_markdown_conceal_code_blocks = 0
  let g:vim_markdown_new_list_item_indent = 2
	let g:vim_markdown_frontmatter = 1

	" let g:cpp_class_scope_highlight = 1
	let g:cpp_member_variable_highlight = 1
	let g:cpp_class_decl_highlight = 1
	" let g:cpp_experimental_simple_template_highlight = 1
	let g:cpp_concepts_highlight = 1
	" let g:cpp_no_function_highlight = 1
	let g:cpp_posix_standard = 1

	let g:python_highlight_builtins = 1
	let g:python_highlight_builtin_objs = 1
	let g:python_highlight_builtin_types = 1
	let g:python_highlight_builtin_funcs = 1

	nmap <m-e> <Plug>(choosewin)
	map <m-+> <Plug>(expand_region_expand)
	map <m-_> <Plug>(expand_region_shrink)
end


"----------------------------------------------------------------------
" 进阶插件
"----------------------------------------------------------------------
if has_key(s:enabled, 'inter')
	Plug 'vim-scripts/L9'
	Plug 'mattn/webapi-vim'
	Plug 'mattn/gist-vim'
	Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
	if v:version >= 800 || has('nvim')
		Plug 'rbong/vim-flog', { 'branch': 'v1' }
	endif
	Plug 'inkarkat/vim-ingo-library'
	Plug 'inkarkat/vim-mark'
endif


"----------------------------------------------------------------------
" 高级插件
"----------------------------------------------------------------------
if has_key(s:enabled, 'high')
	Plug 'kshenoy/vim-signature'
	Plug 'mhinz/vim-signify'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'dhruvasagar/vim-table-mode'
endif


"----------------------------------------------------------------------
" 优化插件
"----------------------------------------------------------------------
if has_key(s:enabled, 'opt')
	Plug 'tpope/vim-speeddating'
	Plug 'jreybert/vimagit'

	Plug 'AndrewRadev/switch.vim'
	IncScript site/bundle/switch.vim

	Plug 'mattn/emmet-vim',  { 'on': 'EmmetInstall' }
	IncScript site/bundle/emmet.vim

	if executable('tmux')
		Plug 'benmills/vimux'
	endif

	let g:gutentags_modules = []
	if executable('ctags')
		let g:gutentags_modules += ['ctags']
	endif
	if executable('gtags-cscope') && executable('gtags')
		let g:gutentags_modules += ['gtags_cscope']
	endif
	if len(g:gutentags_modules) > 0
		Plug 'skywind3000/vim-gutentags'
		Plug 'skywind3000/gutentags_plus'
	endif

	if has('win32') || has('win64')
		let g:python3_host_prog="python"
	endif
endif


"----------------------------------------------------------------------
" modules
"----------------------------------------------------------------------
" gdb
if has_key(s:enabled, 'gdb')
	IncScript site/bundle/gdb.vim
endif

" endwise
if has_key(s:enabled, 'endwise')
	Plug 'tpope/vim-endwise'
endif

" tex and snippet
if has_key(s:enabled, 'tex') && (has('python3') || has('python'))
	Plug 'lervag/vimtex'
	Plug 'honza/vim-snippets'
	IncScript site/bundle/vimtex.vim
endif

" vim-go
if has_key(s:enabled, 'vim-go')
	Plug 'fatih/vim-go'
	IncScript site/bundle/go.vim
endif

if has_key(s:enabled, 'devdocs')
	if !has('nvim') && v:version >= 901
		Plug 'girishji/devdocs.vim'
		IncScript site/bundle/devdocs.vim
	endif
endif

" CoC
if has_key(s:enabled, 'coc')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	IncScript site/bundle/coc.vim
endif

" vim-lsp
if has_key(s:enabled, 'lsp')
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'mattn/vim-lsp-settings'
	Plug 'prabirshrestha/asyncomplete-buffer.vim'
	Plug 'prabirshrestha/asyncomplete-tags.vim'
	Plug 'jsit/asyncomplete-user.vim'
	IncScript site/bundle/lsp.vim
endif

" copilot.vim
if has_key(s:enabled, 'copilot')
	Plug 'github/copilot.vim'
	IncScript site/bundle/copilot.vim
endif

" vimspector
if has_key(s:enabled, 'vimspector')
	Plug 'puremourning/vimspector'
	IncScript site/bundle/vimspector.vim
endif

" NeoDebug
if has_key(s:enabled, 'neodebug')
	Plug 'skywind3000/NeoDebug'
	IncScript site/bundle/neodebug.vim
endif

" echodoc
if has_key(s:enabled, 'echodoc')
	Plug 'Shougo/echodoc.vim'
	set noshowmode
	let g:echodoc#enable_at_startup = 1
endif

" lightline
if has_key(s:enabled, 'lightline')
	Plug 'itchyny/lightline.vim'
	IncScript site/bundle/lightline.vim
endif

" ale
if has_key(s:enabled, 'ale')
	Plug 'w0rp/ale'
	IncScript site/bundle/ale.vim
endif

if has_key(s:enabled, 'matchup')
	Plug 'andymass/vim-matchup'
	IncScript site/bundle/matchup.vim
else
	runtime! macros/matchit.vim
endif

" vimwiki
if has_key(s:enabled, 'vimwiki')
	Plug 'vimwiki/vimwiki'
	IncScript site/bundle/vimwiki.vim
endif

" airline
if has_key(s:enabled, 'airline')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	let g:airline_font = 1
	IncScript site/bundle/airline.vim
endif

if has_key(s:enabled, 'neovim')
	if !has('nvim')
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif
endif

if has_key(s:enabled, 'floaterm')
	Plug 'voldikss/vim-floaterm'
	IncScript site/bundle/floaterm.vim
endif

if has_key(s:enabled, 'vim-doge')
	Plug 'kkoomen/vim-doge'
	IncScript site/bundle/doge.vim
endif

if has_key(s:enabled, 'grammer')
	Plug 'rhysd/vim-grammarous'
	nnoremap <space>rg :GrammarousCheck --lang=en-US --no-move-to-first-error --no-preview<cr>
	nmap <space>rr <Plug>(grammarous-open-info-window)
	nmap <space>rv <Plug>(grammarous-move-to-info-window)
	nmap <space>rs <Plug>(grammarous-reset)
	nmap <space>rx <Plug>(grammarous-close-info-window)
	nmap <space>rm <Plug>(grammarous-remove-error)
	nmap <space>rd <Plug>(grammarous-disable-rule)
	nmap <space>rn <Plug>(grammarous-move-to-next-error)
	nmap <space>rp <Plug>(grammarous-move-to-previous-error)
endif

if has_key(s:enabled, 'neomake')
	Plug 'neomake/neomake'
endif

if has_key(s:enabled, 'vista')
	Plug 'liuchengxu/vista.vim'
endif

if has_key(s:enabled, 'defx')
	if has('nvim')
		Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/defx.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif
	IncScript site/bundle/defx.vim
endif

if has_key(s:enabled, 'editorconfig')
	Plug 'editorconfig/editorconfig-vim'
endif

if has_key(s:enabled, 'neoterm')
	Plug 'kassio/neoterm'
endif

if has_key(s:enabled, 'clap')
	if !has('nvim')
		Plug 'liuchengxu/vim-clap'
		IncScript site/bundle/clap.vim
	endif
endif

if has_key(s:enabled, 'splitjoin')
	Plug 'AndrewRadev/splitjoin.vim'
endif

if has_key(s:enabled, 'neocomplete')
	if !has('patch-8.2.1065')
		Plug 'Shougo/neocomplete.vim'
		let g:neocomplete#enable_at_startup = 1
		let g:neocomplete#sources#syntax#min_keyword_length = 2
		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
		inoremap <expr><C-g><C-g> neocomplete#undo_completion()
		inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
		function! s:my_cr_function()
			return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
		endfunction
	else
		echohl ErrorMsg
		echom 'ERROR: neocomplete is incompatible with vim-8.2.1065+'
		echohl None
	endif
endif

if has_key(s:enabled, 'omni')
	Plug 'vim-scripts/OmniCppComplete', {'for':['cpp']}
	" Plug 'c9s/perlomni.vim', {'for':['perl']}
	Plug 'shawncplus/phpcomplete.vim', {'for': ['php']}
	" Plug 'artur-shaik/vim-javacomplete2'
	Plug 'othree/html5.vim', {'for': ['html']}
	" Plug 'xolox/vim-lua-ftplugin', {'for': ['lua']}
	let g:lua_complete_omni = 0
	let g:lua_check_globals = 0
	let g:lua_check_syntax = 0
	let g:lua_define_completion_mappings = 0
	" autocmd FileType java setlocal omnifunc=javacomplete#Complete
endif

if has_key(s:enabled, 'lsp-lcn')
	Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next' }
	IncScript site/bundle/lcn.vim
endif

if has_key(s:enabled, 'keysound')
	Plug 'skywind3000/vim-keysound'
	let g:keysound_theme = 'default'
	let g:keysound_enable = 1
endif

if has_key(s:enabled, 'icons')
	Plug 'istepura/vim-toolbar-icons-silk'
endif

if has_key(s:enabled, 'tabnine')
	Plug 'codota/tabnine-vim'
	IncScript site/bundle/tabnine.vim
endif

if has_key(s:enabled, 'games')
	Plug 'iqxd/vim-mine-sweeping'
	Plug 'vim-scripts/Mines'
	Plug 'katono/rogue.vim'
endif

if has_key(s:enabled, 'whichkey')
	Plug 'liuchengxu/vim-which-key'
	IncScript site/bundle/which_key.vim
endif

if has_key(s:enabled, 'supertab')
	Plug 'ervandew/supertab'
	IncScript site/bundle/supertab.vim
endif

if has_key(s:enabled, 'blamer')
	Plug 'APZelos/blamer.nvim'
endif

if has_key(s:enabled, 'cursorword')
	Plug 'itchyny/vim-cursorword'
	let g:cursorword_delay = 100
	let g:cursorword = 0
endif

if has_key(s:enabled, 'anyjump')
	Plug 'pechorin/any-jump.vim'
endif

if has_key(s:enabled, 'notify')
	if has('nvim')
		Plug 'rcarriga/nvim-notify'
	endif
endif

if has_key(s:enabled, 'lh-cpp')
	Plug 'LucHermitte/lh-vim-lib'
	Plug 'LucHermitte/lh-style'
	Plug 'LucHermitte/lh-tags'
	Plug 'LucHermitte/lh-dev'
	Plug 'LucHermitte/lh-brackets'
	Plug 'LucHermitte/searchInRuntime'
	Plug 'LucHermitte/mu-template'
	Plug 'tomtom/stakeholders_vim'
	Plug 'LucHermitte/alternate-lite'
	Plug 'LucHermitte/lh-cpp'
endif


"----------------------------------------------------------------------
" packages end
"----------------------------------------------------------------------
if exists('g:bundle_post')
	if type(g:bundle_post) == type('')
		exec g:bundle_post
	elseif type(g:bundle_post) == type([])
		exec join(g:bundle_post, "\n")
	endif
endif

call plug#end()
