return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local function wordcount()
        return tostring(vim.fn.wordcount().words) .. " words"
      end

      table.insert(opts.sections.lualine_x, {
        wordcount,
        cond = function()
          return vim.bo.filetype == "markdown" or vim.bo.filetype == "text"
        end,
      })
    end,
  },
}
