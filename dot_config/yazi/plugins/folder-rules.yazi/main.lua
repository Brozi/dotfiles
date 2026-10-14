local function in_folder(path, name)
	-- Matches exact folder name at the end of path or followed by a directory separator
	return path:find("[/\\]" .. name .. "$") ~= nil or path:find("[/\\]" .. name .. "[/\\]") ~= nil
end

local function setup()
	ps.sub("ind-sort", function(opt)
		local path = tostring(cx.active.current.cwd)

		if in_folder(path, "Pobrane") then
			-- Applies to Downloads and all subfolders inside Downloads
			opt.by, opt.reverse, opt.dir_first = "mtime", true, false
		elseif in_folder(path, "Obrazy") then
			-- Applies to Pictures and all subfolders inside Pictures
			opt.by, opt.reverse, opt.dir_first = "extension", false, true
		end
	end)
end

return { setup = setup }
