local ls = Prequire "luasnip"

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
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local m = Prequire("luasnip.extras").m
local l = Prequire("luasnip.extras").l
local dl = require("luasnip.extras").dynamic_lambda

local function opts(ss)
    local ext_opts = {
        active = {
            virt_text = { { ss, "GruvboxBlue" } },
        },
    }
    local node_ext_opts = { node_ext_opts = ext_opts }
    return node_ext_opts
end

local function c(pos, choices, opts)
    if opts then
        opts.restore_cursor = true
    else
        opts = { restore_cursor = true }
    end
    return cr(pos, choices, opts)
end

local rec_ls
rec_ls = function()
    return sn(
        nil,
        c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t "",
            sn(nil, { t { "", "\t\\item " }, i(1), d(2, rec_ls, {}) }),
        })
    )
end

local main_args = function(position)
    return d(position, function()
        local nodes = {}
        table.insert(nodes, t "--")

        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for _, line in ipairs(lines) do
            if line:match("ma2") then
                table.insert(nodes, t "--> one")
                break
            end
        end

            return sn(nil, c(1, nodes, opts "main <--"))
    end, {})
end


return {
    s(
        "begin",
        fmta(
            [[
            \begin{<1><2>}
                <3>
            \end{<4><5>}
            ]],
            {
                -- i(3),
                c(1, {
                    i(nil, ""),
                    t "equation",
                    t "String",
                    t "char",
                    t "int",
                    t "double",
                    t "boolean",
                }, opts "6:(...., equation, String, char, int, double, boolean)"),
                c(2, { t "", t "*" }, opts "2:(... , *)"),
                i(3),
                rep(1),
                rep(2),
            }
        )
    ),
}
