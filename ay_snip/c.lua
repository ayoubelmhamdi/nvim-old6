local ls = Prequire("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local fmt = Prequire("luasnip.extras.fmt").fmt


return  ({
    s("ma", fmt([[
        int main({}){{
              {}
              return 0;
        }}{}
        ]],
        {
        c(1,{t "int argv, char* argc[]", t ""}),
        c(2,{t"int ",t""}),
        i(0),
        }
    )),
   --  s("incc",fmt(
   --      [[
   --      #include<{}>
   --      ]]
   --      ),{
   --          c(1,"stdio.h","math.h","string.h")
   --      }
   -- ),
})
