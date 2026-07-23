return {
  "nvim-mini/mini.hipatterns",
  recommended = true,
  desc = "Highlight colors in your code. Also includes Tailwind CSS support.",
  event = "LazyFile",
  opts = function()
    local hi = require("mini.hipatterns")

    -- Helper to compute the foreground color
    local function compute_fg(hex)
      return hi.compute_hex_color_group(hex, "fg")
    end

    -- Shared extmark options for our right-aligned squares
    local right_square_opts = function(_, _, data)
      return {
        virt_text = { { " ■", data.hl_group } },
        virt_text_pos = "inline",
        priority = 2000,
      }
    end

    return {
      tailwind = {
        enabled = true,
        ft = {
          "astro",
          "css",
          "heex",
          "html",
          "html-eex",
          "javascript",
          "javascriptreact",
          "rust",
          "svelte",
          "typescript",
          "typescriptreact",
          "vue",
        },
        style = "compact",
      },
      highlighters = {
        -- 8-digit hex (#RRGGBBAA)
        hex_color_8 = {
          -- The ()() captures the exact end of the string for the extmark
          pattern = "#%x%x%x%x%x%x%x%x()()%f[^%x%w]",
          group = function(_, _, data)
            -- Strip the alpha channel (last two chars) to prevent Neovim highlight errors
            local base_hex = data.full_match:sub(1, 7)
            return compute_fg(base_hex)
          end,
          extmark_opts = right_square_opts,
        },
        -- 6-digit hex (#RRGGBB)
        hex_color_6 = {
          pattern = "#%x%x%x%x%x%x()()%f[^%x%w]",
          group = function(_, _, data)
            return compute_fg(data.full_match)
          end,
          extmark_opts = right_square_opts,
        },
        -- 4-digit hex shorthand (#RGBA)
        hex_color_4 = {
          pattern = "#%x%x%x%x()()%f[^%x%w]",
          group = function(_, _, data)
            local match = data.full_match
            -- Ignore the A, expand the R, G, and B
            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
            local hex_color = "#" .. r .. r .. g .. g .. b .. b
            return compute_fg(hex_color)
          end,
          extmark_opts = right_square_opts,
        },
        -- 3-digit hex shorthand (#RGB)
        hex_color_3 = {
          pattern = "#%x%x%x()()%f[^%x%w]",
          group = function(_, _, data)
            local match = data.full_match
            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
            local hex_color = "#" .. r .. r .. g .. g .. b .. b
            return compute_fg(hex_color)
          end,
          extmark_opts = right_square_opts,
        },
      },
    }
  end,
}
