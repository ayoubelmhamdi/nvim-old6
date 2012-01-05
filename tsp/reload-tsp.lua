local M = {}

M.reloader = function()
  local RELOAD = require("plenary.reload").reload_module
  RELOAD "plenary"
  RELOAD "popup"
  RELOAD "telescope"
end
return M
