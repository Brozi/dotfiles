return {
  -- Add QML Treesitter parser for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "qmljs" })
      end
    end,
  },
  -- Configure QML Language Server for autocomplete and diagnostics
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {
          cmd = { "qmlls" },
          filetypes = { "qml", "qmljs", "qml.js" },
        },
      },
    },
  },
}
