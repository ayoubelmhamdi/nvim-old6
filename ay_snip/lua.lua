local ls = Prequire "luasnip"
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local cr = ls.choice_node
local d = ls.dynamic_node

local ai = Prequire "luasnip.nodes.absolute_indexer"
local r = ls.restore_node

local fmt = Prequire("luasnip.extras.fmt").fmt

local function c(pos, choices, opts)
  if opts then
    opts.restore_cursor = true
  else
    opts = { restore_cursor = true }
  end
  return cr(pos, choices, opts)
end

local function lines(args, parent, old_state, initial_text)
  local nodes = {}
  old_state = old_state or {}

  -- count is nil for invalid input.
  local count = tonumber(args[1][1])
  -- Make sure there's a number in args[1].
  if count then
    for j = 1, count do
      local iNode
      if old_state and old_state[j] then
        -- old_text is used internally to determine whether
        -- dependents should be updated. It is updated whenever the
        -- node is left, but remains valid when the node is no
        -- longer 'rendered', whereas node:get_text() grabs the text
        -- directly from the node.
        iNode = i(j, old_state[j].old_text)
      else
        iNode = i(j, initial_text)
      end
      nodes[2 * j - 1] = iNode

      -- linebreak
      nodes[2 * j] = t { "", "" }
      -- Store insertNode in old_state, potentially overwriting older
      -- nodes.
      old_state[j] = iNode
    end
  else
    nodes[1] = t "Enter a number!"
  end

  local snip = sn(nil, nodes)
  snip.old_state = old_state
  return snip
end

return {
  s("nn", {
    c(1, {
      sn(nil, { t "(", r(1, "user_text"), t ")" }),
      sn(nil, { t "[", r(1, "user_text"), t "]" }),
      sn(nil, { t "{", r(1, "user_text"), t "}" }),
    }),
  }, {
    stored = {
      user_text = i(1, "default_text"),
    },
  }),
  s("test4", {
    i(1, "1"),
    d(2, lines, { 1 }, { user_args = { "Sample Text" } }),
  }),

  s("test3", {
    t "text: ",
    i(1),
    t { "", "copy: " },
    d(2, function(args)
      return sn(nil, {
        i(1, args[1]),
      })
    end, { 1 }),
  }),
  s(
    "test2",
    c(1, {
      sn(nil, { i(1, "def") }), -- this will.
      sn(nil, { i(1, "next") }), -- this will.
    })
  ),
  s("test1", {
    i(1, "text_of_first"),
    t "+",
    i(2, { "first_line_of_second", "second_line_of_second" }),
    t "+",
    f(function(args, snip)
      -- just concat first lines of both.
      return args[1][1] .. args[2][1]
    end, { ai[1], ai[2] }),
  }),
  s("trig", {
    i(1),
    f(function(args, snip, user_arg_l)
      return "<" .. args[1][1] .. "[1,1]" .. user_arg_l .. ">"
    end, { 1 }, { user_args = { "*********" } }),
    i(0),
  }),
  s(
    "ma",
    fmt(
      [[
        --int main({}){{
        --      {} {}
        --      return 0;
        --}}{}
        ]],
      {
        c(1, { t "int argv, char* argc[]", t "" }),
        c(2, {
          sn(nil, { t "string ", r(1, "user_text"), t ";" }),
          sn(nil, { t "int ", r(1, "user_text"), t ";" }),
          sn(nil, { t(""),r(1, "user_text") })
        }),
        i(3),
        i(0),
      }
    )
  ),
  --  s("incc",fmt(
  --      [[
  --      #include<{}>
  --      ]]
  --      ),{
  --          c(1,"stdio.h","math.h","string.h")
  --      }
  -- ),
}
