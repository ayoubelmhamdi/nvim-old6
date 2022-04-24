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
