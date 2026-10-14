local function in_folder(cwd_url, target_name)
	local path = tostring(cwd_url):lower():gsub("\\", "/")
	if path:sub(-1) ~= "/" then
		path = path .. "/"
	end
	return path:find("/" .. target_name:lower() .. "/", 1, true) ~= nil
end

local function setup()
	ps.sub("ind-sort", function(opt)
		local cwd = cx.active.current.cwd

		if in_folder(cwd, "Downloads") then
			-- Modyfikujemy obiekt opt dla spójności
			opt.by, opt.reverse, opt.dir_first = "mtime", true, false
			-- Wymuszamy sortowanie z użyciem API Yazi
			ya.emit("sort", { "mtime", reverse = true, dir_first = false })
		elseif in_folder(cwd, "Pictures") then
			opt.by, opt.reverse, opt.dir_first = "extension", false, true
			ya.emit("sort", { "extension", reverse = false, dir_first = true })
		else
			opt.by, opt.reverse, opt.dir_first = "natural", false, true
			ya.emit("sort", { "natural", reverse = false, dir_first = true })
		end
	end)
end

return { setup = setup }
