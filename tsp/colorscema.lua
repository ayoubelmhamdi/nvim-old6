
local pickers = Prequire("telescope.pickers")
local finders = Prequire("telescope.finders")
local sorters = Prequire("telescope.sorters")

local dropdown = Prequire("telescope.themes").get_dropdown()

local actions = Prequire("telescope.actions")
local action_state = Prequire("telescope.actions.state")

function enter(prompt_bufnr)
    local selected = action_state.get_selected_entry()
    -- print(vim.inspect(selected))
    local cmd = 'colorscheme ' .. selected[1]
    vim.cmd(cmd)
    actions.close(prompt_bufnr)
end

function color_next(prompt_bufnr)
    actions.move_selection_next(prompt_bufnr)
    local selected = action_state.get_selected_entry()
    -- print(vim.inspect(selected))
    local cmd = 'colorscheme ' .. selected[1]
    vim.cmd(cmd)
end


local colors2 = vim.fn.getcompletion("","color")
local opts = {
    -- finder = finders.new_table {"gruvbox", "deus", "blue"},
    finder = finders.new_table(colors2) ,
    sorter = sorters.get_generic_fuzzy_sorter({}),

    attach_mappings = function (prompt_bufnr,map)
            map("i","<CR>", enter)
            map("i","<C-j>", color_next)
        return true
    end
}

colors = pickers.new(dropdown,opts)
colors:find()
