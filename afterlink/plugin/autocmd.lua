vim.cmd[[
	function! SomeCheck()
	   if filereadable("/tmp/flutter.pid")
	       !kill -USR1 $(cat /tmp/flutter.pid)
	   endif
	endfunction
]]

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = {"*.c","*.lua", "*.h"},
  callback = function ()
      vim.b.auto_save = 1
  end  ,  -- Or myvimfun
})

vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  pattern = {"*.dart"},
  callback = function ()
      vim.b.auto_save = 1
  end  ,  -- Or myvimfun
})
