-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Force Go template tags to highlight over Tree-sitter in Chezmoi files
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
  pattern = "*.tmpl",
  callback = function()
    -- Clear existing matches to prevent infinite stacking on window switches
    if vim.w.gotmpl_match_id then
      pcall(vim.fn.matchdelete, vim.w.gotmpl_match_id)
      vim.w.gotmpl_match_id = nil
    end
    -- matchadd() renders UI highlights directly on top of Tree-sitter
    -- The regex "{{.\\{-}}}" captures anything between double curly braces
    vim.w.gotmpl_match_id = vim.fn.matchadd("Special", "{{.\\{-}}}")
  end,
})
