" LSP
nnoremap <Space>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <Space>rn  <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <Space>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <Space>ff   <cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>
nnoremap <space>K   <Cmd>lua vim.lsp.buf.hover()<CR>


nnoremap gD         <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gd         <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr         <cmd>lua vim.lsp.buf.references()<CR>
nnoremap [d         <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]d         <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap gi         <cmd>lua vim.lsp.buf.implementation()<CR>

nnoremap <space>kk      <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <space>wa  <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <space>wr  <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <space>wl  <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <space>D   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <space>le   <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

"nnoremap <silent> <space>ll <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <Space>lq <cmd>QFToggle!<CR>

" :remove-me:
nnoremap <Space>r :TexlabBuild<CR>
nnoremap <Space>z :!zathura %:r.pdf & disown<CR><CR>

" make
"nnoremap ll :vs<cr>:term ./suckless/statusbar<cr><cr>touch 

" Telescope:
autocmd FileType dart nnoremap <Space>o :Telescopefindfiledart<cr>
autocmd TermOpen * setlocal nonu nornu | startinsert

nnoremap     <M-m>    <cmd>lua require('nvPlugins.mytelescope').gl()<cr>
nnoremap <Space>o     :Telescopefy<cr>
nnoremap <Space>fg    <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <Space>f     <cmd>lua require('telescope.builtin').find_files({ find_command = { 'fd','--type','file'}})  <cr>
nnoremap <Space>fb    <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <Space>fh    <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <Space>fs    :Telescope current_buffer_fuzzy_find<cr>


nnoremap <Space>fd    :lua require('tsp.cwd-tsp').search_dotfiles()<cr> 
nnoremap <Space>fn    :lua require('tsp.cwd-tsp').search_nvim()<cr> 
nnoremap <Space>fw    :lua require('tsp.cwd-tsp').search_wiki()<cr> 
nnoremap <Space>1    :lua require('tsp.cwd-tsp').search_proj("sl")<cr> 
nnoremap <Space>2    :lua require('tsp.cwd-tsp').search_proj("slstatus")<cr> 

" Hop
" nnoremap <Space><Space> :HopChar2<cr>

" Train
nnoremap <Space>tl :TrainUpDown<cr>
nnoremap <Space>tw :TrainWord<cr>
nnoremap <Space>t  :TrainTextObj<cr>

nnoremap <Esc>      :set nohlsearch!<cr>
nnoremap <Space>ee  :Lexplore<cr>
nnoremap <Tab>      :tabNext<cr>
nnoremap <S-Tab>    :bn<cr>

cnoremap <C-A> <Home>

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z



" FLUTTER
nnoremap <silent> <Space>fp :FlutterPubGet<cr>
" nnoremap <silent> <Space>fr :FlutterRun<cr>
" nnoremap <silent> <Space>ft :FlutterRestart<cr>
" nnoremap <silent> <Space>fq :FlutterQuit<cr>

nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

nnoremap <C-up> :resize +2<cr>
nnoremap <C-down> :resize -2<cr>
nnoremap <C-left> :vertical resize -2<cr>
nnoremap <C-right> :vertical resize +2<cr>



"Basic file system commands
nnoremap <A-o> :!touch<Space>
nnoremap <A-e> :!crf<Space>
nnoremap <A-d> :!mkdir<Space>
nnoremap <A-m> :!mv<Space>%<Space>

" fix p y
nnoremap gn :tabnew<CR>
nnoremap s <Nop>
nnoremap Y y$
nnoremap V V$h
nnoremap <C-q> :noautocmd q<cr>
nnoremap <C-s> :wq<cr>
nnoremap <Space>w :w<cr>
inoremap <C-space><C-space> <esc>


" Alias replace all to
nnoremap <M-s> :s#\<<C-r>=expand("<cword>")<CR>\>#<C-r>=expand("<cword>")<CR> 
vnoremap <C-r> "hy:%s/<C-r>h/
 
" Prevent x from overriding what's in the clipboard.
" use this tow symbole "_ after motion, 
nnoremap x "_x
snoremap x "_x
vnoremap x "_x
snoremap X "_X
nnoremap X "_X
vnoremap X "_X

nnoremap c "_c
snoremap c "_c
vnoremap c "_c
snoremap C "_C
nnoremap C "_C
vnoremap C "_C



" Prevent selecting and and from overwriting what you originally copied.
" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy
vnoremap p pgvy


" Keep cursor at the bottom of the visual selection after you yank it.
" vmap y ygv<Esc>

" TTT: changr indent original tab to
nnoremap > v>
nnoremap < v<
vnoremap > >gv
vnoremap < <gv

inoremap <CR> <C-]><C-G>u<CR>
inoremap <M-a> <Right>
inoremap <M-i> <Left>

" Make sure all types of requirements.txt files get syntax highlighting.
autocmd BufNewFile,BufRead requirements*.txt set syntax=python



" Move : 
nnoremap <silent> <A-j> :MoveLine(1)<CR>
nnoremap <silent> <A-k> :MoveLine(-1)<CR>

vnoremap <silent> <A-j> :MoveBlock(1)<CR>
vnoremap <silent> <A-k> :MoveBlock(-1)<CR>

" togle
nnoremap <F5> :silent setlocal spell! spelllang=en,fr<cr>
inoremap <F5> <C-o>:silent setlocal spell! spelllang=en,fr<cr>

nnoremap <F6> :setlocal nu!<cr>
inoremap <F6> <C-o>:setlocal nu!<cr>

nnoremap <F7> :Lexplore<cr>
inoremap <F7> <C-o>:Lexplore<cr>

nnoremap <RightMouse> :silent Evaluate<CR>
" nnoremap <LeftMouse> :silent Evaluate<cr>
nnoremap <Space>n :cNext<Cr>
nnoremap <Space>b :Break<Cr>

" Command 
command! Telescopefindfiledart lua require("telescope.builtin").find_files({find_command = {"fd","--type","f","-E","*.lock","-E","ios","-E","android","-E","test","-E","build","-E","web","-E","linux","-E","*.png","-E","*.jpg","-E","*.md"}})
command! Telescopefy Telescope frecency default_text=:CWD: 
command! Reloader lua require('telescope').reloader()

command! Psync PackerSync
command! Pinstall PackerInstall
command! Pclean PackerClean

command! W w
command! Q q
command! WQ wq
command! Wq wq
command! MyGdb let g:termdebug_wide = 10 | packadd termdebug | Termdebug

" audocmd
autocmd BufEnter *.tex setlocal spell spelllang=fr
autocmd BufEnter *.txt setlocal spell spelllang=en
autocmd BufEnter test-ocr.txt setlocal spell spelllang=fr
au BufEnter *.xsh set syntax=python

