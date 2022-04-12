local ls = Prequire("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = Prequire("luasnip.extras").lambda
local rep = Prequire("luasnip.extras").rep
local p = Prequire("luasnip.extras").partial
local m = Prequire("luasnip.extras").match
local n = Prequire("luasnip.extras").nonempty
local dl = Prequire("luasnip.extras").dynamic_lambda
local fmt = Prequire("luasnip.extras.fmt").fmt
local fmta = Prequire("luasnip.extras.fmt").fmta
local types = Prequire("luasnip.util.types")
local conds = Prequire("luasnip.extras.expand_conditions")
ls.config.set_config({
	history = true,
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	ext_base_prio = 300,
	ext_prio_increase = 1,
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
	ft_func = function()
		return vim.split(vim.bo.filetype, ".", true)
	end,
})
local function copy(args)
	return args[1]
end
local rec_ls
rec_ls = function()
	return sn(
		nil,
		c(1, {
			t(""),
			sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
		})
	)
end
local function jdocsnip(args, _, old_state)
	local nodes = {
		t({ "/**", " * " }),
		i(1, "A short Description"),
		t({ "", "" }),
	}
	local param_nodes = {}
	if old_state then
		nodes[2] = i(1, old_state.descr:get_text())
	end
	param_nodes.descr = nodes[2]
	if string.find(args[2][1], ", ") then
		vim.list_extend(nodes, { t({ " * ", "" }) })
	end
	local insert = 2
	for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
		arg = vim.split(arg, " ", true)[2]
		if arg then
			local inode
			if old_state and old_state[arg] then
				inode = i(insert, old_state["arg" .. arg]:get_text())
			else
				inode = i(insert)
			end
			vim.list_extend(
				nodes,
				{ t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) }
			)
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
		vim.list_extend(
			nodes,
			{ t({ " * ", " * @return " }), inode, t({ "", "" }) }
		)
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
		vim.list_extend(
			nodes,
			{ t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) }
		)
		param_nodes.ex = ins
		insert = insert + 1
	end
	vim.list_extend(nodes, { t({ " */" }) })
	local snip = sn(nil, nodes)
	snip.old_state = param_nodes
	return snip
end
local function bash(_, _, command)
	local file = io.popen(command, "r")
	local res = {}
	for line in file:lines() do
		table.insert(res, line)
	end
	return res
end
local date_input = function(args, snip, old_state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return sn(nil, i(1, os.date(fmt)))
end
--
ls.add_snippets("all", {
	s("fn", {
		t("//Parameters: "),
		f(copy, 2),
		t({ "", "function " }),
		i(1),
		t("("),
		i(2, "int foo"),
		t({ ") {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),
	s("class", {
		c(1, {
			t("public "),
			t("private "),
		}),
		t("class "),
		i(2),
		t(" "),
		c(3, {
			t("{"),
			sn(nil, {
				t("extends "),
				r(1, "other_class", i(1)),
				t(" {"),
			}),
			sn(nil, {
				t("implements "),
				r(1, "other_class"),
				t(" {"),
			}),
		}),
		t({ "", "\t" }),
		i(0),
		t({ "", "}" }),
	}),
	s(
		"fmt1",
		fmt("To {title} {} {}.", {
			i(2, "Name"),
			i(3, "Surname"),
			title = c(1, { t("Mr."), t("Ms.") }),
		})
	),
	s(
		"fmt2",
		fmt(
			[[
		foo({1}, {3}) {{
			return {2} * {4}
		}}
		]],
			{
				i(1, "x"),
				rep(1),
				i(2, "y"),
				rep(2),
			}
		)
	),
	s(
		"fmt3",
		fmt("{} {a} {} {1} {}", {
			t("1"),
			t("2"),
			a = t("A"),
		})
	),
	s("fmt4", fmt("foo() { return []; }", i(1, "x"), { delimiters = "[]" })),
	s("fmt5", fmta("foo() { return <>; }", i(1, "x"))),
	s(
		"fmt6",
		fmt("use {} only", { t("this"), t("not this") }, { strict = false })
	),
	s("novel", {
		t("It was a dark and stormy night on "),
		d(1, date_input, {}, { user_args = { "%A, %B %d of %Y" } }),
		t(" and the clocks were striking thirteen."),
	}),
	ls.parser.parse_snippet(
		"lspsyn",
		"Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"
	),
	ls.parser.parse_snippet(
		{ trig = "te", wordTrig = false },
		"${1:cond} ? ${2:true} : ${3:false}"
	),
	ls.parser.parse_snippet({ trig = "%d", regTrig = true }, "A Number!!"),
	s("cond", {
		t("will only expand in c-style comments"),
	}, {
		condition = function(line_to_cursor, matched_trigger, captures)
			return line_to_cursor:match("%s*//")
		end,
	}),
	s("cond2", {
		t("will only expand at the beginning of the line"),
	}, {
		condition = conds.line_begin,
	}),
	s(
		{ trig = "a%d", regTrig = true },
		f(function(_, snip)
			return "Triggered with " .. snip.trigger .. "."
		end, {})
	),
	s(
		{ trig = "b(%d)", regTrig = true },
		f(function(_, snip)
			return "Captured Text: " .. snip.captures[1] .. "."
		end, {})
	),
	s({ trig = "c(%d+)", regTrig = true }, {
		t("will only expand for even numbers"),
	}, {
		condition = function(line_to_cursor, matched_trigger, captures)
			return tonumber(captures[1]) % 2 == 0
		end,
	}),
	s("bash", f(bash, {}, { user_args = { "ls" } })),
	s("transform", {
		i(1, "initial text"),
		t({ "", "" }),
		l(l._1:match("[^i]*$"):gsub("i", "o"):gsub(" ", "_"):upper(), 1),
	}),
	s("transform2", {
		i(1, "initial text"),
		t("::"),
		i(2, "replacement for e"),
		t({ "", "" }),
		l(l._1:gsub("e", l._2), { 1, 2 }),
	}),
	s({ trig = "trafo(%d+)", regTrig = true }, {
		l(l.CAPTURE1:gsub("1", l.TM_FILENAME), {}),
	}),
	s("link_url", {
		t('<a href="'),
		f(function(_, snip)
			return snip.env.TM_SELECTED_TEXT[1] or {}
		end, {}),
		t('">'),
		i(1),
		t("</a>"),
		i(0),
	}),
	s("repeat", { i(1, "text"), t({ "", "" }), rep(1) }),
	s("part", p(os.date, "%Y")),
	s("mat", {
		i(1, { "sample_text" }),
		t(": "),
		m(1, "%d", "contains a number", "no number :("),
	}),
	s("mat2", {
		i(1, { "sample_text" }),
		t(": "),
		m(1, "[abc][abc][abc]"),
	}),
	s("mat3", {
		i(1, { "sample_text" }),
		t(": "),
		m(
			1,
			l._1:gsub("[123]", ""):match("%d"),
			"contains a number that isn't 1, 2 or 3!"
		),
	}),
	s("mat4", {
		i(1, { "sample_text" }),
		t(": "),
		m(1, function(args)
			return (#args[1][1] % 2 == 0 and args[1]) or nil
		end),
	}),
	s("nempty", {
		i(1, "sample_text"),
		n(1, "i(1) is not empty!"),
	}),
	s("dl1", {
		i(1, "sample_text"),
		t({ ":", "" }),
		dl(2, l._1, 1),
	}),
	s("dl2", {
		i(1, "sample_text"),
		i(2, "sample_text_2"),
		t({ "", "" }),
		dl(3, l._1:gsub("\n", " linebreak ") .. l._2, { 1, 2 }),
	}),
}, {
	key = "all",
})
ls.add_snippets("java", {
	s("fn", {
		d(6, jdocsnip, { 2, 4, 5 }),
		t({ "", "" }),
		c(1, {
			t("public "),
			t("private "),
		}),
		c(2, {
			t("void"),
			t("String"),
			t("char"),
			t("int"),
			t("double"),
			t("boolean"),
			i(nil, ""),
		}),
		t(" "),
		i(3, "myFunc"),
		t("("),
		i(4),
		t(")"),
		c(5, {
			t(""),
			sn(nil, {
				t({ "", " throws " }),
				i(1),
			}),
		}),
		t({ " {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),
}, {
	key = "java",
})
ls.add_snippets("tex", {
	s("ls", {
		t({ "\\begin{itemize}", "\t\\item " }),
		i(1),
		d(2, rec_ls, {}),
		t({ "", "\\end{itemize}" }),
	}),
}, {
	key = "tex",
})
ls.add_snippets("all", {
	s("autotrigger", {
		t("autosnippet"),
	}),
}, {
	type = "autosnippets",
	key = "all_auto",
})
ls.filetype_extend("lua", { "c" })
ls.filetype_set("cpp", { "c" })
ls.filetype_extend("all", { "_" })
require("luasnip.loaders.from_snipmate").load({ path = { "./my-snippets" } })
require("luasnip.loaders.from_lua").load({ include = { "c" } })
require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "cpp" } })
