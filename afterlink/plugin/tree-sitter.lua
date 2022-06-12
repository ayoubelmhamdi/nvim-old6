-- if true then
--     return
-- end
local nvim_treesitter_configs = Prequire "nvim-treesitter.configs"

nvim_treesitter_configs.setup {
    -- ensure_installed = "maintained",
    -- ensure_installed = { "c", "lua", "rust" },
    disable = { "dart", "glsl" },
    sync_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
}

Prequire('spellsitter').setup()

Prequire('spellsitter').setup {
  enable = {'python', 'lua','c'},
}
