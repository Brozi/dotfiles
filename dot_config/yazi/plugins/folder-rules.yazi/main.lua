local function in_folder(url, name)
	local path = tostring(url):lower():gsub("\\", "/")
	if path:sub(-1) ~= "/" then
		path = path .. "/"
	end
	return path:find("/" .. name:lower() .. "/", 1, true) ~= nil
end

local function setup()
	ps.sub("ind-sort", function(opt)
		local cwd = cx.active.current.cwd
		local path_str = tostring(cwd)

		-- Debug notification popup
		ya.notify({
			title = "Folder Rule Triggered",
			content = "Path: " .. path_str,
			timeout = 2.0,
		})

		if in_folder(cwd, "Downloads") then
			opt.by, opt.reverse, opt.dir_first = "mtime", true, false
		elseif in_folder(cwd, "Pictures") then
			opt.by, opt.reverse, opt.dir_first = "extension", false, true
		else
			opt.by, opt.reverse, opt.dir_first = "natural", false, true
		end
	end)
end

return { setup = setup }
