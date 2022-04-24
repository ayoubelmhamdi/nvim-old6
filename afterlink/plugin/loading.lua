
Prequire("luasnip.loaders.from_lua").lazy_load()
Prequire "ls"
Prequire "ls.ay_efm"
Prequire("flutter-tools").setup {}
Prequire('tsp')

local todo_comments = Prequire "todo-comments"
local colorizer = Prequire "colorizer"


todo_comments.setup {}
colorizer.setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = true,
})


-- highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank {
            higroup = "IncSearch",
            timeout = 300,
            on_visual = true,
        }
    end,
})
