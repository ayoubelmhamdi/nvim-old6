hi TabLineFill guibg=#282828
hi TabLineSel guifg=#ffffff guibg=#880088
hi TabLine    guifg=#909090  guibg=#282828
hi signcolumn guifg=NONE guibg=NONE
" transparent backgroub
"hi Normal guibg=NONE ctermbg=NONE


" restore cursor position
augroup restore_pos |
  au!
  au BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\"zz"
      \ | endif
augroup end


set guifont=FiraCode\ Nerd\ Font:h14
" TODO to lua for mprove sturtup 
au BufRead,BufNewFile *.conf		setfiletype bash
au BufRead,BufNewFile *.fish		setfiletype fish

" Errors in Red
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
" Warnings in Yellow
hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
" Info and Hints in White
hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White
"autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
