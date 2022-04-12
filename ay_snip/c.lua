local ls = Prequire("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node


return  ({
    s("ma", {
      t({"int main(int argv, char* argc[]){","}"}),
    }),
    s("incc",{
      t({"#include<"}),
      i(1,'stdio.h'),
      t({">"}),
    }),
})
