require("lspconfig").clangd.setup {
  autostart = false,
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = { allow_incremental_sync = false },
  cmd = {
    "clangd",
    "--background-index",
    "--cross-file-rename",
    "--header-insertion=iwyu",
    "--completion-style=bundled",
    "--malloc-trim",
  },
  -- vim.lsp.diagnostic.disable(),
  -- capabilities = require("lsp").capabilities,
}
