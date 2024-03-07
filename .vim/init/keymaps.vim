"----------------------------------------------------------------------
" 基本设置
"----------------------------------------------------------------------
let mapleader = " "
let maplocalleader = " "
no ; :
no \ ;
no ' `
no Y y$
no H ^
no M zz
no L g_
no gV `[V`]
no <silent><backspace> :noh<cr>
nnoremap U <c-r>
vnoremap < <gv
vnoremap > >gv

" 关闭鼠标中键粘贴
noremap <MiddleMouse> <LeftMouse>

" open list
nn <leader>xl :lopen<cr>
nn <leader>xq :copen<cr>

" quit all
nnoremap <silent>Q :<c-u>confirm qall<cr>

" replace
nnoremap <leader>y yiw

" fold
nnoremap <m-z> za
nnoremap <m-Z> zA

" text-objects
onoremap il :<c-u>normal! v$o^oh<cr>
vnoremap il $o^oh

" last command
nnoremap <leader>l :<c-p><cr>


"----------------------------------------------------------------------
" INSERT 模式偶尔需要移动的方便些
"----------------------------------------------------------------------
ino <c-h> <left>
ino <c-j> <down>
ino <c-k> <up>
ino <c-l> <right>
ino <c-a> <home>
ino <c-e> <end>
ino <c-d> <del>


"----------------------------------------------------------------------
" 命令模式的快速移动
"----------------------------------------------------------------------
cno <c-h> <left>
cno <c-j> <down>
cno <c-k> <up>
cno <c-l> <right>
cno <c-a> <home>
cno <c-e> <end>
cno <c-f> <c-d>
cno <c-d> <del>


"----------------------------------------------------------------------
" ALT+N 切换 tab
"----------------------------------------------------------------------
no <silent><m-1> :tabn 1<cr>
no <silent><m-2> :tabn 2<cr>
no <silent><m-3> :tabn 3<cr>
no <silent><m-4> :tabn 4<cr>
no <silent><m-5> :tabn 5<cr>
no <silent><m-6> :tabn 6<cr>
no <silent><m-7> :tabn 7<cr>
no <silent><m-8> :tabn 8<cr>
no <silent><m-9> :tabn 9<cr>
no <silent><m-0> :tabn 10<cr>
ino <silent><m-1> <esc>:tabn 1<cr>
ino <silent><m-2> <esc>:tabn 2<cr>
ino <silent><m-3> <esc>:tabn 3<cr>
ino <silent><m-4> <esc>:tabn 4<cr>
ino <silent><m-5> <esc>:tabn 5<cr>
ino <silent><m-6> <esc>:tabn 6<cr>
ino <silent><m-7> <esc>:tabn 7<cr>
ino <silent><m-8> <esc>:tabn 8<cr>
ino <silent><m-9> <esc>:tabn 9<cr>
ino <silent><m-0> <esc>:tabn 10<cr>
noremap <silent><m-up> :tabprev<cr>
noremap <silent><m-down> :tabnext<cr>
inoremap <silent><m-up> <ESC>:tabprev<cr>
inoremap <silent><m-down> <ESC>:tabnext<cr>


"----------------------------------------------------------------------
" TAB：创建，关闭，上一个，下一个，左移，右移
" 其实还可以用原生的 CTRL+PageUp, CTRL+PageDown 来切换标签
"----------------------------------------------------------------------

noremap <silent><leader>tc :tabnew<cr>:Startify<cr>
noremap <silent><leader>tq :tabclose<cr>
noremap <silent><leader>tn :tabnext<cr>
noremap <silent><leader>tp :tabprev<cr>
noremap <silent><leader>to :tabonly<cr>
noremap <silent><leader>ta g<tab>
noremap <silent><leader>th :-tabmove<cr>
noremap <silent><leader>tl :+tabmove<cr>
noremap <silent><m-left> :-tabmove<cr>
noremap <silent><m-right> :+tabmove<cr>
noremap <silent><m-t> :tabnew<cr>
vnoremap <silent><m-t> <ESC>:tabnew<cr>
inoremap <silent><m-t> <ESC>:tabnew<cr>
noremap <silent><m-w> :tabclose<cr>
inoremap <silent><m-w> <ESC>:tabclose<cr>
noremap <silent><m-v> :close<cr>
inoremap <silent><m-v> <ESC>:close<cr>
noremap <m-s> :w<cr>
inoremap <m-s> <esc>:w<cr>


"----------------------------------------------------------------------
" buffer keymap
"----------------------------------------------------------------------
no <silent><leader>bn :bn<cr>
no <silent><leader>bp :bp<cr>
no <silent><leader>bm :bm<cr>
no <silent><leader>bv :vs<cr>
no <silent><leader>bs :sp<cr>
no <silent><leader>bd :bdelete<cr>
no <silent><leader>bl :ls<cr>
no <silent><leader>bb :ls<cr>:b
nnoremap <silent><leader>bc :BufferClose<cr>


"----------------------------------------------------------------------
" window keymaps
"----------------------------------------------------------------------
no <silent><leader>w1 :1wincmd w<cr>
no <silent><leader>w2 :2wincmd w<cr>
no <silent><leader>w3 :3wincmd w<cr>
no <silent><leader>w4 :4wincmd w<cr>
no <silent><leader>w5 :5wincmd w<cr>
no <silent><leader>w6 :6wincmd w<cr>
no <silent><leader>w7 :7wincmd w<cr>
no <silent><leader>w8 :8wincmd w<cr>
no <silent><leader>w9 :9wincmd w<cr>
nnoremap <silent><leader>0 :exe "NERDTree ".fnameescape(expand("%:p:h"))<cr>
nnoremap <silent><leader>g <c-w>p


"----------------------------------------------------------------------
" ALT 键移动增强
"----------------------------------------------------------------------

" ALT+h/l 快速左右按单词移动
noremap <m-h> b
noremap <m-l> w
ino <m-h> <c-left>
ino <m-l> <c-right>

" 命令模式
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

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
	" vim 8.1 支持 termwinkey ，不需要把 terminal 切换成 normal 模式
	" 设置 termwinkey 为 CTRL 加减号（GVIM），有些终端下是 CTRL+?
	" 后面四个键位是搭配 termwinkey 的，如果 termwinkey 更改，也要改
	set termwinkey=<c-_>
	tno <m-H> <c-_>h
	tno <m-L> <c-_>l
	tno <m-J> <c-_>j
	tno <m-K> <c-_>k
	tno <m-q> <c-\><c-n>
	tnoremap <m-1> <c-_>1gt
	tnoremap <m-2> <c-_>2gt
	tnoremap <m-3> <c-_>3gt
	tnoremap <m-4> <c-_>4gt
	tnoremap <m-5> <c-_>5gt
	tnoremap <m-6> <c-_>6gt
	tnoremap <m-7> <c-_>7gt
	tnoremap <m-8> <c-_>8gt
	tnoremap <m-9> <c-_>9gt
	tnoremap <m-0> <c-_>10gt
	if v:version >= 802
		tnoremap <m-left> <c-\><c-n>:-tabmove<cr>
		tnoremap <m-right> <c-\><c-n>:+tabmove<cr>
	endif
elseif has('nvim')
	" neovim 没有 termwinkey 支持，必须把 terminal 切换回 normal 模式
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
" quickerfix
"----------------------------------------------------------------------
if has('autocmd')
	function! s:quickfix_keymap()
		if &buftype != 'quickfix'
			return
		endif
		nnoremap <silent><buffer> P :PreviewClose<cr>
		nnoremap <silent><buffer> q :close<cr>
		setlocal nonumber
	endfunc
endif


"----------------------------------------------------------------------
" GUI/Terminal
"----------------------------------------------------------------------
noremap <silent><M-[> :call Tools_QuickfixCursor(2)<cr>
noremap <silent><M-]> :call Tools_QuickfixCursor(3)<cr>
noremap <silent><M-{> :call Tools_QuickfixCursor(4)<cr>
noremap <silent><M-}> :call Tools_QuickfixCursor(5)<cr>
noremap <silent><M-u> :call Tools_PreviousCursor(6)<cr>
noremap <silent><M-d> :call Tools_PreviousCursor(7)<cr>

inoremap <silent><M-[> <c-\><c-o>:call Tools_QuickfixCursor(2)<cr>
inoremap <silent><M-]> <c-\><c-o>:call Tools_QuickfixCursor(3)<cr>
inoremap <silent><M-{> <c-\><c-o>:call Tools_QuickfixCursor(4)<cr>
inoremap <silent><M-}> <c-\><c-o>:call Tools_QuickfixCursor(5)<cr>
inoremap <silent><M-u> <c-\><c-o>:call Tools_PreviousCursor(6)<cr>
inoremap <silent><M-d> <c-\><c-o>:call Tools_PreviousCursor(7)<cr>


"----------------------------------------------------------------------
" space + f + num: session management
"----------------------------------------------------------------------
set ssop-=options    " do not store global and local values in a session

for s:index in range(5)
	exec 'nnoremap <silent><leader>f'.s:index.'s :mksession! ~/.vim/session.'.s:index.'<cr>'
	exec 'nnoremap <silent><leader>f'.s:index.'l :so ~/.vim/session.'.s:index.'<cr>'
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
if (has('win32') || has('win64')) && (has('nvim') || (!has('gui_running')))
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
	noremap <silent><m-o> :call Open_Browse(2)<cr>
	inoremap <silent><m-o> <ESC>:call Open_Browse(2)<cr>
endif
nnoremap <silent><space>he :call Show_Explore()<cr>


"----------------------------------------------------------------------
" 编译运行
"----------------------------------------------------------------------

" f10打开终端，f9编译c/c++，f5运行文件，f7编译项目，f8运行项目，f6测试项目，f4更新cmake
no <f2> :vs in.txt<cr>
no <f9> :wa \| FloatermSend make %:r<cr>
no <f5> :wa \| FloatermSend %:r < in.txt<cr>

" calculate the md5
ca Hash w !cpp -dD -P -fpreprocessed \| tr -d '[:space:]' \| md5sum \| cut -c-8
