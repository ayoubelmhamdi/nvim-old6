-- if true then
--     return
-- end
local t = Prequire "nvim-treesitter.configs"

-- Prequire('spellsitter').setup()
--
-- Prequire('spellsitter').setup {
--   enable = {'python', 'lua','c'},
-- }

t.setup {
    ensure_installed = {
        "c",
        "comment",
        "dart",
        "html",
        "java",
        "javascript",
        "json",
        "kotlin",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "markdown_inline",
        "python",
        "rust",
        "toml",
        "vim",
        "yaml",
    },
    sync_install = false,
    auto_install = false,

    highlight = {
        enable = true,
        disable = { "lll" },
        additional_vim_regex_highlighting = false,
    },
}


-- vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
--     group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
--     callback = function()
--         vim.opt.foldmethod = "expr"
--         vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--     end,
-- })
