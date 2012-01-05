local M = {}
local action_state = require "telescope.actions.state"

M.gl = function()
  local action_set = require "telescope.actions.set"
  local actions = require "telescope.actions"
  local previewers = require "telescope.previewers"
  return require("telescope.builtin").fd {
    prompt_title = "|> ::foonv:: <|",
    shorten_path = false,
    cwd = "/mega/repo",
    -- previous
    previewer = previewers.new_termopen_previewer {
      get_command = function(selection)
        return { "glow", "/mega/repo/" .. selection.value }
      end,
    },
    -- opener
    attach_mappings = function(prompt_bufnr)
      action_set.select:replace(function(_, cmd)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if cmd == "default" or cmd == "horizontal" then
          vim.cmd("term glow /mega/repo/" .. selection.value)
        elseif cmd == "vertical" then
          vim.cmd("vs | term glow /mega/repo/" .. selection.value)
        end
      end) -- end replace function
      return true -- attach_mappings return true
    end, -- end attach_mappings
  }
end

return M
