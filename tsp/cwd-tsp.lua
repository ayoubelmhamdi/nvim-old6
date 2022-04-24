local M = {}

M.search_dotfiles = function()
  Prequire("telescope.builtin").find_files {
    prompt_title = "< Dotfiles > ",
    hidden = true,
    cwd = "/root/stow-dotfiles",
    file_ignore_patterns = { "git/", ".github/", ".gitignore", ".fonts", "themepack/" },
  }
end

-- nvimdir config
M.search_nvim = function()
  Prequire("telescope.builtin").find_files {
    prompt_title = "< NVIM > ",
    hidden = true,
    cwd = "/root/.config/nvim/lua",
    file_ignore_patterns = { "git/", ".gitignore" },
  }
end

-- project
M.search_proj = function(proj)
  Prequire("telescope.builtin").find_files {
    prompt_title = "< " .. proj .. ">",
    hidden = true,
    cwd = "/projects/c/" .. proj,
    file_ignore_patterns = { "git/", ".gitignore", "%.o", "^slstatus$" },
  }
end

M.search_wiki = function()
  Prequire("telescope.builtin").find_files {
    prompt_title = "< NVIM > ",
    hidden = true,
    cwd = "/mega/repo/wiki",
    file_ignore_patterns = { "git/", ".gitignore" },
  }
end

M.search_proj2 = function(proj)
  Prequire("telescope.builtin").find_files {
    prompt_title = "< " .. proj .. ">",
    hidden = true,
    cwd = proj,
    file_ignore_patterns = { "git/", ".gitignore", "%.o", "^slstatus$" },
  }
end


return M
