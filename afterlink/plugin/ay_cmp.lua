-- vim.cmd([[
--         set rtp+=/projects/lua/friendly-snippets
--         autocmd BufWritePost *.json lua require("ls").snippets={}
--         autocmd BufWritePost *.json lua require("ls.loaders.from_vscode").load()
-- ]])
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  print "cmp not loading"
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
  print "lspkind not loading"
end

local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  print "ls not loading"
end

-- require("ls/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup {
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body) -- For `ls` users.
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif ls.expandable() then
        ls.expand()
      elseif ls.expand_or_jumpable() then
        ls.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  -- formatting = {
  --     fields = {"kind", "abbr", "menu"},
  --     format = function(entry, vim_item)
  --         -- Kind icons
  --         vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
  --         -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
  --         vim_item.menu = ({nvim_lsp = "[LSP]", ls = "[Snippet]", buffer = "[Buffer]", path = "[Path]"})[entry.source.name]
  --         return vim_item
  --     end
  -- },
  --

  formatting = {
    fields = { "kind", "abbr" },
    format = lspkind.cmp_format {
      with_text = false,
      maxwidth = 20,
      menu = {
        nvim_lsp = "[LSP]",
        ls = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        tn = "[TabNine]",
      },
    },
  },
  sources = { { name = "nvim_lsp" }, { name = "ls" }, { name = "buffer" }, { name = "path" } },
  confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
  documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
  experimental = { ghost_text = true, native_menu = false },
}
