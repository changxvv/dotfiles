"----------------------------------------------------------------------
" 基本设置
"----------------------------------------------------------------------
let mapleader = " "
let maplocalleader = " "
no ; :
no \ ;
no ' `
no H ^
no M zz
no L g_
no gV `[V`]
no <silent><backspace> :noh<cr>:redraw!<cr>
nnoremap U <c-r>
xnoremap < <gv
xnoremap > >gv
nnoremap Y y$
xnoremap p "_dP
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'


"----------------------------------------------------------------------
" text-objects
"----------------------------------------------------------------------
vnoremap ik 0o$h
onoremap ik :normal vik<cr>
vnoremap ak 0o$
onoremap ak :normal vak<cr>


"----------------------------------------------------------------------
" INSERT 模式偶尔需要移动的方便些
"----------------------------------------------------------------------
ino <c-h> <left>
ino <c-j> <down>
ino <c-k> <up>
ino <c-l> <right>
ino <c-a> <home>
ino <c-d> <del>
ino <c-u> <c-g>u<c-U>


"----------------------------------------------------------------------
" 命令模式的快速移动
"----------------------------------------------------------------------
cno <c-h> <left>
cno <c-j> <down>
cno <c-k> <up>
cno <c-l> <right>
cno <c-a> <home>
cno <c-e> <end>
cno <c-o> <c-d>
cno <c-d> <del>


"----------------------------------------------------------------------
" TAB：切换，创建，关闭，上一个，下一个，左移，右移
" 其实还可以用原生的 CTRL+PageUp, CTRL+PageDown 来切换标签
"----------------------------------------------------------------------
for i in range(10)
	let x = (i == 0)? 10 : i
	exec "noremap <silent><M-".i."> ".x."gt"
	exec "inoremap <silent><M-".i."> <ESC>".x."gt"
endfor
noremap <silent><m-up> :tabprev<cr>
inoremap <silent><m-up> <ESC>:tabprev<cr>
noremap <silent><m-down> :tabnext<cr>
inoremap <silent><m-down> <ESC>:tabnext<cr>
noremap <silent><tab>, :-tabmove<cr>
noremap <silent><tab>. :+tabmove<cr>
noremap <silent><m-t> :tabnew<cr>:Startify<cr>
inoremap <silent><m-t> <ESC>:tabnew<cr>:Startify<cr>
noremap <silent><m-w> :tabclose<cr>
inoremap <silent><m-w> <ESC>:tabclose<cr>
noremap <silent><m-v> :close<cr>
inoremap <silent><m-v> <ESC>:close<cr>
noremap <silent><m-o> :tabonly<cr>
noremap <silent><m-a> g<tab>


"----------------------------------------------------------------------
" buffer keymap
"----------------------------------------------------------------------
no <silent><leader>bd :bdelete<cr>
no <silent><leader>bl :ls<cr>
no <silent><leader>bb :ls<cr>:b
nnoremap <silent><leader>bc :BufferClose<cr>
nnoremap <silent><leader>cw :CdToFileDir<cr>
nnoremap <silent><leader>cr :CdToProjectRoot<cr>
nnoremap + :call bufferhint#Popup()<CR>


"----------------------------------------------------------------------
" window keymaps
"----------------------------------------------------------------------
nnoremap <silent><leader>= :resize +3<cr>
nnoremap <silent><leader>- :resize -3<cr>
nnoremap <silent><leader>, :vertical resize -3<cr>
nnoremap <silent><leader>. :vertical resize +3<cr>

nnoremap <silent><leader>vl :VinegarOpen leftabove vs<cr>
nnoremap <silent><leader>vs :VinegarOpen vs<cr>
nnoremap <silent><leader>vr :VinegarOpen belowright sp<cr>
nnoremap <silent><leader>vt :VinegarOpen tabedit<cr>
nnoremap <silent><leader>g <c-w>p


"----------------------------------------------------------------------
" ALT 键移动增强
"----------------------------------------------------------------------

" ALT+h/l 快速左右按单词移动
noremap <m-h> b
noremap <m-l> w
ino <m-h> <c-left>
ino <m-l> <c-right>
cno <m-h> <c-left>
cno <m-l> <c-right>

" ALT+j/k 逻辑跳转下一行/上一行（按 wrap 逻辑换行进行跳转） 
no <m-j> gj
no <m-k> gk
ino <m-j> <c-\><c-o>gj
ino <m-k> <c-\><c-o>gk

" ALT+d 删除到行末
ino <m-d> <c-\><c-o>d$


"----------------------------------------------------------------------
" 窗口切换：ALT+SHIFT+hjkl
" 传统的 CTRL+hjkl 移动窗口不适用于 vim 8.1 的终端模式，CTRL+hjkl 在
" bash/zsh 及带文本界面的程序中都是重要键位需要保留，不能 tnoremap 的
"----------------------------------------------------------------------
no <m-H> <c-w>h
no <m-L> <c-w>l
no <m-J> <c-w>j
no <m-K> <c-w>k
no <m-W> <c-w>w
no <m-V> <c-w>v
no <m-S> <c-w>s
no <m-C> <c-w>c
no <m-O> <c-w>o
no <m-P> <c-w>p
no <m-+> <c-w>+
no <m--> <c-w>-
no <m-,> <c-w>< 
no <m-.> <c-w>>
no <m-=> <c-w>=
ino <m-H> <esc><c-w>h
ino <m-L> <esc><c-w>l
ino <m-J> <esc><c-w>j
ino <m-K> <esc><c-w>k
ino <m-W> <esc><c-w>w
ino <m-V> <esc><c-w>v
ino <m-S> <esc><c-w>s
ino <m-C> <esc><c-w>c
ino <m-O> <esc><c-w>o
ino <m-P> <esc><c-w>p
ino <m-+> <esc><c-w>+
ino <m--> <esc><c-w>-
ino <m-,> <esc><c-w>< 
ino <m-.> <esc><c-w>>
ino <m-=> <esc><c-w>=

if has('terminal') || has('nvim')
	tno <m-H> <c-\><c-n><c-w>h
	tno <m-L> <c-\><c-n><c-w>l
	tno <m-J> <c-\><c-n><c-w>j
	tno <m-K> <c-\><c-n><c-w>k
	tno <m-q> <c-\><c-n>
	tnoremap <m-1> <c-\><c-n>1gt
	tnoremap <m-2> <c-\><c-n>2gt
	tnoremap <m-3> <c-\><c-n>3gt
	tnoremap <m-4> <c-\><c-n>4gt
	tnoremap <m-5> <c-\><c-n>5gt
	tnoremap <m-6> <c-\><c-n>6gt
	tnoremap <m-7> <c-\><c-n>7gt
	tnoremap <m-8> <c-\><c-n>8gt
	tnoremap <m-9> <c-\><c-n>9gt
	tnoremap <m-0> <c-\><c-n>10gt
endif


"----------------------------------------------------------------------
" unimpaired
"----------------------------------------------------------------------
nnoremap <silent>[w :tabprevious<cr>
nnoremap <silent>]w :tabnext<cr>
nnoremap <silent>[W :tabfirst<cr>
nnoremap <silent>]W :tablast<cr>


"----------------------------------------------------------------------
" space + f + num: session management
"----------------------------------------------------------------------
set ssop-=options    " do not store global and local values in a session
set ssop-=blank

for s:index in range(5)
	exec 'nnoremap <silent><leader>f'.s:index.'s :mksession! ~/.vim/session/session.'.s:index.'<cr>'
	exec 'nnoremap <silent><leader>f'.s:index.'l :so ~/.vim/session/session.'.s:index.'<cr>'
endfor


"----------------------------------------------------------------------
" visual mode
"----------------------------------------------------------------------
vnoremap <leader>gp :!python<cr>
vmap <leader>gs y/<C-R>=escape(@", '\\/.*$^~[]')<CR>
vmap <leader>gr y:%s/<C-R>=escape(@", '\\/.*$^~[]')<CR>//gc<Left><Left><Left>


"----------------------------------------------------------------------
" neovim system clipboard
"----------------------------------------------------------------------
if has('nvim') || (!has('gui_running'))
	nnoremap <s-insert> "*P
	vnoremap <s-insert> "-d"*P
	inoremap <s-insert> <c-r><c-o>*
	vnoremap <c-insert> "*y
	cnoremap <s-insert> <c-r>*
endif


"----------------------------------------------------------------------
" Transferring blocks of text between vim sessions
" http://www.drchip.org/astronaut/vim/index.html#Maps
"----------------------------------------------------------------------
nmap <Leader>xr   :r $HOME/.vim/xfer<CR>
nmap <Leader>xw   :'a,.w! $HOME/.vim/xfer<CR>
vmap <Leader>xw   :w! $HOME/.vim/xfer<CR>
nmap <Leader>xa   :'a,.w>> $HOME/.vim/xfer<CR>
vmap <Leader>xa   :w>> $HOME/.vim/xfer<CR>
nmap <Leader>xS   :so $HOME/.vim/xfer<CR>
nmap <Leader>xy   :'a,.y *<CR>
vmap <Leader>xy   :y *<CR>


"----------------------------------------------------------------------
" GUI hotkeys
"----------------------------------------------------------------------
if has('gui_running') || (has('nvim') && (has('win32') || has('win64')))
	noremap <silent><m-b> :call Open_Browse(2)<cr>
	inoremap <silent><m-b> <ESC>:call Open_Browse(2)<cr>
	noremap <S-cr> o<ESC>
	noremap <c-cr> O<esc>
endif
nnoremap <silent><leader>he :call Show_Explore()<cr>
nnoremap <silent><leader>hf <c-w>gf


"----------------------------------------------------------------------
" tasks
"----------------------------------------------------------------------
noremap <silent><s-f12> :AsyncTaskEdit<cr>
inoremap <silent><s-f12> <ESC>:AsyncTaskEdit<cr>
noremap <silent><f12> :TaskFinder<cr>
inoremap <silent><f12> <ESC>:TaskFinder<cr>
noremap <silent><c-f12> :AsyncTaskEnviron profile debug release static<cr>
inoremap <silent><c-f12> <ESC>:AsyncTaskEnviron profile debug release static<cr>

noremap <silent><F5> :AsyncTask file-run<cr>
noremap <silent><F6> :AsyncTask make<cr>
noremap <silent><F7> :AsyncTask emake<cr>
noremap <silent><F8> :AsyncTask emake-exe<cr>
noremap <silent><F9> :AsyncTask file-build<cr>
noremap <silent><F10> :call asyncrun#quickfix_toggle(6)<cr>
noremap <silent><F11> :AsyncTask file-debug<cr>
noremap <silent><s-f5> :AsyncTask project-run<cr>
noremap <silent><s-f6> :AsyncTask project-test<cr>
noremap <silent><s-f7> :AsyncTask project-init<cr>
noremap <silent><s-f8> :AsyncTask project-install<cr>
noremap <silent><s-f9> :AsyncTask project-build<cr>
noremap <silent><s-f11> :AsyncTask project-debug<cr>

inoremap <silent><F5> <ESC>:AsyncTask file-run<cr>
inoremap <silent><F6> <ESC>:AsyncTask make<cr>
inoremap <silent><F7> <ESC>:AsyncTask emake<cr>
inoremap <silent><F8> <ESC>:AsyncTask emake-exe<cr>
inoremap <silent><F9> <ESC>:AsyncTask file-build<cr>
inoremap <silent><F10> <ESC>:call asyncrun#quickfix_toggle(6)<cr>
inoremap <silent><s-f5> <ESC>:AsyncTask project-run<cr>
inoremap <silent><s-f6> <ESC>:AsyncTask project-test<cr>
inoremap <silent><s-f7> <ESC>:AsyncTask project-init<cr>
inoremap <silent><s-f8> <ESC>:AsyncTask project-install<cr>
inoremap <silent><s-f9> <ESC>:AsyncTask project-build<cr>


"----------------------------------------------------------------------
" misc
"----------------------------------------------------------------------
cnoremap <c-t> <C-R>=expand("%:p:h")<cr>

" open list
nn <leader>xl :lopen<cr>
nn <leader>xq :copen<cr>

" quit all
nnoremap <silent>Q :<c-u>confirm qall<cr>

" fold
nnoremap <m-z> za
nnoremap <m-Z> zA

" last command
nnoremap <leader>cl :<c-p><cr>
