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
    tmpl = function(path, bufnr)
      -- Strip Chezmoi prefixes (dot_, executable_) and suffix (.tmpl)
      local clean_path = path:gsub("dot_", "."):gsub("executable_", ""):gsub("%.tmpl$", "")

      -- Query Neovim's filetype registry using the sanitized path
      local ft = vim.filetype.match({ filename = clean_path, buf = bufnr })

      -- Fall back to matching just the basename if full path matching returns nil
      if not ft then
        local filename = clean_path:match("[^/]+$")
        if filename then
          ft = vim.filetype.match({ filename = filename })
        end
      end

      return ft or "gotmpl"
    end,
  },
})
