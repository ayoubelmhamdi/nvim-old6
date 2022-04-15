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
local m = Prequire("luasnip.extras").m
local lambda = Prequire("luasnip.extras").l

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

    local count = tonumber(args[1][1])
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
local function simple_restore1(args, _)
    return sn(nil, { i(1, args[1]), i(2, "user_text") })
end

local function simple_restore(args, _)
    return sn(nil, { i(1, args[1]), r(2, "dyn", i(nil, "user_text")) })
end

return {
    s("trig3", {
        i(1),
        t ":",
        i(2),
        t "::",
        m(
            { 1, 2 },
            lambda._1:match("^" .. lambda._2 .. "$"),
            lambda._1:gsub("a", "e")
        ),
    }),
    s("trig2", {
        i(1),
        c(2, {
            sn(
                nil,
                {
                    i(1),
                    t "can access the argnode :)",
                    f(function(args)
                        return args[1]
                    end, ai[1]),
                }
            ),
            t "sample_text",
        }),
    }),
    s("rest", {
        i(1, "preset"),
        t { "", "" },
        d(2, simple_restore, 1),
    }),
    s(
        "fnc",
        fmt(
            [[
        {}({}): {} {{
                 {}{}
             }}
        ]],
            {
                c(1, {
                    fmt("function {}", { i(1) }),
                    fmt("const {} = function", { i(1) }),
                    fmt("let {} = function", { i(1) }),
                }),

                i(2),
                i(3),
                i(4),
                i(0),
            }
        )
    ),
    s("test5", {
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
        i(1),
        d(2, lines, { 1 }, { user_args = { "Sample Text" } }),
    }),

    s("nn", {
        t "text: ",
        i(1),
        t { "", "oooo: " },
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
                    sn(nil, { t "", r(1, "user_text") }),
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
