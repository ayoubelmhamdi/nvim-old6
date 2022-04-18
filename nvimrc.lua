vim.g.mapleader = " "
vim.opt.termguicolors = true

function Prequire(...)
  local status, lib = pcall(require, ...)
  if (status) then
    return lib
  else
    print(... .. ": not looading")
  end
  return nil
end

local comment = Prequire('Comment')

local nvim_treesitter_configs = Prequire('nvim-treesitter.configs')
local todo_comments = Prequire('todo-comments')
local colorizer = Prequire('colorizer')
-- Prequire("ay_snip")

Prequire('impatient')
Prequire("luasnip.loaders.from_lua").lazy_load()
--Prequire('tsp')
---- setup
todo_comments.setup {}
colorizer.setup()

nvim_treesitter_configs.setup {
  ensure_installed = "maintained",
  sync_install = false,
  highlight = { enable = true, additional_vim_regex_highlighting = false },
}

-- theme
vim.o.background = "dark"

vim.cmd [[
  " transparent backgroub
  colorscheme gruvbox
  hi TabLineFill guibg=#282828
  hi TabLineSel guifg=#ffffff guibg=#880088
  hi TabLine    guifg=#909090  guibg=#282828
  hi signcolumn guifg=NONE guibg=NONE
  "hi Normal guibg=NONE ctermbg=NONE
  set clipboard+=unnamedplus



  " restore cursor position
  augroup restore_pos | au!
      au BufReadPost *
                  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                  \ |   exe "normal! g`\"zz"
                  \ | endif
  augroup end
]]

-- view cursor yank
-- vim.cmd "au TextYankPost * lua vim.highlight.on_yank {on_visual = false}"  -- disabled in visual mode
--
-- highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 300,
            on_visual = true,
        })
    end,
})
----require "ay_cmp"
----require "ay_luasnip"
----require "ay_autopair"
----require "ay_lspkind"
----require "ay_statusline"
----require "ay_packerPlugins"

require "ls"
require "ls.ay_efm"
require("flutter-tools").setup {}

--
vim.cmd[[
  set guifont=FiraCode\ Nerd\ Font\ 12
  source ~/.config/nvim/lua/vimScript/init.vim
  au BufRead,BufNewFile *.conf		setfiletype bash
  au BufRead,BufNewFile *.fish		setfiletype fish
  let g:do_filetype_lua = 1
]]
-- vim.cmd "let g:did_load_filetypes = 1"

-- local saga = require 'lspsaga'

-- default value
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- rename_prompt_prefix = '➤',

-- saga.init_lsp_saga {
--   }
  -- error_sign = '', -- 
  -- warn_sign = '',
  -- hint_sign = '', --'',
  -- infor_sign = '',
  -- code_action_keys = {
  --   quit = 'q',exec = '<CR>'
  -- },
vim.cmd[[
" Errors in Red
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
" Warnings in Yellow
hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
" Info and Hints in White
hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White
"autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
]]
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = true
  }
)
comment.setup {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
        line = 'gcc',
        block = 'gbc',
    },
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
    },
    mappings = {
        basic = true,
        extra = true,
        extended = false,
    },
    pre_hook = nil,
    post_hook = nil,
}
