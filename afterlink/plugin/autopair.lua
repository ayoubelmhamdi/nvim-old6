-- require("nvim-autopairs.completion.compe").setup({
--   -- map_cr = true, --  map <CR> on insert mode
--   map_complete = true -- it will auto insert `(` after select function or method item
-- })

Prequire("nvim-autopairs").setup()

-- local disable_filetype = { "TelescopePrompt" }
-- local ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "")
-- local enable_moveright = true
-- local enable_afterquote = true  -- add bracket pairs after quote
-- local enable_check_bracket_line = true  --- check bracket in same line
-- local check_ts = false

local Rule = require "nvim-autopairs.rule"
local npairs = require "nvim-autopairs"

npairs.add_rule(Rule("$$", "$$", "tex"))

-- you can use some built-in condition

local cond = require "nvim-autopairs.conds"
-- print(vim.inspect(cond))

npairs.add_rules {
  Rule("$", "$", { "tex", "latex" }) -- don't add a pair if the next character is %
    :with_pair(cond.not_after_regex_check "%%") -- don't add a pair if  the previous character is xxx
    :with_pair(cond.not_before_regex_check("xxx", 3)) -- don't move right when repeat character
    :with_move(cond.none()) -- don't delete if the next character is xx
    :with_del(cond.not_after_regex_check "xx") -- disable  add newline when press <cr>
    :with_cr(cond.none()),
}

npairs.add_rules {
  Rule("$$", "$$", "tex"):with_pair(function(opts)
    print(vim.inspect(opts))
    if opts.line == "aa $$" then
      -- don't add pair on that line
      return false
    end
  end),
}

-- you can use regex
--  press u1234 => u1234number
npairs.add_rules {
  Rule("u%d%d%d%d$", "number", "lua"):use_regex(true),
}

--  press x1234 => x12341234
npairs.add_rules {
  Rule("x%d%d%d%d$", "number", "lua"):use_regex(true):replace_endpair(function(opts)
    -- print(vim.inspect(opts))
    return opts.prev_char:sub(#opts.prev_char - 3, #opts.prev_char)
  end),
}

-- you can do anything with regex +special key
-- example press tab will upper text
-- press b1234s<tab> => B1234S1234S

npairs.add_rules {
  Rule("b%d%d%d%d%w$", "", "vim"):use_regex(true, "<tab>"):replace_endpair(function(opts)
    return opts.prev_char:sub(#opts.prev_char - 4, #opts.prev_char) .. "<esc>viwU"
  end),
}
--- check ./lua/nvim-autopairs/rules/basic.lua

npairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string" }, -- it will not add pair on that treesitter node
    javascript = { "template_string" },
    java = false, -- don't check treesitter on java
  },
}

require("nvim-treesitter.configs").setup {
  autopairs = { enable = true },
}

local ts_conds = require "nvim-autopairs.ts-conds"

-- press % => %% is only inside comment or string
npairs.add_rules {
  Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
  Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
}
