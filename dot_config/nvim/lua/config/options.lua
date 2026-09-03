-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- set basedpyright and ruff as default language server
-- and linter
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

-- disable mouse support for nvim
vim.opt.mouse = ""

vim.opt.spelllang = "en_us"
-- set spelllang
vim.opt.spell = false
-- enable spellchecking
vim.opt.wrap = true
-- enable line wrapping
vim.opt.linebreak = true -- Wraps visually at words, not at strict character limits
-- add persistance for spellchecking
vim.opt.sessionoptions:append("localoptions")

-- data science options
-- vim.env.JUPYTER_RUNTIME_DIR = vim.fn.expand("~/.local/share/jupyter/runtime")
-- vim.env.PYDEVD_DISABLE_FILE_VALIDATION = "1"
