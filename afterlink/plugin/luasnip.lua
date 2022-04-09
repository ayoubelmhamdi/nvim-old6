local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  print "ls not loading"
end

local types_ok, types = pcall(require, "luasnip.util.types")
if not types_ok then
  print "luasnip.util.types not loading"
end
if vim.g.snippets ~= "luasnip" or not pcall(require, "luasnip") then
  -- print "luasnip.util.types loading"
  return
end


ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " <- Current Choice", "NonTest" } },
      },
    },
  },
}
local snippet = ls.s
local snippet_from_nodes = ls.sn
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local events = require "luasnip.util.events"
local shortcut = function(val)
  if type(val) == "string" then
    return { t { val }, i(0) }
  end
  if type(val) == "table" then
    for k, v in ipairs(val) do
      if type(v) == "string" then
        val[k] = t { v }
      end
    end
  end
  return val
end
local make = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, (snippet({ trig = k, desc = v.desc }, shortcut(v))))
  end
  return result
end
local same = function(index)
  return f(function(args)
    return args[1]
  end, { index })
end
local snippets = {}
local toexpand_count = 0
snippets.all = {
  snippet("simple", t "wow, you were right!"),
  snippet("toexpand", c(1, { t "hello", t "world", t "last" }), {
    callbacks = {
      [1] = {
        [events.enter] = function(--[[ node ]])
          toexpand_count = toexpand_count + 1
          print("Number of times entered:", toexpand_count)
        end,
      },
    },
  }),
  snippet("never_expands", t "this will never expand, condition is false", {
    condition = function()
      return false
    end,
  }),
  snippet({ trig = "date" }, {
    f(function()
      return string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), os.date())
    end, {}),
  }),
  snippet("for", {
    t "for ",
    i(1, "k, v"),
    t " in ",
    i(2, "ipairs()"),
    t { "do", "  " },
    i(0),
    t { "", "" },
    t "end",
  }),
        s(
            "fmt1",
            fmt("To {title} {} {}.", {
                i(2, "Name"),
                i(3, "Surname"),
                title = c(1, { t("Mr."), t("Ms.") }),
            })
        ),
}
table.insert(snippets.all, ls.parser.parse_snippet("example", "-- $TM_FILENAME\nfunc $1($2) $3 {\n\t$0\n}"))
table.insert(
  snippets.all,
  snippet("cond", {
    t "will only expand in c-style comments",
  }, {
    condition = function(
      line_to_cursor --[[ , matched_trigger, captures ]]
    )
      local commentstring = "%s*" .. vim.bo.commentstring:gsub("%%s", "")
      return line_to_cursor:match(commentstring)
    end,
  })
)
table.insert(
  snippets.all,
  snippet(
    { trig = "$$ (.*)", regTrig = true },
    f(function(_, snip, command)
      if snip.captures[1] then
        command = snip.captures[1]
      end
      local file = io.popen(command, "r")
      local res = { "$ " .. snip.captures[1] }
      for line in file:lines() do
        table.insert(res, line)
      end
      return res
    end, {}, "ls"),
    {
      show_condition = function()
        return false
      end,
    }
  )
)
table.insert(
  snippets.all,
  snippet("transform2", {
    i(1, "initial text here"),
    t " :: ",
    i(2, "replacement for text"),
    t " :: ",
    l(l._1:gsub("text", l._2), { 1, 2 }),
  })
)
for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/tj/snips/ft/*.lua", true)) do
  local ft = vim.fn.fnamemodify(ft_path, ":t:r")
  snippets[ft] = make(loadfile(ft_path)())
end
local js_attr_split = function(args)
  local val = args[1][1]
  local split = vim.split(val, ".", { plain = true })
  local choices = {}
  local thus_far = {}
  for index = 0, #split - 1 do
    table.insert(thus_far, 1, split[#split - index])
    table.insert(choices, t { table.concat(thus_far, ".") })
  end
  return snippet_from_nodes(nil, c(1, choices))
end
local fill_line = function(char)
  return function()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(0, row - 2, row, false)
    return string.rep(char, #lines[1])
  end
end
snippets.rst = make {
  jsa = {
    ":js:attr:`",
    d(2, js_attr_split, { 1 }),
    " <",
    i(1),
    ">",
    "`",
  },
  link = { ".. _", i(1), ":" },
  head = f(fill_line "=", {}),
  sub = f(fill_line "-", {}),
  subsub = f(fill_line "^", {}),
  ref = { ":ref:`", same(1), " <", i(1), ">`" },
}
ls.snippets = snippets
ls.autosnippets = {
  all = {
    ls.parser.parse_snippet("$file$", "$TM_FILENAME"),
  },
}
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

-- shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<space><space>s", "<cmd>source ~/.config/nvim/after/plugin/ay_luasnip.lua<CR>")
