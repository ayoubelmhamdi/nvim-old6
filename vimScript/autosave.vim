
let g:auto_save = 0
augroup ft_dart
  au!
  au FileType dart,javascript,html,tex let b:auto_save = 1 
augroup END


" lua vim.api.nvim_command[[autocmd BufWritePre dart,javascript lua vim.lsp.buf.formatting_seq_sync()]]
