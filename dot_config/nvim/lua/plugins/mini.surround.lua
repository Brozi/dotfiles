return {
  {
    "nvim-mini/mini.surround",
    lazy = false,
    opts = {
      mappings = {
        -- Internal mappings, kept away from the visible WhichKey menu.
        delete = "gsD",
        find = "gs>",
        find_left = "gs<",
        highlight = "gsH",
        replace = "gsR",
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)

      local function alias(mode, lhs, target, desc)
        local source = vim.fn.maparg(target, mode, false, true)

        vim.keymap.set(mode, lhs, source.callback, {
          desc = desc,
          expr = source.expr == 1,
        })
      end

      alias("n", "gsdd", "gsD", "Delete current surrounding")
      alias("n", "gsdl", "gsDl", "Delete previous surrounding")
      alias("n", "gsdn", "gsDn", "Delete next surrounding")

      alias("n", "gsrr", "gsR", "Replace current surrounding")
      alias("n", "gsrl", "gsRl", "Replace previous surrounding")
      alias("n", "gsrn", "gsRn", "Replace next surrounding")

      alias("n", "gshh", "gsH", "Highlight current surrounding")
      alias("n", "gshl", "gsHl", "Highlight previous surrounding")
      alias("n", "gshn", "gsHn", "Highlight next surrounding")

      for _, mode in ipairs({ "n", "x", "o" }) do
        alias(mode, "gsff", "gs>", "Find current right surrounding")
        alias(mode, "gsfl", "gs>l", "Find previous right surrounding")
        alias(mode, "gsfn", "gs>n", "Find next right surrounding")

        alias(mode, "gsFF", "gs<", "Find current left surrounding")
        alias(mode, "gsFl", "gs<l", "Find previous left surrounding")
        alias(mode, "gsFn", "gs<n", "Find next left surrounding")
      end
    end,
  },
}
