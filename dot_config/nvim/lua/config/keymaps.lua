-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("i", ";;", "<ESC>", { noremap = false })

-- Bind ce to cw in order to preserve cw's default behaviour
-- While using nvim spider
vim.keymap.set("n", "cw", "c<cmd>lua require('spider').motion('e')<CR>")
