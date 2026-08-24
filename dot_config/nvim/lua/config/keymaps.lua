-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("i", ";;", "<ESC>", { noremap = false })

-- Cycle spelllang between English and Polish
vim.keymap.set("n", "<leader>uy", function()
  local current_lang = vim.bo.spelllang
  if current_lang == "en_us" then
    vim.opt_local.spelllang = "pl"
    vim.notify("Spellcheck: Polish")
  else
    vim.opt_local.spelllang = "en_us"
    vim.notify("Spellcheck: English")
  end
end, { desc = "Toggle Spell Language" })
