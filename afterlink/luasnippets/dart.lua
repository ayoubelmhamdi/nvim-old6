local ls = Prequire "luasnip"
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local cr = ls.choice_node
local d = ls.dynamic_node

local fmt = Prequire("luasnip.extras.fmt").fmt
local ai = Prequire "luasnip.nodes.absolute_indexer"
local r = ls.restore_node
local rep = Prequire("luasnip.extras").rep

local function c(pos, choices, opts)
    if opts then
        opts.restore_cursor = true
    else
        opts = { restore_cursor = true }
    end
    return cr(pos, choices, opts)
end

local function opts(ss)
    local ext_opts = {
        active = {
            virt_text = { { ss, "GruvboxBlue" } },
        },
    }
    local node_ext_opts = { node_ext_opts = ext_opts }
    return node_ext_opts
end

return {
    s(
        "ma",
        fmt(
            [[
        import 'package:flutter/material.dart';
         
        void main() => runApp(
          const MaterialApp(
            home:{}(),
          ),
        );
         
        class {} extends StatelessWidget {{
          const MyApp({{Key? key}}) : super(key: key);

          @override
          Widget build(BuildContext context) {{
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Material App Bar'),
                ),
                body: Column(
                  children: const <Widget>[
                      {}, 
                    ],
                ),
            );
          }}
        }}
        ]],
            {
                c(1, { t "MyApp", t "" }),
                rep(1),
                c(2,{t"Text('Hello World')",t""}),
            }
        )
    ),
    s(
        "maa",
        fmt(
            [[
        int main({}){{
              {}
              return 0;
        }}{}
        ]],
            {
                c(1, { t "int argv, char* argc[]", t "" }),
                c(2, {
                    sn(nil, { t "string ", r(1, "user_text"), t ";" }),
                    sn(nil, { t "int ", r(1, "user_text"), t ";" }),
                    sn(nil, { t "", r(1, "user_text") }),
                }),
                i(0),
            },
            {
                stored = {
                    user_text = i(2, "default_text"),
                },
            }
        )
    ),
    s(
        "incc",
        fmt(
            [[
       #include{}
      ]],
            {
                c(1, {
                    sn(nil, { t "<stdio", r(1, "user_text"), t ".h>" }),
                    sn(nil, { t "<math", r(1, "user_text"), t ".h>" }),
                    sn(nil, { t "<string", r(1, "user_text"), t ".h>" }),
                    sn(nil, { t "<", r(1, "user_text"), t ".h>" }),
                    sn(nil, { t '"', r(1, "user_text"), t '.h"' }),
                }),
            }
        )
    ),
}
