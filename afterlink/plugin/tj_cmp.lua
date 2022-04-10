vim.cmd[[
  set completeopt=menu,menuone,noselect
  set mouse=a
  set clipboard+=unnamedplus
  set ts=2 " -- Insert 4 spaces for a tab
  set sw=2 "
]]

vim.g.mapleader = " "
vim.opt.termguicolors = true

local cmp = Prequire("cmp")
local ls = Prequire("luasnip")
local lspkind = Prequire("lspkind")

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
    -- ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    -- ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- ['<C-e>'] = cmp.mapping({
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    -- }),
    -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'luasnip' }, -- For luasnip users.
    --{ name = 'nvim_lsp' },
    --{ name = 'buffer' },
    --{ name = 'nvim_lua' },
    --{ name = 'path' },
    --{ name = 'tn' },
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



vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
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
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
