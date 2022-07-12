local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local completion = null_ls.builtins.completion
-- local diagnostics = null_ls.builtins.diagnostics
-- local code_actions = null_ls.builtins.code_actions
-- local hover = null_ls.builtins.hover

null_ls.setup({
	sources = {
		-- diagnostics.luacheck,
		formatting.stylua,
		completion.spell,
	},
})
