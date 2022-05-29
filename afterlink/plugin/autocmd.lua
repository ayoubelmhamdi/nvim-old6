vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  pattern = {"*.html", "*.js", "*.tex", "*.c", "*.lua", "*.h", "*.dart"},
  callback = function ()
      vim.b.auto_save = 1
  end  ,
})

vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  pattern = {"*.dart"},
  callback = function ()
    os.execute('kill -USR1 $(cat /tmp/flutter.pid >/dev/null 2>&1) >/dev/null 2>&1')
  end  ,
})
