"  ____  _____ _____      ___  ____ _____ ___ ___  _   _ 
" / ___|| ____|_   _|    / _ \|  _ \_   _|_ _/ _ \| \ | |
" \___ \|  _|   | |_____| | | | |_) || |  | | | | |  \| |
"  ___) | |___  | |_____| |_| |  __/ | |  | | |_| | |\  |
" |____/|_____| |_|      \___/|_|    |_| |___\___/|_| \_|
                                                       

lua << EOF
vim.o.hidden = true
vim.o.fileencoding = "utf-8"
--vim.o.termguicolors = true
vim.o.splitbelow = true
vim.o.splitright = true
--vim.o.conceallevel = 0 -- So that I can see `` in markdown files
--vim.wo.number = true
--vim.wo.relativenumber = true
vim.o.backup = false
vim.o.writebackup = false
vim.wo.signcolumn = "yes"
--vim.o.clipboard = "unnamedplus"
EOF
" syntax on


" set scrolloff=4
set sidescrolloff=3
set path+=**
set whichwrap=b,s,<,>,h,l,[,]
set nojoinspaces 
set linespace=5
set clipboard+=unnamedplus
set inccommand=split " -- Make substitution work in realtime
set ts=2 " -- Insert 4 spaces for a tab
set sw=2 " -- Change the number of space characters inserted for indentation


set nowrap
set autoindent
set smartindent

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

set backspace=indent,eol,start
set colorcolumn=110
set cursorline

set mouse=a
set updatetime=600
set wildignore+=*.o,*.obj,.git,*.pyc


set noswapfile nowritebackup undofile nobackup
set backupdir=/tmp/vim2/backup
set undodir+=/tmp/vim2/undodir

set shada='100000,n/mega/repo/dotfiles/shada-nvim/myshada
set autoread autowrite
set ignorecase smartcase
" set list listchars=eol:⏎

set cmdheight=1

set nohlsearch
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
augroup END

" Disabled Now: 
"     set foldmethod=manual
"     set formatprg=prettier
"     set incsearch
"     set linebreak
"     set nohlsearch
"     set showtabline=2



""""set complete+=kspell
""""set formatoptions=cro
""""set go=a
""""set laststatus=2
""""set matchpairs+=<:> "TODO: use filetype 
""""set mmp=5000
""""set modelines=2
""""set noerrorbells visualbell t_vb=
""""set noshiftround
""""set nospell
""""set nostartofline
""""set pumheight=10
""""set regexpengine=1
""""set ruler
""""set shortmess+=c
""""set showcmd
""""set showmatch
""""set showmode
""""set spelllang=en_us
""""set textwidth=0
""""set timeoutlen=900
""""set ttimeout
""""set ttimeoutlen=0
""""set wildmenu
""""set wildmode=longest,list,full
""""set virtualedit=block




"""""tow line for schow error
""""" set endofline
""""" set list
""""" set listchars=tab:>-,eol:¶
""""" set listchars=tab:>.,trail:.,precedes:<,extends:>
""""" set tw=0
""""" set wm=0
""""" using only 1 column (and 1 space) while possible
""""" set numberwidth=1
""""" set nolazyredraw
