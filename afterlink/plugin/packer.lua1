require("packer").init {
  -- package_root = nvim_name .. '/plugins/pack',
  -- compile_path = nvim_name .. '/plugins/packer_compile_lua.lua',
  max_jobs = 4,
  git = {
    clone_timeout = 3600, -- Timeout, in seconds, for git clones
  },
}

require("packer").startup(function(use)
  -- Dependencies:
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "ojroques/nvim-lspfuzzy"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "nvim-treesitter/playground" -- viewer
  use "nvim-telescope/telescope.nvim"
  use "sudormrfbin/cheatsheet.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "kyazdani42/nvim-web-devicons"
  use "tami5/sql.nvim"
  use "nvim-lua/lsp-status.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  -- use "nvim-telescope/telescope-frecency.nvim"
  -- use 'nvim-telescope/telescope-project.nvim'

  -- Installation
  use { 'L3MON4D3/LuaSnip' }
  use { 'hrsh7th/nvim-cmp'}
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'onsails/lspkind-nvim' }

  -- nvim-cmp
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"
  -- use "kdheepak/cmp-latex-symbols"
  use "octaltree/cmp-look"
  use "f3fora/cmp-spell"
  -- use 'uga-rosa/cmp-user_dictionary'
  -- use { "tzachar/cmp-tabnine", run = "./install.sh" }
  -- use {'f3fora/cmp-nuspell', rocks = {'lua-nuspell'}}

  -- use "ayoubelmhamdi/friendly-snippets"

  -- LSP+IDE
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "theHamsta/nvim-dap-virtual-text"
  use 'leoluz/nvim-dap-go'
  use "neovim/nvim-lspconfig"
  use "stevearc/qf_helper.nvim"



  use "akinsho/flutter-tools.nvim"
  use "windwp/nvim-autopairs"
  use {"ur4ltz/surround.nvim", config = function() Prequire"surround".setup{mappings_style = "sandwich"} end}

  -- theme+line
  --use { "luukvbaal/stabilize.nvim", config = function() require("stabilize").setup() end }
  use "tjdevries/colorbuddy.nvim"
  use "glepnir/lspsaga.nvim"
  use "ellisonleao/gruvbox.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use 'nvim-lualine/lualine.nvim'
  -- use "akinsho/nvim-bufferline.lua"
  -- use 'wfxr/minimap.vim'
  -- use 'nanozuki/tabby.nvim'
  use "aspeddro/slides.nvim"

  -- Misc
  use "907th/vim-auto-save" -- auto save files like dart
  -- use 'rmagatti/auto-session' -- save session layout
  -- use 'rmagatti/session-lens' -- save session layout with telescope
--use { 'tanvirtin/vgit.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use "TimUntersberger/neogit"
  use "lewis6991/gitsigns.nvim"
  use "sindrets/diffview.nvim"
  use "airblade/vim-rooter"
  use "numToStr/Comment.nvim"
  -- use "tpope/vim-commentary"
  -- use 'ahmedkhalf/lsp-rooter.nvim' -- chaneg workin directory
  -- use 'lewis6991/spellsitter.nvim'
  use "tjdevries/train.nvim"
  -- use 'phaazon/hop.nvim'
  use "folke/todo-comments.nvim"
  -- startup imprevment to be speed
  use "lewis6991/impatient.nvim"
  -- select funcion
  -- by treesitter
  use "David-Kunz/treesitter-unit"
  use "lewis6991/spellsitter.nvim"
  -- by vimscript
  -- use 'kana/vim-textobj-user'
  -- use 'kamichidu/vim-textobj-function-go'
  -- use 'thinca/vim-textobj-function-javascript'
  -- clipboard
  use "AckslD/nvim-neoclip.lua"
  -- markdown glow
  use "ellisonleao/glow.nvim"
  -- use 'jakewvincent/texmagic.nvim'

  -- static config
  use "luukvbaal/nnn.nvim"
  use "static-nvim/mkdir"
  use "fedepujol/move.nvim"
  use "tamton-aquib/essentials.nvim"
  -- test
  use "nathom/filetype.nvim"
  use "max397574/better-escape.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "voldikss/vim-floaterm"
  use "ray-x/lsp_signature.nvim"
  -- i don't need motion by f/F/t/T
  -- i wnat only color to do this
  -- this plugin is autostart so i cant use it with my config
  -- use 'ggandor/lightspeed.nvim'
end)

vim.cmd [[autocmd BufWritePost ay_packerPlugins.lua source <afile> | PackerCompile]]

-- NOTE: : note todo hack warn pere
-- TODO: : note todo hack warn pere
-- HACK: : note todo hack warn pere
-- WARN: : note todo hack warn pere
-- PERF: : note todo hack warn pere
