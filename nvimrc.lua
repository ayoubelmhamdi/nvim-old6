---@diagnostic disable: unused-local
vim.g.mapleader = " "
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
cmd "set termguicolors"

local tsp_ok, tsp = pcall(require, "tsp")
if not tsp_ok then
  print "tsp not loading"
end

local impatient_ok, impatient = pcall(require, "impatient")
if not impatient_ok then
  print "impatient not loading"
end

local nvim_treesitter_configs_ok, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not nvim_treesitter_configs_ok then
  print "nvim-treesitter.configs not loading"
end

local comments_ok, comments = pcall(require, "todo-comments")
if not comments_ok then
  print "comments not loading"
end

local colorizer_ok, colorizer = pcall(require, "colorizer")
if not colorizer_ok then
  print "colorizer not loading"
end

---- setup
comments.setup {}
colorizer.setup()

nvim_treesitter_configs.setup {
  ensure_installed = "maintained",
  sync_install = false,
  ignore_install = { "javascript" },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
}
-- theme

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_char_highlight = "LineNr"
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- theme
vim.o.background = "dark"

cmd [[
" transparent backgroub
hi Normal guibg=NONE ctermbg=NONE
colorscheme gruvbox
set clipboard+=unnamedplus

" vim -> ysytem yank
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
xnoremap <silent> y y:call ClipboardYank()<cr>

" restore cursor position
augroup restore_pos | au!
    au BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g`\"zz"
                \ | endif
augroup end
]]

-- view cursor yank
cmd "au TextYankPost * lua vim.highlight.on_yank {on_visual = false}" -- disabled in visual mode

----require "ay_cmp"
----require "ay_luasnip"
----require "ay_autopair"
----require "ay_lspkind"
----require "ay_statusline"
----require "ay_packerPlugins"

require "ls"
require "ls.ay_efm"
require("flutter-tools").setup {}


cmd "source ~/.config/nvim/lua/vimScript/init.vim"
