-- ~/Projects/semtex/semtex_spikemr/lua/semtex_spikemr/get_tracked_files.lua
local M = {}

function M.get_tracked_files(repo_path, include_hidden)
	local cmd = { "git", "-C", repo_path, "ls-files" }
	local handle = io.popen(table.concat(cmd, " "))
	if not handle then
		return nil, "Failed to run git ls-files."
	end
	local result = handle:read("*a")
	handle:close()

	local files = {}
	for line in string.gmatch(result, "[^\r\n]+") do
		if include_hidden or not line:match("^%.") then
			table.insert(files, line)
		end
	end

	return files, nil
end

return M
