vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  pattern = {"*.tex", "*.c", "*.lua", "*.h", "*.dart"},
  callback = function ()
      vim.b.auto_save = 1
  end  ,
})

vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  pattern = {"*.dart"},
  callback = function ()
    os.execute('kill -USR1 $(cat /tmp/flutter.pid)')
  end  ,
})
