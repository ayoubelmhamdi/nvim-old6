vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.o.background = "dark"
vim.cmd "colorscheme gruvbox"

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



-- tlggle betwin fr and ang and non
-- " nnoremap <F6> :setlocal! spell! spelllang=en,fr<cr>

-- X = 0
-- vim.keymap.set("n", "<F6>", function()
--     if X == 0 then
--         vim.cmd [[ nnoremap <F6> :setlocal! spell spelllang=en<cr> ]]
--                     call nvim_feedkeys(key, 'n', v:false)
--
--         X = 1
--     elseif X == 1 then
--         vim.cmd [[ nnoremap <F6> :setlocal! spell spelllang=fr<cr> ]]
--         X = 2
--     else
--         vim.cmd [[ nnoremap <F6> :setlocal! nospell<cr> ]]
--         X = 0
--     end
-- end)
