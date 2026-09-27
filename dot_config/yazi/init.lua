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

-- Override relative motions number highlight
-- OVERRIDE: Strip background highlight from relative-motions numbers
Current.redraw = function(self)
	local files = self._folder.window
	if #files == 0 then
		return self:empty()
	end

	local hovered_index
	for i, f in ipairs(files) do
		if f.is_hovered then
			hovered_index = i
			break
		end
	end

	local entities, linemodes = {}, {}
	for i, f in ipairs(files) do
		linemodes[#linemodes + 1] = Linemode:new(f):redraw()

		local entity = Entity:new(f)
		-- Apply the hover style strictly to entity:redraw(), isolating the number
		entities[#entities + 1] = ui.Line({
			Entity:number(i, #self._folder.files, f, hovered_index),
			entity:redraw():style(entity:style()),
		})
	end

	return {
		ui.List(entities):area(self._area),
		ui.Text(linemodes):area(self._area):align(ui.Align.RIGHT),
	}
end
