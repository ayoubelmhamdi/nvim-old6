let s:time_total  = 0
let s:time_step   = 0
augroup counter | au!
    au InsertEnter *.dart let s:time_total  = 0
    au InsertEnter *.dart let s:time_step   = localtime()

    au InsertLeave *.dart let s:time_total  = localtime() - s:time_step + readfile("/opt/time-spend1",'',1)[0]

    au InsertLeave *.dart let g:time_total_string = Time_ago(s:time_total)
    au InsertLeave *.dart :call writefile([s:time_total], "/opt/time-spend1", "b")
augroup END

function! Time_ago(age)
  let l:age = a:age
  let l:hours = l:age / 60 / 60 % 24
  let l:minutes = l:age / 60 % 60
  let l:seconds = l:age % 60
  " echo l:seconds

  if l:hours   <  10 | let hours   = "0" .. l:hours   | endif
  if l:minutes <  10 | let minutes = "0" .. l:minutes | endif
  if l:seconds <  10 | let seconds = "0" .. l:seconds | endif

  return l:hours .. ":" .. l:minutes .. ":" .. l:seconds
endfunction


function! WriteCondition(start,end)
  let l:start = a:start
  let l:end   = a:end

  let l:delta = l:end-l:start

  if l:delta <  0  | return 0                     | endif
  if l:delta > 200 | return l:start - l:time_open | endif
  if l:delta < 200 | return l:end   - l:time_open | endif
endfunction
