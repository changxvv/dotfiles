"----------------------------------------------------------------------
" internal
"----------------------------------------------------------------------
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
set signcolumn=yes

let g:coc_config_home = expand('~/.vim/tools/conf')

if !isdirectory(g:coc_config_home)
	silent! call mkdir(g:coc_config_home)
endif

let g:coc_global_extensions = [
	\ 'coc-dictionary',
	\ 'coc-emoji',
	\ 'coc-highlight',
	\ 'coc-json',
	\ 'coc-pyright',
	\ 'coc-snippets',
	\ 'coc-syntax',
	\ 'coc-tag',
	\ 'coc-tsserver',
	\ 'coc-word',
	\ 'coc-yank',
	\ 'coc-vimlsp'
	\ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ delimitMate#ShouldJump() ? "<Plug>delimitMateS-Tab" :
      \ "\<Tab>"
inoremap <expr> <c-e> coc#pum#visible() ? coc#pum#cancel() : "\<end>"

inoremap <silent><expr> <c-tab> coc#refresh()

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
xmap <s-tab> <Plug>(coc-snippets-select)

" GoTo code navigation
nmap <silent> gt :call CocActionAsync('jumpDefinition', 'tabe')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent>gj :call CocAction('showIncomingCalls')<Cr>
nnoremap <silent>gk :call CocAction('showOutgoingCalls')<Cr>
nnoremap <silent>gu :call CocAction('showSubTypes')<Cr>
nnoremap <silent>gs :call CocAction('showSuperTypes')<Cr>

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <f2> <Plug>(coc-rename)

" Formatting selected code
vmap <leader>gq  <Plug>(coc-format-selected)

augroup MyCoCEventGroup
	autocmd!
	" Setup formatexpr specified filetype(s)
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
vmap <leader>ac  <Plug>(coc-codeaction-selected)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>af  <Plug>(coc-fix-current)
" Remap keys for applying refactor code actions
vmap <silent> <leader>ar  <Plug>(coc-codeaction-refactor-selected)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <silent> <C-c> <Plug>(coc-cursors-position)
xmap <silent> <C-r> <Plug>(coc-cursors-range)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <leader>cd  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
" Resume latest coc list
nnoremap <silent><nowait> <leader>cp  :<C-u>CocListResume<CR>
" coc yank list
nnoremap <silent><nowait> <leader>cy  :<C-u>CocList -A --normal yank<cr>
