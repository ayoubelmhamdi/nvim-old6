vim.cmd[[
  set completeopt=menu,menuone,noselect
  " set mouse=a
  " set clipboard+=unnamedplus
  " set ts=2 " -- Insert 4 spaces for a tab
  " set sw=2 "
]]

vim.g.mapleader = " "
vim.opt.termguicolors = true

local cmp = Prequire("cmp")
local ls = Prequire("luasnip")
local lspkind = Prequire("lspkind")
local types = Prequire("luasnip.util.types")

cmp.setup({
  snippet = {
      expand = function(args)
        ls.lsp_expand(args.body)
      end
    },

  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<c-y>"] = cmp.mapping(
                cmp.mapping.confirm {
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = true,
                },
                { "i", "c" }
              ),
    ["<c-space>"] = cmp.mapping {
                      i = cmp.mapping.complete(),
                      c = function(
                        _ --[[fallback]]
                      )
                      if cmp.visible() then
                        if not cmp.confirm { select = true } then
                          return
                        end
                      else
                        cmp.complete()
                      end
                    end,
                  },
    ["<tab>"] = cmp.config.disable,
    -- Testing
    ["<c-q>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = cmp.config.sources({
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'tn' },
  }),
  experimental = {
    native_menu = false,
    ghost_text = true,
  },

  formatting = {
   format = lspkind.cmp_format {
     with_text = true,
     menu = {
       luasnip = "[snip]",
       buffer = "[buf]",
       nvim_lsp = "[LSP]",
       nvim_lua = "[api]",
       path = "[path]",
       gh_issues = "[issues]",
       tn = "[TabNine]",
     },
   },
  },
})

_ = vim.cmd [[
  augroup CmpFish
    au!
    autocmd Filetype fish lua require'cmp'.setup.buffer { sources = { { name = "fish" }, } }
  augroup END
]]


ls.config.set_config({
	history = true,
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	ext_base_prio = 300,
	ext_prio_increase = 1,
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
	ft_func = function()
		return vim.split(vim.bo.filetype, ".", true)
	end,
})

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/snip.lua<CR>")
