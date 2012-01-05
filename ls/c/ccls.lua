require("lspconfig").ccls.setup {
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = { allow_incremental_sync = false },
  init_options = {
    cache = { directory = ".ccls-cache" },
    highlight = { lsRanges = true },
    compilationDatabaseDirectory = "build",
    index = { threads = 0 },
    clang = {
      excludeArgs = { "-frounding-math" },
    },
  },
}
