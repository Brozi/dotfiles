-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Force Go template tags to highlight over Tree-sitter in Chezmoi files

-- vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
--   pattern = "*.tmpl",
--   callback = function()
--     -- Clear existing matches to prevent infinite stacking on window switches
--     if vim.w.gotmpl_match_id then
--       pcall(vim.fn.matchdelete, vim.w.gotmpl_match_id)
--       vim.w.gotmpl_match_id = nil
--     end
--     -- matchadd() renders UI highlights directly on top of Tree-sitter
--     -- The regex "{{.\\{-}}}" captures anything between double curly braces
--     vim.w.gotmpl_match_id = vim.fn.matchadd("Special", "{{.\\{-}}}")
--   end,
-- })
local is_syncing = false

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ChezmoiSafeAsyncCommit", { clear = true }),
  pattern = {
    vim.env.HOME .. "/.local/share/chezmoi/*",
    vim.env.HOME .. "/.local/share/chezmoi/**/*",
  },
  callback = function(args)
    if is_syncing then
      return
    end
    is_syncing = true

    local filepath = args.match
    local filename = vim.fn.fnamemodify(filepath, ":t")
    local msg = "Update " .. filename
    vim.system({ "chezmoi", "apply", "--source-path", filepath }, {}, function(apply_out)
      if apply_out.code ~= 0 then
        is_syncing = false
        return
      end

      vim.system({ "chezmoi", "git", "--", "add", filepath }, {}, function(add_out)
        if add_out.code ~= 0 then
          is_syncing = false
          return
        end

        vim.system({ "chezmoi", "git", "--", "commit", "-m", msg }, {}, function(commit_out)
          if commit_out.code ~= 0 then
            is_syncing = false
            return
          end

          vim.system({ "chezmoi", "git", "--", "push" }, {}, function(push_out)
            is_syncing = false
            vim.schedule(function()
              if push_out.code == 0 then
                vim.notify("Chezmoi: Successfully pushed " .. filename, vim.log.levels.INFO)
              else
                vim.notify("Chezmoi: Push failed for " .. filename, vim.log.levels.ERROR)
              end
            end)
          end)
        end)
      end)
    end)
  end,
})
