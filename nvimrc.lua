---@diagnostic disable: unused-local
vim.g.mapleader = " "
vim.opt.termguicolors = true
local cmd = vim.cmd

local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then
  print "comment not loading"
end

local diffviewc_ok, diffviewc = pcall(require, "diffview.config")
if not diffviewc_ok then
  print "diffviewc not loading"
end

local diffview_ok, diffview = pcall(require, "diffview")
if not diffview_ok then
  print "diffview not loading"
end

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
-- vim.g.indent_blankline_char = "┊"
-- vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
-- vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
-- vim.g.indent_blankline_char_highlight = "LineNr"
-- vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.cmd [[highlight IndentBlanklineIndent1 guibg=NONE gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#404040 gui=nocombine]]

require("indent_blankline").setup {
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    show_trailing_blankline_indent = false,
}

-- git
-- vgit.setup({})
-- diffview
local cb = diffviewc.diffview_callback
diffview.setup{
diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
  use_icons = true,         -- Requires nvim-web-devicons
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
  },
  file_panel = {
    position = "left",                  -- One of 'left', 'right', 'top', 'bottom'
    width = 4,                         -- Only applies when position is 'left' or 'right'
    height = 4,                        -- Only applies when position is 'top' or 'bottom'
    listing_style = "list",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
  },
  file_history_panel = {
    position = "bottom",
    width = 35,
    height = 16,
    log_options = {
      max_count = 256,      -- Limit the number of commits
      follow = false,       -- Follow renames (only for single file)
      all = false,          -- Include all refs under 'refs/' including HEAD
      merges = false,       -- List only merge commits
      no_merges = false,    -- List no merge commits
      reverse = false,      -- List commits in reverse order
    },
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {},         -- See ':h diffview-config-hooks'
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]      = cb("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]    = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["gf"]         = cb("goto_file"),          -- Open the file in a new split in previous tabpage
      ["<C-w><C-f>"] = cb("goto_file_split"),    -- Open the file in a new split
      ["<C-w>gf"]    = cb("goto_file_tab"),      -- Open the file in a new tabpage
      ["<leader>e"]  = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"]  = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = cb("next_entry"),           -- Bring the cursor to the next file entry
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),           -- Bring the cursor to the previous file entry.
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),         -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["<LeftMouse>"]   = cb("select_entry"),
      ["-"]             = cb("toggle_stage_entry"),   -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),            -- Stage all entries.
      ["U"]             = cb("unstage_all"),          -- Unstage all entries.
      ["X"]             = cb("restore_entry"),        -- Restore entry to the state on the left side.
      ["R"]             = cb("refresh_files"),        -- Update stats and entries in the file list.
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["i"]             = cb("listing_style"),        -- Toggle between 'list' and 'tree' views
      ["f"]             = cb("toggle_flatten_dirs"),  -- Flatten empty subdirectories in tree listing style.
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    file_history_panel = {
      ["g!"]            = cb("options"),            -- Open the option panel
      ["<C-A-d>"]       = cb("open_in_diffview"),   -- Open the entry under the cursor in a diffview
      ["y"]             = cb("copy_hash"),          -- Copy the commit hash of the entry under the cursor
      ["zR"]            = cb("open_all_folds"),
      ["zM"]            = cb("close_all_folds"),
      ["j"]             = cb("next_entry"),
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),
      ["o"]             = cb("select_entry"),
      ["<LeftMouse>"]   = cb("select_entry"),
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    option_panel = {
      ["<tab>"] = cb("select"),
      ["q"]     = cb("close"),
    },
  },
}
-- theme
vim.o.background = "dark"

vim.cmd [[
" transparent backgroub
colorscheme gruvbox
hi TabLineSel guifg=#ffffff guibg=#880088
hi TabLine    guifg=#282828 
hi signcolumn guifg=NONE guibg=NONE
"hi Normal guibg=NONE ctermbg=NONE
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
vim.cmd "au TextYankPost * lua vim.highlight.on_yank {on_visual = false}"  -- disabled in visual mode

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
vim.cmd "set guifont=\"JetBrainsMono Nerd Font Mono\""
vim.cmd "source ~/.config/nvim/lua/vimScript/init.vim"

vim.cmd "au BufRead,BufNewFile *.conf		setfiletype bash"
vim.cmd "au BufRead,BufNewFile *.fish		setfiletype fish"
vim.cmd "let g:do_filetype_lua = 1"
-- vim.cmd "let g:did_load_filetypes = 1"

local saga = require 'lspsaga'

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
