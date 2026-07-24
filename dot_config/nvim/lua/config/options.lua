-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Add gotmpl filetype for .tmpl files

vim.filetype.add({
  extension = {
    tmpl = "gotmpl",
  },
  pattern = {
    [".*%.toml%.tmpl"] = "gotmpl",
  },
})

-- Dynamic filetype resolution for Chezmoi templates
vim.filetype.add({
  extension = {
    tmpl = function(path)
      -- Strip Chezmoi prefixes (dot_, executable_) and suffix (.tmpl)
      local clean_path = path:gsub("dot_", "."):gsub("executable_", ""):gsub("%.tmpl$", "")
      -- Run Neovim's built-in filetype detector on the sanitized path
      local ft, _ = vim.filetype.detect(clean_path)
      -- Fall back to gotmpl if Neovim cannot determine the base filetype
      return ft or "gotmpl"
    end,
  },
})
