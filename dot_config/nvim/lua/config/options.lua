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

      -- Explicit override for shell scripts to guarantee the bash parser attaches
      if clean_path:match("%.sh$") then
        return "sh", function(b)
          vim.b[b].is_bash = 1
        end
      end

      -- Capture both the filetype and the required setup callback
      local ft, on_detect = vim.filetype.match({ filename = clean_path, buf = bufnr })

      if not ft then
        local filename = clean_path:match("[^/]+$")
        if filename then
          ft, on_detect = vim.filetype.match({ filename = filename })
        end
      end

      -- Return both values so Neovim can execute language-specific initialization
      return ft or "gotmpl", on_detect
    end,
  },
})
