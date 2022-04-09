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


--cmp.setup {
--  snippet = {
--    expand = function(args)
--      ls.lsp_expand(args.body) -- For `ls` users.
--    end,
--  },
--  mapping = {
--    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
--    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
--    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
--    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--    ["<C-y>"] = cmp.mapping.confirm({ select = true }), , -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--    ["<CR>"] = cmp.mapping.confirm { select = true },
--    ["<Tab>"] = cmp.mapping(function(fallback)
--      if cmp.visible() then
--        cmp.select_next_item()
--      elseif ls.expandable() then
--        ls.expand()
--      elseif ls.expand_or_jumpable() then
--        ls.expand_or_jump()
--      elseif check_backspace() then
--        fallback()
--      else
--        fallback()
--      end
--    end, { "i", "s" }),
--    ["<S-Tab>"] = cmp.mapping(function(fallback)
--      if cmp.visible() then
--        cmp.select_prev_item()
--      elseif ls.jumpable(-1) then
--        ls.jump(-1)
--      else
--        fallback()
--      end
--    end, { "i", "s" }),
--  },
--  -- formatting = {
--  --     fields = {"kind", "abbr", "menu"},
--  --     format = function(entry, vim_item)
--  --         -- Kind icons
--  --         vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
--  --         -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
--  --         vim_item.menu = ({nvim_lsp = "[LSP]", ls = "[Snippet]", buffer = "[Buffer]", path = "[Path]"})[entry.source.name]
--  --         return vim_item
--  --     end
--  -- },
--  --

--  formatting = {
--    fields = { "menu", "abbr" },
--    format = lspkind.cmp_format {
--      with_text = false,
--      maxwidth = 20,
--      menu = {
--        nvim_lsp = "[LSP]",
--        ls = "[Snippet]",
--        buffer = "[Buffer]",
--        path = "[Path]",
--        tn = "[TabNine]",
--      },
--    },
--  },
--  sources = {
--    { name = "nvim_lsp" },
--    { name = "ls", max_item_count=5 },
--    { name = "buffer",keyword_lengh=5 },
--    { name = "path" }
--  },
--  confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
--  documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
--  experimental = {
--    ghost_text = true,
--    native_menu = false,
--  },
--}



vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.shortmess:append "c"

-- Complextras.nvim configuration
-- vim.api.nvim_set_keymap(
--   "i",
--   "<C-x><C-m>",
--   [[<c-r>=luaeval("require('complextras').complete_matching_line()")<CR>]],
--   { noremap = true }
-- )

-- vim.api.nvim_set_keymap(
--   "i",
--   "<C-x><C-d>",
--   [[<c-r>=luaeval("require('complextras').complete_line_from_cwd()")<CR>]],
--   { noremap = true }
-- )



lspkind.init()


cmp.setup {
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
    ["<c-q>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
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
  },

  sources = {
    { name = "nvim_lua" },

    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 5 },
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },

  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        gh_issues = "[issues]",
        tn = "[TabNine]",
      },
    },
  },

  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,

    -- Let's play with this for a day or two
    ghost_text = true,
  },
}

_ = vim.cmd [[
  augroup DadbodSql
    au!
    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
  augroup END
]]

_ = vim.cmd [[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
  augroup END
]]
-- nvim-cmp highlight groups.
-- local Group = require("colorbuddy.group").Group
-- local g = require("colorbuddy.group").groups
-- local s = require("colorbuddy.style").styles

-- Group.new("CmpItemAbbr", require("colorbuddy.group").groups.Comment)
-- Group.new("CmpItemAbbrDeprecated", g.Error)
-- Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
-- Group.new("CmpItemKind", g.Special)
-- Group.new("CmpItemMenu", g.NonText)
