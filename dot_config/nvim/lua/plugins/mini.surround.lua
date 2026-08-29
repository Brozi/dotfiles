return {
  {
    "nvim-mini/mini.surround",
    -- Define all mappings at startup so `gs` behaves consistently.
    lazy = false,
    opts = {
      mappings = {
        delete = "gsdd",
        find = "gsff",
        find_left = "gsFF",
        highlight = "gshh",
        replace = "gsrr",
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)

      local function alias(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { remap = true, desc = desc })
      end

      -- Keep `gsd`, `gsr`, `gsf`, `gsF`, and `gsh` as WhichKey prefixes.
      -- Their second key selects the target: current, previous, or next.
      alias("n", "gsdl", "gsddl", "Delete previous surrounding")
      alias("n", "gsdn", "gsddn", "Delete next surrounding")

      alias("n", "gsrl", "gsrrl", "Replace previous surrounding")
      alias("n", "gsrn", "gsrrn", "Replace next surrounding")

      alias({ "n", "x", "o" }, "gsfl", "gsffl", "Find previous right surrounding")
      alias({ "n", "x", "o" }, "gsfn", "gsffn", "Find next right surrounding")

      alias({ "n", "x", "o" }, "gsFl", "gsFFl", "Find previous left surrounding")
      alias({ "n", "x", "o" }, "gsFn", "gsFFn", "Find next left surrounding")

      alias("n", "gshl", "gshhl", "Highlight previous surrounding")
      alias("n", "gshn", "gshhn", "Highlight next surrounding")
    end,
  },
}
