local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").find_files {
    prompt_title = "< Dotfiles > ",
    hidden = true,
    cwd = "/root/stow-dotfiles",
    file_ignore_patterns = { "git/", ".github/", ".gitignore", ".fonts", "themepack/" },
  }
end

-- nvimdir config
M.search_nvim = function()
  require("telescope.builtin").find_files {
    prompt_title = "< NVIM > ",
    hidden = true,
    cwd = "/root/.config/nvim",
    file_ignore_patterns = { "git/", ".github/", ".gitignore" },
  }
end

-- project
M.search_proj = function(proj)
  require("telescope.builtin").find_files {
    prompt_title = "< " .. proj .. ">",
    hidden = true,
    cwd = "/projects/c/" .. proj,
    file_ignore_patterns = { "git/", ".github/", ".gitignore", "%.o", "^slstatus$" },
  }
end

M.search_wiki = function()
  require("telescope.builtin").find_files {
    prompt_title = "< NVIM > ",
    hidden = true,
    cwd = "/mega/repo/wiki",
    file_ignore_patterns = { "git/", ".github/", ".gitignore" },
  }
end

return M
