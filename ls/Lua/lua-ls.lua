-- lua server module
USER = vim.fn.expand "$HOME"
-- local sumneko_root_path = "/" .. USER .. "/.cache/lua-language-server"
local sumneko_root_path = USER .. "/.cache/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

require("lspconfig").sumneko_lua.setup {
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  -- on_attach = function() require "lsp_signature".on_attach() end,
  require("lsp_signature").setup { signature_config },
  -- autostart = false,
  flags = { allow_incremental_sync = false },
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      workspace = {
        -- Make the server await for loading Neovim runtime files
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
      diagnostics = { globals = { "vim" } },
    },
  },
}
