local nvim_treesitter_configs = Prequire "nvim-treesitter.configs"

nvim_treesitter_configs.setup {
   -- ensure_installed = "maintained",
    sync_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
}
