
augroup ft_reload
  au!
  au InsertLeave,TextChanged *.dart :silent call SomeCheck() 
augroup END

function! SomeCheck()
   if filereadable("/tmp/flutter.pid")
       !kill -USR1 $(cat /tmp/flutter.pid)
   endif
endfunction
