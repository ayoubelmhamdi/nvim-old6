-- clipboard
require("neoclip").setup {
  history = 1000,
  filter = nil,
  preview = false,
  default_register = '"',
  content_spec_column = false,
  on_paste = { set_reg = false },
  keys = {
    i = { select = "<c-k>", paste = "<cr>", paste_behind = "<c-p>" },
    n = { select = "<cr>", paste = "p", paste_behind = "P" },
  },
}

require("telescope").load_extension "neoclip"
