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
