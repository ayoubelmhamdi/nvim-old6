nnoremap <space>s :s#^\(.*\)#\\section{\1}<cr>
nnoremap <space>ss :s#^\(.*\)#\\subsection{\1}<cr>
nnoremap <space>sss :s#^\(.*\)#\\subsubsection{\1}<cr>
nnoremap <space>i :s#^\( *\)\(.*\)#\\begin{itemize}\r  \\item \2\r\\end{itemize}<cr>
nnoremap <space>ii :s#^\( *\)\(.*\)#  \\item \2#<cr>


vnoremap <space>i  d:<C-r>"<C-b>norm O\begin{itemize}<C-o>o<C-e><C-o>o\end{itemize}<cr>
vnoremap <space>q  d:<C-r>"<C-b>norm i$<C-e>$<cr>
vnoremap <space>tb d:<C-r>"<C-b>norm i\textbf{<C-e>}<cr>
