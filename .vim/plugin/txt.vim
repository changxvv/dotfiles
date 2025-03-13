" Vim universal .txt syntax file
" Language:     txt 1.2
" Maintainer:   Tomasz Kalkosiński <spoonman@op.pl>
" Last change:  3 Jan 2007
"
" This is an universal syntax script for all text documents, logs, changelogs, readmes
" and all other strange and undetected filetypes.
" The goal is to keep it very simple. It colors numbers, operators, signs,
" cites, brackets, delimiters, comments, TODOs, errors, debug, changelog tags
" and basic smileys ;]
"
" Changelog:
" 1.2 (03-01-2007)
"                       Add: Changelog tags: add, chg, fix, rem, del linked with Keyword
"                       Add: note to txtTodo group
"
" 1.1 (01-07-2006)	Add: International cites
" 			Chg: txtString color to Normal
"	 		Chg: Simplified number coloring working better now
"
" 1.0 (28-04-2006)	Initial upload
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn cluster txtAlwaysContains add=txtTodo,txtError

syn cluster txtContains add=txtNumber,txtOperator,txtLink

syn match txtOperator "[~\-_+*<>\[\]{}=|#@$%&\\/:&\^\.,!?]"

" Common strings
syn match txtString "[[:alpha:]]" contains=txtOperator
" Wide characters and non-ascii characters
syn match nonalphabet   "[\u0021-\u002F]"
syn match nonalphabet   "[\u003A-\u0040]"
syn match nonalphabet   "[\u005B-\u0060]"
syn match nonalphabet   "[\u007B-\u007E]"
syn match nonalphabet   "[^\u0000-\u007F]"

" Numbers
" integer number
syn match txtNumber     "\<\d\+\>"
" floating point number, with dot, optional exponent
syn match txtNumber     "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
syn match txtNumber     "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
syn match txtNumber     "\<\d\+[eE][-+]\=\d\+\>"

" Cites
syn region txtCite      matchgroup=txtOperator  start="\""      end="\""        contains=@txtContains,@txtAlwaysContains

" utf8 international cites:
" ‚ ’   U+201A (8218), U+2019 (8217)    Polish single quotation
" „ ”   U+201E (8222), U+201d (8221)    Polish double quotation
" « »   U+00AB (171),  U+00BB (187)     French quotes
" ‘ ’   U+2018 (8216), U+2019 (8217)    British quotes
" „ “   U+201E (8222), U+2019 (8217)    German quotes
" ‹ ›   U+2039 (8249), U+203A (8250)    French quotes
syn region txtCite      matchgroup=txtOperator  start="[‚„«‘„‹]"        end="[’”»’“›]"  contains=@txtContains,@txtAlwaysContains

syn region txtCite      matchgroup=txtOperator  start="\(\s\|^\)\@<='"  end="'"         contains=@txtContains,@txtAlwaysContains

" Comments
syn region txtComment   start="("       end=")"         contains=@txtContains,txtCite,@txtAlwaysContains
syn region txtComments  matchgroup=txtComments start="\/\/"     end="$"         contains=@txtAlwaysContains     oneline
syn region txtComments  start="\/\*"    end="\*\/"      contains=@txtAlwaysContains

syn region txtDelims    matchgroup=txtOperator start="<"        end=">"         contains=@txtContains,@txtAlwaysContains oneline
syn region txtDelims    matchgroup=txtOperator start="{"        end="}"         contains=@txtContains,@txtAlwaysContains oneline
syn region txtDelims    matchgroup=txtOperator start="\["       end="\]"                contains=@txtContains,@txtAlwaysContains oneline 

syn match txtLink       /\(https\?\|ftps\?\|git\|ssh\):\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/   contains=txtOperator

" Basic smileys
syn match txtSmile      "[:;=8][\-]\?\([(\/\\)\[\]]\+\|[OoPpDdFf]\+\)"

" Changelog tags: add, chg, rem, fix
syn match txtChangelogs         "\<add\>\s*:" contains=txtOperator
syn match txtChangelogs         "\<chg\>\s*:" contains=txtOperator
syn match txtChangelogs         "\<rem\>\s*:" contains=txtOperator
syn match txtChangelogs         "\<del\>\s*:" contains=txtOperator
syn match txtChangelogs         "\<fix\>\s*:" contains=txtOperator

syn keyword txtTodo todo fixme xxx note

syn keyword txtError error bug

syn keyword txtDebug debug

syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
  if version < 508
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink nonalphabet            Conditional
  HiLink txtNumber              Number
  HiLink txtString              Normal
  HiLink txtOperator            Operator
  HiLink txtCite                String
  HiLink txtComments            Comment
  HiLink txtComment             Comment
  HiLink txtDelims              Delimiter
  HiLink txtLink                Special
  HiLink txtSmile               PreProc
  HiLink txtError               Error
  HiLink txtTodo                Todo
  HiLink txtDebug               Debug
  HiLink txtChangelogs          Keyword

  delcommand HiLink

let b:current_syntax = "txt"
" vim: ts=8
