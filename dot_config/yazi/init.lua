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

-- 2. Wrap the plugin's number rendering method
ya.sync(function()
	-- Store the original function created by the plugin
	local old_entity_number = Entity.number

	-- Redefine it to intercept the returned span
	Entity.number = function(self, index, total, file, hovered)
		-- Call the original plugin function to preserve its formatting and local variables
		local span = old_entity_number(self, index, total, file, hovered)

		-- Emulate the plugin's hover check
		if hovered == index then
			-- Override the highlighted background by forcing a custom style.
			-- Adjust the hex code to match the standard unselected text color of your terminal.
			-- If your terminal inherits backgrounds aggressively, you may also need to append :bg("#your_bg_hex")
			return span:style(ui.Style():fg("#888888"))
		end

		return span
	end
end)()
