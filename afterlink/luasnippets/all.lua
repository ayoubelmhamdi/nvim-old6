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

-- complicated function for dynamicNode.
local function jdocsnip(args, old_state)
    local nodes = {
        t { "/**", " * " },
        i(1, "A short Description"),
        t { "", "" },
    }

    -- These will be merged with the snippet; that way, should the snippet be updated,
    -- some user input eg. text can be referred to in the new snippet.
    local param_nodes = {}

    if old_state then
        nodes[2] = i(1, old_state.descr:get_text())
    end
    param_nodes.descr = nodes[2]

    -- At least one param.
    if string.find(args[2][1], ", ") then
        vim.list_extend(nodes, { t { " * ", "" } })
    end

    local insert = 2
    for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
        -- Get actual name parameter.
        arg = vim.split(arg, " ", true)[2]
        if arg then
            local inode
            -- if there was some text in this parameter, use it as static_text for this new snippet.
            if old_state and old_state[arg] then
                inode = i(insert, old_state["arg" .. arg]:get_text())
            else
                inode = i(insert)
            end
            vim.list_extend(nodes, { t { " * @param " .. arg .. " " }, inode, t { "", "" } })
            param_nodes["arg" .. arg] = inode

            insert = insert + 1
        end
    end

    if args[1][1] ~= "void" then
        local inode
        if old_state and old_state.ret then
            inode = i(insert, old_state.ret:get_text())
        else
            inode = i(insert)
        end

        vim.list_extend(nodes, { t { " * ", " * @return " }, inode, t { "", "" } })
        param_nodes.ret = inode
        insert = insert + 1
    end

    if vim.tbl_count(args[3]) ~= 1 then
        local exc = string.gsub(args[3][2], " throws ", "")
        local ins
        if old_state and old_state.ex then
            ins = i(insert, old_state.ex:get_text())
        else
            ins = i(insert)
        end
        vim.list_extend(nodes, { t { " * ", " * @throws " .. exc .. " " }, ins, t { "", "" } })
        param_nodes.ex = ins
        insert = insert + 1
    end

    vim.list_extend(nodes, { t { " */" } })

    local snip = sn(nil, nodes)
    -- Error on attempting overwrite.
    snip.old_state = param_nodes
    return snip
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(args, command)
    local com = args[2].captures[1]
    --print(vim.inspect(args[2]))
    local file = io.popen(com, "r")
    local res = {}
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
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
    s("fn", {
        -- d(6, jdocsnip, { 2, 4, 5 }),
        t { "", "" },
        c(1, {
            t "public ",
            t "private ",
        }, opts "2:(public , private)"),
        c(2, {
            t "void",
            t "String",
            t "char",
            t "int",
            t "double",
            t "boolean",
            i(nil, ""),
        }, opts "6:(...., void, String, char, int, double, boolean)"),
        t " ",
        i(3, "myFunc"),
        t "(",
        i(4),
        t ")",
        c(5, {
            t "",
            sn(nil, {
                t " throws ",
                i(1, nil, opts "i2"),
            }),
        }, opts "2:(...., throws)"),
        t { " {", "\t" },
        i(0),
        t { "", "}" },
    }),
    s("dl2", {
        i(1, "sample_text"),
        i(2, "sample_text_2"),
        t { "", "" },
        dl(3, l._1:gsub("\n", " linebreak ") .. l._2, { 1, 2 }),
    }),
    s("kkk", {
        i(1, "text1", opts "111"),
        i(2, "text2", opts "222"),
    }),
}
