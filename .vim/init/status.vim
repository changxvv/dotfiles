"----------------------------------------------------------------------
" simple status line
"----------------------------------------------------------------------
let g:status_padding_left = ""
let g:status_padding_right = ""
set statusline=                                 " 清空状态栏
set statusline+=%{''.g:status_padding_left}     " left padding
set statusline+=\ %F                            " 文件名
set statusline+=\ [%1*%M%*%n%R%H]               " buffer 编号和状态
set statusline+=%{''.g:status_padding_right}    " left padding
set statusline+=%=                              " 向右对齐
set statusline+=\ %y                            " 文件类型
" 最右边显示文件编码和行号等信息，并且固定在一个 group 中，优先占位
set statusline+=\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)
