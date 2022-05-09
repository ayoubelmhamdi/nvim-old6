local luaf = {
  formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
  formatStdin = true,
}

local eslint = {
  lintCommand = [[eslint_d -f visualstudio --no-color --config config/eslint.cjs --stdin --stdin-filename ${INPUT}]],
  lintFormats = {
    "%f(%l,%c): %tarning %m",
    "%f(%l,%c): %rror %m",
  },
  lintStdin = true,
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --config config/eslint.cjs --fix-to-stdout --stdin --stdin-filename ${INPUT}",
  formatStdin = true,
}

local autopep = { formatCommand = "autopep8 -", formatStdin = true }
local isort = { formatCommand = "isort --quiet -", formatStdin = true }
local black = { formatCommand = "black --quiet -", formatStdin = true }
local yapf = { formatCommand = "yapf --quiet", formatStdin = true }

local clangf = { formatCommand = "clang-format", formatStdin = true }
local latexindent = { formatCommand = "latexindent", formatStdin = true }
local cmakef = { formatCommand = "cmake-format", formatStdin = true }
local prettier = { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true }

local shfmt = { formatCommand = "shfmt -ci -s -bn", formatStdin = true }
local shellcheck = {
  LintCommand = "shellcheck -f gcc -x",
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
}

local markdownf = { formatCommand = "pandoc -f markdown -t gfm -sp --tab-stop=4", formatStdin = true }

Prequire("lspconfig").efm.setup {
  autostart = false,
  cmd = { "efm-langserver" },
  init_options = { documentFormatting = true, codeAction = false },
  filetypes = { "tex", "javascript", "lua", "python", "cpp", "sh", "json", "yaml", "css", "html" },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      cmake = { cmakef },
      cpp = { clangf },
      css = { prettier },
      html = { prettier },
      json = { prettier },
      javascript = { prettier }, --{prettier,eslint},
      lua = { luaf },
      markdown = { markdownf },
      python = { autopep, isort, black, yapf },
      sh = { shellcheck, shfmt }, -- test for best
      tex = { latexindent },
      yaml = { prettier },
    },
  },
}
