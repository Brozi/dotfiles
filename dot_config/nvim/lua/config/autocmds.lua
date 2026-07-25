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
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ChezmoiAsyncCommit", { clear = true }),
  pattern = {
    vim.env.HOME .. "/.local/share/chezmoi/*",
    vim.env.HOME .. "/.local/share/chezmoi/**/*",
  },
  callback = function(args)
    local filepath = args.match
    local filename = vim.fn.fnamemodify(filepath, ":t")
    local msg = "Update " .. filename

    -- 1. Apply changes asynchronously
    vim.system({ "chezmoi", "apply", "--source-path", filepath }, {}, function(apply_out)
      if apply_out.code ~= 0 then
        return
      end
      -- 2. Stage the file
      vim.system({ "chezmoi", "git", "--", "add", filepath }, {}, function(add_out)
        if add_out.code ~= 0 then
          return
        end
        -- 3. Commit the file
        vim.system({ "chezmoi", "git", "--", "commit", "-m", msg }, {}, function(commit_out)
          if commit_out.code ~= 0 then
            return
          end
          -- Notify the user that the push is starting
          vim.schedule(function()
            vim.notify("Chezmoi: Pushing " .. filename .. " in background...", vim.log.levels.INFO)
          end)
          -- 4. Push to remote
          vim.system({ "chezmoi", "git", "--", "push" }, {}, function(push_out)
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
