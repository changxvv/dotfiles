"======================================================================
"
" textobjs.vim - use it with vim-textobj-user
"
" Requirement:
" https://github.com/kana/vim-textobj-user
"
" Created by skywind on 2024/03/04
" Last Modified: 2024/03/04 15:24:53
"
"======================================================================


"----------------------------------------------------------------------
" IP / mac address
"----------------------------------------------------------------------
call textobj#user#plugin('ipmac', {
  \ '-' : {
  \   'pattern' :
  \      '\%(\%(\%('
  \     .'[[:xdigit:]]\{1,4}\%(:[[:xdigit:]]\{1,4}\)\{5}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{4}\%(:[[:xdigit:]]\{1,4}\)\{1}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{3}\%(:[[:xdigit:]]\{1,4}\)\{1,2}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{2}\%(:[[:xdigit:]]\{1,4}\)\{1,3}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{1}\%(:[[:xdigit:]]\{1,4}\)\{1,4}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{1,5}'
  \     .'\|:\%(:[[:xdigit:]]\{1,4}\)\{1,5}'
  \     .'\|:'
  \     .'\):\%(25[0-5]\|2[0-4]\d\|1\d\{2}\|[1-9]\?\d\)\%(\.\%(25[0-5]\|2[0-4]\d\|1\d\{2}\|[1-9]\?\d\)\)\{3}'
  \     .'\|\%('
  \     .'[[:xdigit:]]\{1,4}\%(:[[:xdigit:]]\{1,4}\)\{7}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{6}\%(:[[:xdigit:]]\{1,4}\)\{1}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{5}\%(:[[:xdigit:]]\{1,4}\)\{1,2}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{4}\%(:[[:xdigit:]]\{1,4}\)\{1,3}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{3}\%(:[[:xdigit:]]\{1,4}\)\{1,4}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{2}\%(:[[:xdigit:]]\{1,4}\)\{1,5}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{1}\%(:[[:xdigit:]]\{1,4}\)\{1,6}'
  \     .'\|\%([[:xdigit:]]\{1,4}:\)\{1,7}:'
  \     .'\|:\%(:[[:xdigit:]]\{1,4}\)\{1,7}'
  \     .'\|::'
  \     .'\)'
  \     .'\)'
  \     .'\|\%(25[0-5]\|2[0-4]\d\|1\d\{2}\|[1-9]\?\d\)\%(\.\%(25[0-5]\|2[0-4]\d\|1\d\{2}\|[1-9]\?\d\)\)\{3}'
  \     .'\|[[:xdigit:]]\{2}\%(:[[:xdigit:]]\{2}\)\{5}'
  \     .'\)',
  \   'select' : ['IP'],
  \ }})

