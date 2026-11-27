return {
  {
    "sheng-tse/jupynvim",
    lazy = false,
    build = function(plugin)
      local install = loadfile(plugin.dir .. "/lua/jupynvim/install.lua")()
      install.run(plugin)
    end,
    opts = {
      log_level = "info",
    },
    config = function(_, opts)
      require("jupynvim").setup(opts)

      local ok, wk = pcall(require, "which-key")
      if ok then
        wk.add({
          {
            "<leader>j",
            group = "jupyter",
            cond = function()
              return vim.fn.expand("%:e") == "ipynb"
            end,
          },
        })
      end

      local function map_notebook_keys(buf)
        if vim.b[buf].jupynvim_keys_set then
          return
        end
        vim.b[buf].jupynvim_keys_set = true

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
        end

        map({ "n", "i" }, "<S-CR>", "<cmd>JupynvimRunAndNext<cr>", "Run cell and advance")
        map("n", "<leader>jr", "<cmd>JupynvimRunCell<cr>", "Run current cell")
        map("n", "<leader>jn", "<cmd>JupynvimRunAndNext<cr>", "Run cell and move next")
        map("n", "<leader>ja", "<cmd>JupynvimRunAll<cr>", "Run all cells")
        map("n", "<leader>ju", "<cmd>JupynvimRunAbove<cr>", "Run cells above")
        map("n", "<leader>jk", "<cmd>JupynvimSelectKernel<cr>", "Select kernel")
        map("n", "<leader>ji", "<cmd>JupynvimInterruptKernel<cr>", "Interrupt kernel")
        map("n", "<leader>jR", "<cmd>JupynvimRestartKernel<cr>", "Restart kernel")
        map("n", "<leader>jo", "<cmd>JupynvimInsertCellBelow<cr>", "Insert cell below")
        map("n", "<leader>jO", "<cmd>JupynvimInsertCellAbove<cr>", "Insert cell above")
        map("n", "<leader>jd", "<cmd>JupynvimDeleteCell<cr>", "Delete cell")
        map("n", "<leader>js", "<cmd>JupynvimSplitCell<cr>", "Split cell at cursor")
        map("n", "<leader>jm", "<cmd>JupynvimToggleCellType<cr>", "Toggle code/markdown")
        map("n", "<leader>jc", "<cmd>JupynvimClearOutput<cr>", "Clear cell output")
        map("n", "<leader>jC", "<cmd>JupynvimClearAllOutputs<cr>", "Clear all outputs")
        map("n", "]c", "<cmd>JupynvimNextCell<cr>", "Next notebook cell")
        map("n", "[c", "<cmd>JupynvimPrevCell<cr>", "Previous notebook cell")
      end

      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("JupynvimBufferKeys", { clear = true }),
        pattern = "*.ipynb",
        callback = function(ev)
          map_notebook_keys(ev.buf)
        end,
      })

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf):match("%.ipynb$") then
          map_notebook_keys(buf)
        end
      end
    end,
  },
}
