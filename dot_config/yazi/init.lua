-- rounded border
require("full-border"):setup({
	type = ui.Border.ROUNDED,
})
-- Order of status signs showing in the linemode
require("git"):setup({
	order = 1500,
})
-- update zoxides database on yazi cwd
require("zoxide"):setup({
	update_db = true,
})
-- linemode-plus configuration
require("linemode-plus"):setup({
	-- Date formatting mode
	-- Available options:
	--   "default" - Yazi's native format with conditional year display:
	--               • For current year:     "MM/DD HH:mm"
	--               • For other years:      "MM/DD  YYYY"
	--
	--   "custom"  - smart user-defined format with today detection:
	--               • For today's files:     "HH:mm" (time only)
	--               • For older files:       Custom date format from 'custom' table
	--                 (configurable order, separator and year digits)
	date_mode = "custom",
	-- Custom format settings (only used when mode = "custom")
	custom = {
		-- Date components order
		-- MUST contain all three components: "year", "month", "day"
		-- Each component must appear exactly once (no duplicates)
		--
		-- All valid examples:
		--   { "year", "month", "day" }     -- year → month → day
		--   { "year", "day", "month" }     -- year → day → month
		--   { "month", "year", "day" }     -- month → year → day
		--   { "month", "day", "year" }     -- month → day → year
		--   { "day", "year", "month" }     -- day → year → month
		--   { "day", "month", "year" }     -- day → month → year
		order = { "day", "month", "year" },

		-- Separator between date components
		-- Allowed separators: "-", "/", "."  (only these characters are supported)
		--
		-- Examples:
		--   "-" -> 2026-02-20
		--   "/" -> 2026/02/20
		--   "." -> 2026.02.20
		separator = "/",

		-- Number of digits for the year:
		--   4 -> 2026 (full year)
		--   2 -> 26   (short year)
		year_digits = 4,
	},
})
-- relative motions config
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true, enter_mode = "first" })

-- 1. Initialize the plugin first
require("relative-motions"):setup({
	show_numbers = "relative",
	-- any other configuration options you use
})

local old_entity_number = Entity.number

Entity.number = function(self, index, total, file, hovered)
	local span = old_entity_number(self, index, total, file, hovered)

	if hovered == index then
		-- Apply only the background reset so the text inherits your default terminal color
		return span:style(ui.Style():bg("reset"))
	end

	return span
end
