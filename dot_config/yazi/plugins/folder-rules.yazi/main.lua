local function in_folder(url, name)
	-- Convert path to lowercase string and normalize all Windows/Unix slashes to '/'
	local path = tostring(url):lower():gsub("\\", "/")

	-- Append a trailing slash to ensure uniform directory boundary matching
	if path:sub(-1) ~= "/" then
		path = path .. "/"
	end

	-- Use plain text search (true flag) to find '/foldername/' anywhere in the path
	return path:find("/" .. name:lower() .. "/", 1, true) ~= nil
end

local function setup()
	ps.sub("ind-sort", function(opt)
		local cwd = cx.active.current.cwd

		if in_folder(cwd, "Downloads") then
			-- Applies to Downloads and all subfolders inside it
			opt.by, opt.reverse, opt.dir_first = "mtime", true, false
		elseif in_folder(cwd, "Pictures") then
			-- Applies to Pictures and all subfolders inside it
			opt.by, opt.reverse, opt.dir_first = "extension", false, true
		else
			-- MANDATORY FALLBACK: You must explicitly define your default
			-- sorting rules here to reset the tab when you leave a custom folder.
			opt.by, opt.reverse, opt.dir_first = "natural", false, true
		end
	end)
end

return { setup = setup }
