"----------------------------------------------------------------------
" 基本设置
"----------------------------------------------------------------------
let mapleader=' '
no ; :
no ' `
no Y y$
nn U <c-r>
nn gV `[V`]
no <silent> <backspace> :noh<cr>
vnoremap < <gv
vnoremap > >gv

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
ino <s-tab> <c-e>

"----------------------------------------------------------------------
" 命令模式的快速移动
"----------------------------------------------------------------------
cno <c-h> <left>
cno <c-j> <down>
cno <c-k> <up>
cno <c-l> <right>
cno <c-a> <home>
cno <c-e> <end>
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


"----------------------------------------------------------------------
" TAB：创建，关闭，上一个，下一个，左移，右移
" 其实还可以用原生的 CTRL+PageUp, CTRL+PageDown 来切换标签
"----------------------------------------------------------------------

no <silent><leader>tc :tabnew<cr>:Startify<cr>
no <silent><leader>tq :tabclose<cr>
no <silent><leader>tn :tabnext<cr>
no <silent><leader>tp :tabprev<cr>
no <silent><leader>to :tabonly<cr>

" 左移 tab
function! Tab_MoveLeft()
	let l:tabnr = tabpagenr() - 2
	if l:tabnr >= 0
		exec 'tabmove '.l:tabnr
	endif
endfunc

" 右移 tab
function! Tab_MoveRight()
	let l:tabnr = tabpagenr() + 1
	if l:tabnr <= tabpagenr('$')
		exec 'tabmove '.l:tabnr
	endif
endfunc

no <silent><leader>tl :call Tab_MoveLeft()<cr>
no <silent><leader>tr :call Tab_MoveRight()<cr>

"----------------------------------------------------------------------
" ALT 键移动增强
"----------------------------------------------------------------------

" ALT+h/l 快速左右按单词移动
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
ino <m-H> <esc><c-w>h
ino <m-L> <esc><c-w>l
ino <m-J> <esc><c-w>j
ino <m-K> <esc><c-w>k

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
elseif has('nvim')
	" neovim 没有 termwinkey 支持，必须把 terminal 切换回 normal 模式
	tno <m-H> <c-\><c-n><c-w>h
	tno <m-L> <c-\><c-n><c-w>l
	tno <m-J> <c-\><c-n><c-w>j
	tno <m-K> <c-\><c-n><c-w>k
	tno <m-q> <c-\><c-n>
endif


"----------------------------------------------------------------------
" 编译运行
"----------------------------------------------------------------------

no <f2> :vs in.txt<cr>
no <f9> :wa<cr>:FloatermSend make %:r<cr>
tno <f9> <c-_>:wa<cr>:FloatermSend make %:r<cr>
no <f5> :wa<cr>:FloatermSend time ./%:r < in.txt<cr>
tno <f5> <c-_>:wa<cr>:FloatermSend time ./%:r < in.txt<cr>

" calculate the md5
ca Hash w !cpp -dD -P -fpreprocessed \| tr -d '[:space:]' \| md5sum \| cut -c-8
