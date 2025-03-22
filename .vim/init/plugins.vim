let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
"----------------------------------------------------------------------
" netrw
"----------------------------------------------------------------------
let g:netrw_liststyle = 1
let g:netrw_winsize = 25
let g:netrw_list_hide = '\.swp\($\|\t\),\.py[co]\($\|\t\),\.o\($\|\t\),\.bak\($\|\t\),\(^\|\s\s\)\zs\.\S\+'
let g:netrw_sort_sequence = '[\/]$,*,\.bak$,\.o$,\.info$,\.swp$,\.obj$'
let g:netrw_preview = 0
"let g:netrw_special_syntax = 1
let g:netrw_sort_options = 'i'

if isdirectory(expand('~/.vim'))
	let g:netrw_home = expand('~/.vim')
endif

"let g:netrw_timefmt = "%Y-%m-%d %H:%M:%S"

"let g:netrw_banner=0 
"let g:netrw_browse_split=4   " open in prior window
"let g:netrw_altv=1           " open splits to the right
"let g:netrw_liststyle=3      " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()

let s:ignore = ['.obj', '.so', '.a', '~', '.tmp', '.egg', '.class', '.jar']
let s:ignore += ['.tar.gz', '.zip', '.7z', '.bz2', '.rar', '.jpg', '.png']
let s:ignore += ['.chm', '.docx', '.xlsx', '.pptx', '.pdf', '.dll', '.pyd']
let s:ignore += ['.xls', '.mobi', '.mp4', '.mp3']

for s:extname in s:ignore
	let s:pattern = escape(s:extname, '.~') . '\($\|\t\),'
	" let g:netrw_list_hide = s:pattern . g:netrw_list_hide
endfor

let s:pattern = '#.\{-\}#\($\|\t\),'
if asclib#platform#has('win') 
	let s:pattern .= '\$.\{-\}\($\|\t\),'
endif

" let g:netrw_list_hide = s:pattern . g:netrw_list_hide

" fixed netrw underline bug in vim 7.3 and below
if v:version < 704
	"set nocursorline
	"au FileType netrw hi CursorLine gui=underline
	"au FileType netrw au BufEnter <buffer> hi CursorLine gui=underline
	"au FileType netrw au BufLeave <buffer> hi clear CursorLine
	autocmd BufEnter * if &buftype == '' | :set nocursorline | endif
endif

let g:ft_man_open_mode = 'vert'


"----------------------------------------------------------------------
" Signify
"----------------------------------------------------------------------
let g:signify_vcs_list = ['git', 'svn']
let g:signify_difftool = 'diff'
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change
let g:signify_as_gitgutter           = 1
let g:signify_sign_show_count        = 0

let g:signify_vcs_cmds = {
			\ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
			\}

function! s:match_highlight(highlight, pattern) abort
	let matches = matchlist(a:highlight, a:pattern)
	if len(matches) == 0
		return 'NONE'
	endif
	return matches[1]
endfunc

function! s:get_bg_colors(group) abort
	redir => highlight
	silent execute 'silent highlight ' . a:group
	redir END
	let link_matches = matchlist(highlight, 'links to \(\S\+\)')
	if len(link_matches) > 0 " follow the link
		return s:get_bg_colors(link_matches[1])
	endif
	let ctermbg = s:match_highlight(highlight, 'ctermbg=\([0-9A-Za-z]\+\)')
	let guibg   = s:match_highlight(highlight, 'guibg=\([#0-9A-Za-z]\+\)')
	return [guibg, ctermbg]
endfunc

function! s:tune_colors() abort
	let [guibg, ctermbg] = s:get_bg_colors('SignColumn')

	execute "hi GitGutterAddDefault    guifg=#009900 guibg=" . guibg . " ctermfg=2 ctermbg=" . ctermbg
	execute "hi GitGutterChangeDefault guifg=#bbbb00 guibg=" . guibg . " ctermfg=3 ctermbg=" . ctermbg
	execute "hi GitGutterDeleteDefault guifg=#ff2222 guibg=" . guibg . " ctermfg=1 ctermbg=" . ctermbg
	hi default link GitGutterChangeDeleteDefault GitGutterChangeDefault

	execute "hi GitGutterAddInvisible    guifg=bg guibg=" . guibg . " ctermfg=" . ctermbg . " ctermbg=" . ctermbg
	execute "hi GitGutterChangeInvisible guifg=bg guibg=" . guibg . " ctermfg=" . ctermbg . " ctermbg=" . ctermbg
	execute "hi GitGutterDeleteInvisible guifg=bg guibg=" . guibg . " ctermfg=" . ctermbg . " ctermbg=" . ctermbg
	hi default link GitGutterChangeDeleteInvisible GitGutterChangeInvisible

	hi default link SignifySignAdd GitGutterAddDefault
	hi default link SignifySignChange GitGutterChangeDefault
	hi default link SignifySignDelete GitGutterDeleteDefault
	hi default link SignifySignChangeDelete GitGutterChangeDeleteDefault
	hi default link SignifySignDeleteFirstLine GitGutterDeleteDefault
endfunc

" autocmd VimEnter * call s:tune_colors()
call s:tune_colors()


"----------------------------------------------------------------------
" Misc
"----------------------------------------------------------------------
let g:startify_disable_at_vimenter = 1
let g:startify_session_dir = '~/.vim/session'
let g:vim_json_conceal = 0


"----------------------------------------------------------------------
" text
"----------------------------------------------------------------------
let g:vim_dict_config = { 
			\ "text" : 'text',
			\ "markdown" : 'text',
			\ "html": 'html,javascript,css,css3',
			\ }


"----------------------------------------------------------------------
" delimitmate
"----------------------------------------------------------------------
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1


"----------------------------------------------------------------------
" gutentags
"----------------------------------------------------------------------
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '~/.globalrc'
let $GTAGSFORCECPP = '1'

let g:gutentags_project_root = ['.root', '.git', '.svn']
let g:gutentags_ctags_tagfile = '.tags'

" let g:gutentags_modules = ['ctags', 'gtags_cscope']
if exists('g:gutentags_cache_dir') == 0
	let g:gutentags_cache_dir = expand('~/.cache/tags')
endif

if !isdirectory(g:gutentags_cache_dir)
	silent call mkdir(g:gutentags_cache_dir, 'p')
endif

let g:gutentags_ctags_extra_args = []
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

let g:gutentags_auto_add_gtags_cscope = 0
let g:gutentags_define_advanced_commands = 1

if asclib#platform#has('win') 
	let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
endif

let g:gutenags_plus_switch = 0


"----------------------------------------------------------------------
" eunuch
"----------------------------------------------------------------------
let g:eunuch_no_maps = 1


"----------------------------------------------------------------------
" styles
"----------------------------------------------------------------------
if has('termguicolors')
	set termguicolors
endif
let g:edge_enable_italic = 1
let g:edge_better_performance = 1


"----------------------------------------------------------------------
" buffer hint
"----------------------------------------------------------------------
let g:bufferhint_CustomHighlight = 1
hi! default link KeyHint Statement
hi! default link AtHint Identifier


"----------------------------------------------------------------------
" vim-markdown & markdown-preview
"----------------------------------------------------------------------
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_frontmatter = 1

let g:mkdp_refresh_slow = 1

"----------------------------------------------------------------------
" python-syntax
"----------------------------------------------------------------------
let g:python_highlight_builtins = 1
let g:python_highlight_builtin_objs = 1
let g:python_highlight_builtin_types = 1
let g:python_highlight_builtin_funcs = 1


"----------------------------------------------------------------------
" asyncrun
"----------------------------------------------------------------------
let g:asyncrun_timer = 200

if asclib#platform#has('win') 
	let g:asyncrun_encs = 'gbk'
endif

let g:asyncrun_open = 6

if executable('rg')
	let g:vimmake_grep_mode = 'rg'
endif


"----------------------------------------------------------------------
" asynctasks
"----------------------------------------------------------------------
let g:asynctasks_term_pos = (asclib#platform#has('win') && has('gui_running'))? 'external' : 'TAB'
let g:asynctasks_confirm = 0
let g:asynctasks_template = s:home . '/tools/conf/template.ini'
let g:asynctasks_environ = get(g:, 'asynctasks_environ', {})
let g:asynctasks_config_name = '.vim/tasks.ini'

let g:asyncrun_show_time = 1
let g:asyncrun_rootmarks = ['.project', '.root', '.git', '.git', '.svn']
let g:asyncrun_rootmarks += ['.hg', '.obsidian']
let g:asclib_path_rootmarks = g:asyncrun_rootmarks
