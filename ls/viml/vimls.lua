require("lspconfig").vimls.setup {
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = { allow_incremental_sync = false },
}
