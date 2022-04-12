let s:cpo_save=&cpo
set cpo&vim
cnoremap <silent> <C-Space> <Cmd>call v:lua.cmp.utils.keymap.set_map(23)
inoremap <silent> <C-Space> <Cmd>call v:lua.cmp.utils.keymap.set_map(22)
cnoremap <silent> <S-Tab> <Cmd>call v:lua.cmp.utils.keymap.set_map(17)
inoremap <silent> <S-Tab> <Cmd>call v:lua.cmp.utils.keymap.set_map(16)
cnoremap <silent> <Down> <Cmd>call v:lua.cmp.utils.keymap.set_map(9)
inoremap <silent> <Down> <Cmd>call v:lua.cmp.utils.keymap.set_map(8)
cnoremap <silent> <Up> <Cmd>call v:lua.cmp.utils.keymap.set_map(5)
inoremap <silent> <Up> <Cmd>call v:lua.cmp.utils.keymap.set_map(4)
cnoremap <silent> <Plug>(TelescopeFuzzyCommandSearch) e "lua require('telescope.builtin').command_history { default_text = [=[" . escape(getcmdline(), '"') . "]=] }"
noremap! <silent> <Plug>luasnip-expand-repeat <Cmd>lua require'luasnip'.expand_repeat()
noremap! <silent> <Plug>luasnip-delete-check <Cmd>lua require'luasnip'.unlink_current_if_deleted()
inoremap <silent> <Plug>luasnip-jump-prev <Cmd>lua require'luasnip'.jump(-1)
inoremap <silent> <Plug>luasnip-jump-next <Cmd>lua require'luasnip'.jump(1)
inoremap <silent> <Plug>luasnip-prev-choice <Cmd>lua require'luasnip'.change_choice(-1)
inoremap <silent> <Plug>luasnip-next-choice <Cmd>lua require'luasnip'.change_choice(1)
inoremap <silent> <Plug>luasnip-expand-snippet <Cmd>lua require'luasnip'.expand()
inoremap <silent> <Plug>luasnip-expand-or-jump <Cmd>lua require'luasnip'.expand_or_jump()
inoremap <M-a> a
inoremap <C-Space><C-Space> 
inoremap <C-Space><C-,> <Right>,oo<Left><Left>
inoremap <C-Space>,  ,<Left>
inoremap <C-Space>b backgroundColor: Colors.
inoremap <C-Space>c color: Colors.
inoremap <C-Space>/ O	
nnoremap  
snoremap <silent> 	 <Cmd>call v:lua.cmp.utils.keymap.set_map(3)
nnoremap 	 :bn
nnoremap <NL> <NL>
nnoremap  
nnoremap  
nnoremap  :noautocmd q
vnoremap  "hy:%s/h/
nnoremap  :wq
nnoremap  :set nohlsearch!
nnoremap  ? :Cheatsheet
nnoremap  w :w
nnoremap <silent>  fp :FlutterPubGet
nnoremap <silent>  q :call Quitwindows()
nnoremap  ee :Lexplore
nnoremap  t :TrainTextObj
nnoremap  tw :TrainWord
nnoremap  tl :TrainUpDown
nnoremap  2 :lua require('tsp.cwd-tsp').search_proj("slstatus") 
nnoremap  1 :lua require('tsp.cwd-tsp').search_proj("sl") 
nnoremap  fw :lua require('tsp.cwd-tsp').search_wiki() 
nnoremap  fn :lua require('tsp.cwd-tsp').search_nvim() 
nnoremap  fd :lua require('tsp.cwd-tsp').search_dotfiles() 
nnoremap  fs :Telescope current_buffer_fuzzy_find
nnoremap  fh <Cmd>lua require('telescope.builtin').help_tags()
nnoremap  fb <Cmd>lua require('telescope.builtin').buffers()
nnoremap  f <Cmd>lua require('telescope.builtin').find_files({ find_command = { 'fd','--type','file'}})  
nnoremap  fg <Cmd>lua require('telescope.builtin').live_grep()
nnoremap  o :Telescopefy
nnoremap  z :!zathura %:r.pdf & disown
nnoremap  r :TexlabBuild
nnoremap <silent>  lq <Cmd>QFToggle!
nnoremap  le <Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()
nnoremap  D <Cmd>lua vim.lsp.buf.type_definition()
nnoremap  wl <Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
nnoremap  wr <Cmd>lua vim.lsp.buf.remove_workspace_folder()
nnoremap  wa <Cmd>lua vim.lsp.buf.add_workspace_folder()
nnoremap  kk <Cmd>lua vim.lsp.buf.signature_help()
nnoremap  K <Cmd>lua vim.lsp.buf.hover()
nnoremap  ff <Cmd>lua vim.lsp.buf.formatting_seq_sync()
nnoremap  rn <Cmd>lua vim.lsp.buf.rename()
nnoremap  ca <Cmd>lua vim.lsp.buf.code_action()
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
vnoremap < <gv
nnoremap < v<
vnoremap > >gv
nnoremap > v>
nnoremap C "_C
vnoremap C "_C
nnoremap J mzJ`z
nnoremap N Nzzzv
nnoremap V V$h
nnoremap X "_X
vnoremap X "_X
nnoremap Y y$
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
nnoremap [d <Cmd>lua vim.lsp.diagnostic.goto_prev()
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
nnoremap ]d <Cmd>lua vim.lsp.diagnostic.goto_next()
xmap a% <Plug>(MatchitVisualTextObject)
vnoremap c "_c
nnoremap c "_c
nmap gcu <Plug>Commentary<Plug>Commentary
nmap gcc <Plug>CommentaryLine
omap gc <Plug>Commentary
nmap gc <Plug>Commentary
xmap gc <Plug>Commentary
xmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
nnoremap gn :tabnew
nnoremap gi <Cmd>lua vim.lsp.buf.implementation()
nnoremap gr <Cmd>lua vim.lsp.buf.references()
nnoremap gd <Cmd>lua vim.lsp.buf.definition()
nnoremap gD <Cmd>lua vim.lsp.buf.declaration()
nnoremap n nzzzv
vnoremap p pgvy
nnoremap s <Nop>
vnoremap x "_x
nnoremap x "_x
xnoremap <silent> y y:call ClipboardYank()
snoremap <silent> y y:call ClipboardYank()
snoremap <silent> <S-Tab> <Cmd>call v:lua.cmp.utils.keymap.set_map(18)
tmap <Plug>(cmp.utils.keymap.normalize) <C-Space>
nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"
nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_directory(vim.fn.expand("%:p"))
snoremap <silent> <Plug>luasnip-jump-prev <Cmd>lua require'luasnip'.jump(-1)
snoremap <silent> <Plug>luasnip-jump-next <Cmd>lua require'luasnip'.jump(1)
snoremap <silent> <Plug>luasnip-prev-choice <Cmd>lua require'luasnip'.change_choice(-1)
snoremap <silent> <Plug>luasnip-next-choice <Cmd>lua require'luasnip'.change_choice(1)
snoremap <silent> <Plug>luasnip-expand-snippet <Cmd>lua require'luasnip'.expand()
snoremap <silent> <Plug>luasnip-expand-or-jump <Cmd>lua require'luasnip'.expand_or_jump()
noremap <silent> <Plug>luasnip-expand-repeat <Cmd>lua require'luasnip'.expand_repeat()
noremap <silent> <Plug>luasnip-delete-check <Cmd>lua require'luasnip'.unlink_current_if_deleted()
xnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v'):if col("''") != col("$") | exe ":normal! m'" | endifgv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
vnoremap <silent> <M-k> :MoveBlock(-1)
vnoremap <silent> <M-j> :MoveBlock(1)
nnoremap <silent> <M-k> :MoveLine(-1)
nnoremap <silent> <M-j> :MoveLine(1)
nnoremap <M-s> :s#\<=expand("<cword>")\>#=expand("<cword>") 
nnoremap <C-Right> :vertical resize +2
nnoremap <C-Left> :vertical resize -2
nnoremap <C-Down> :resize -2
nnoremap <C-Up> :resize +2
nnoremap <S-Tab> :bp
nnoremap <M-m> <Cmd>lua require('nvPlugins.mytelescope').gl()
cnoremap  <Home>
cnoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(7)
inoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(6)
cnoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(11)
inoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(10)
cnoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(20)
inoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(19)
cnoremap <silent> 	 <Cmd>call v:lua.cmp.utils.keymap.set_map(2)
inoremap <silent> 	 <Cmd>call v:lua.cmp.utils.keymap.set_map(1)
inoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(21)
cnoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(13)
inoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(12)
cnoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(15)
inoremap <silent>  <Cmd>call v:lua.cmp.utils.keymap.set_map(14)
inoremap  u
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set autowrite
set backupdir=/tmp/vim2/backup
set clipboard=unnamedplus
set expandtab
set nohlsearch
set ignorecase
set inccommand=split
set linespace=5
set nomodeline
set mouse=a
set path=.,/usr/include,,,**
set runtimepath=~/.config/nvim,/etc/xdg/nvim,~/.local/share/nvim/site,~/.local/share/nvim/site/pack/packer/start/packer.nvim,~/.local/share/nvim/site/pack/*/start/*,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/share/nvim/runtime,/usr/local/share/nvim/runtime/pack/dist/opt/matchit,/usr/local/lib64/nvim,~/.local/share/nvim/site/pack/*/start/*/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,~/.local/share/nvim/site/after,/etc/xdg/nvim/after,~/.config/nvim/after
set shada='100000,n/mega/repo/dotfiles/myshada
set shiftwidth=2
set sidescrolloff=3
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set statusline=%{%v:lua.require'lualine'.statusline()%}
set noswapfile
set tabstop=2
set termguicolors
set undodir=~/.local/share/nvim/undo//,/tmp/vim2/undodir
set undofile
set updatetime=600
set whichwrap=b,s,<,>,h,l,[,]
set wildignore=*.o,*.obj,.git,*.pyc
set window=28
set nowritebackup
" vim: set ft=vim :
