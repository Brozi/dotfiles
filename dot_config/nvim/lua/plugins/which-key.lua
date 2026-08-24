return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      table.insert(opts.spec, {
        -- Explicitly define the key, its description, and its mode for the menu
        { "<leader>uy", desc = "Cycle Spell Language", mode = "n" },
      })
    end,
  },
}
