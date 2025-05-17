if exists('b:ftplugin_markdown')
	finish
endif
let b:ftplugin_markdown = 1

setlocal synmaxcol=0  " Text after this column number is not highlighted
setlocal textwidth=0

" make vim can break at any unicode character. However, the English words are also broken into two lines, which is also annoying.
" ref https://github.com/vim/vim/issues/2579#issuecomment-689252035
" Hoping https://github.com/vim/vim/issues/6911 will be fixed in the future
setlocal breakat=
setlocal breakindent

setlocal wrap
setlocal conceallevel=2

" 设置 gq 时判断的列表, 如果是列表的话会使用列表后的第一个字符的作为缩进距离
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:
" o   Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
" 2   When formatting text, use the indent of the second line of a paragraph for the rest of the paragraph, instead of the indent of the first line.
"    This supports paragraphs in which the first line has a different indent than the rest.  Note that 'autoindent' must be set too
" m   Also break at a multibyte character above 255.  This is useful for Asian text where every character is a word on its own.
" B   When joining lines, don't insert a space between two multibyte characters.  Overruled by the 'M' flag.
" 1   Don't break a line after a one-letter word.  It's broken before it instead (if possible).
setlocal formatoptions+=o2mbB1
