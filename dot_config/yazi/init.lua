require("full-border"):setup({
	type = ui.Border.ROUNDED,
})
require("git"):setup({
	-- Order of status signs showing in the linemode
	order = 1500,
})
-- Relative motions plugin
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true, enter_mode = "first" })
