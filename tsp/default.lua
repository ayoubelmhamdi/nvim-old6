local action_state = require "telescope.actions.state"
require("telescope").setup {
  defaults = {
    -- vimgrep_arguments = {'fd'},
    -- find_command = {'fad'},
    -- vimgrep_arguments = {"rig", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden"},
    -- find_command = {"rg", '--no-binary', "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case"},
    -- use_less = true,
    -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    -- vimgrep_arguments = {'rgo','--no-binary', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
    -- find_command= {'rg','--ignore','--hidden','--files','--no-binary'},
    -- file_sorter = require("telescope.sorters").get_fzy_sorter,
    -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- sorting_strategy = "ascending",
    -- layout_strategy = "horizontal",
    -- layout_config = {prompt_position = "top", height = 0.90, width = 0.90, preview_width = 0.60},
    -- -- layout_config = {
    -- --  prompt_position = "top",
    -- --  horizontal = {mirror = false},
    -- --  vertical = {mirror = false},
    -- --  --width = 0.75,
    -- --  --preview_cutoff = 120,
    -- -- },
    -- -- layout_config = {
    -- --   prompt_position="top"
    -- -- },
    color_devicons = true,
    prompt_prefix = " ",
    selection_caret = " ",
    mappings = {
      i = {
        ["<c-a>"] = function()
          print(vim.inspect(action_state.get_selected_entry()))
          -- Glow $this selecteda by <c-a> or <cr>
        end,
      },
    },
  },
  -- pickers = {find_files = {theme = "dropdown"}},
  pickers = { find_files = { theme = "dropdown" }, buffers = { sort_lastused = true, previewer = false } },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    frecency = {
      db_root = "/mega/repo/dotfiles/telescope-frency",
      show_scores = false,
      show_unindexed = false,
      ignore_patterns = { "*.git/*", "*/tmp/*", "*/lua-language-server/*", "*/.local/share/*" },
      disable_devicons = false,
      -- workspaces = {
      --   ["conf"]    = "~/.config",
      --   ["nvim"]    = "~/.config/nvim",
      --   ["project"] = "/projects",
      --   ["wiki"]    = "/mega/repo",
      --   }
    },
  },
}

-- must require 'apres' telescope config
-- if load 'avant' telescope config
-- this plugin will not detected by telecsope correctly
-- so i cant't use ignore file or use smaret case ...
require("telescope").load_extension "fzf"
require("telescope").load_extension "frecency"
require("telescope").load_extension "neoclip"
