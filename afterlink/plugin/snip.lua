local ls = Prequire("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.sn


local fmt = Prequire("luasnip.extras.fmt").fmt
local rep =Prequire("luasnip.extras").rep

local same = function ()
    return f(
    function()
        return os.date "%H:%M"
    end)
end

local get_test_result= function(position)
    return d(position,function()
        local nodes = {}
        table.insert(nodes,t " ")

        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for _, line in ipairs(lines) do
           if line:match("add.snippets") then
               table.insert(nodes, t"-> result<()>")
               break
           end
        end
        return sn(nil,c(1, nodes))
    end,{})
end



ls.add_snippets("lua", {
    s("dyn",fmt([[
            #[test]
            fn {}(){}{{
                {}
            }}
        ]],
        {
            i(1,"testname"),
            get_test_result(2),
            i(0),
        }
        )
    ),
    s("ls", {
        t({ "\\begin{itemize}", "\t\\item " }),
    }),
    s("req", fmt([[
        local {} = Prequire("{}")
        ]],
        {
            f(function(import_name)
                local parts = vim.split(import_name[1][1],".",true)
                return parts[#parts] or ""
            end,{1}),
            i(1)
        }
    )),
    s("test",fmt(
    [[
    #[cfg(test)]
    mode test {{
    {}

        {}
    }}
    ]],
    {
        c(1,{ t " use super::*;", t "" }),
        i(0),
    }
    )),
    s("mytime", same())
    },
    {
    key = "tex",
})
