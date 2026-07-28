return {
  "chrisgrieser/nvim-spider",
  opts = {
    skipInsignificanPunctuation = false,
    subwordMovement = true,
    consistentOperatorPending = false,
  },
  keys = {
    {
      "w",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "x" },
      desc = "Move to start of the next word",
    },
    {
      "e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "x" },
      desc = "Move to the end of the word",
    },
    {
      "b",
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "x" },
      desc = "Move to the start of the previous word",
    },
  },
}
