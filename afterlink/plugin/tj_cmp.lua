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

local source_mapping = {
    luasnip = "[snip]",
    buffer = "[buf]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[api]",
    path = "[path]",
    gh_issues = "[issues]",
    cmp_tabnine = "[TabNine]",
    latex_symbols = "symbol",
}

cmp.setup({
  snippet = {
      expand = function(args)
        ls.lsp_expand(args.body)
      end
    },

  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
    ["<down>"] = cmp.config.disable,
    ["<up>"] = cmp.config.disable,
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
    { name = 'cmp_tabnine' },
  }),
  experimental = {
    native_menu = false,
    ghost_text = true,
  },

  formatting = {
      format = function(entry, vim_item)
                vim_item.kind = lspkind.presets.default[vim_item.kind]
                local menu = source_mapping[entry.source.name]
                if entry.source.name == 'cmp_tabnine' then
                    if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                        menu = entry.completion_item.data.detail .. ' ' .. menu
                    end
                    vim_item.kind = ''
                end
                vim_item.menu = menu
                return vim_item
            end
        },
})

-- TODO to lua
_ = vim.cmd [[
  augroup CmpFish
    au!
    autocmd Filetype fish lua Prequire'cmp'.setup.buffer { sources = { { name = "fish" }, } }
  augroup END
]]
-- vim.cmd [[
--   augroup CmpTex
--     au!
--     autocmd Filetype tex lua Prequire'cmp'.setup.buffer { sources = { { name = "latex_symbols" }, } }
--   augroup END
-- ]]

ls.config.set_config({
	history = false,
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "<-- choiceNode", "Comment" } },
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



vim.keymap.set("i", "<c-u>", Prequire "luasnip.extras.select_choice")
