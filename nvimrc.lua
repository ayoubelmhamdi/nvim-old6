vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.o.background = "dark"
vim.cmd('colorscheme gruvbox')

function Prequire(...)
    local status, lib = pcall(require, ...)
    if status then
        return lib
    else
        print(... .. ": not looading")
    end
    return nil
end

Prequire "impatient"


-- Switch between tabs
vim.keymap.set("n", "<Right>", function()
  vim.cmd [[checktime]]
  vim.api.nvim_feedkeys("gt", "n", true)
end)

vim.keymap.set("n", "<Left>", function()
  vim.cmd [[checktime]]
  vim.api.nvim_feedkeys("gT", "n", true)
end)
