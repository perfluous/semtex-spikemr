-- ~/Projects/semtex/semtex_spikemr/lua/semtex_spikemr/process_files.lua
local M = {}

local function file_exists(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "file"
end

function M.process_files(repo_path, tracked_files, include_content)
	local file_contents = {}
	for _, file in ipairs(tracked_files) do
		local file_path = repo_path .. "/" .. file
		vim.notify("Processing file: " .. file_path, vim.log.levels.DEBUG)

		if not file_exists(file_path) then
			vim.notify("Error reading file: " .. file_path, vim.log.levels.ERROR)
		else
			if include_content then
				local f = io.open(file_path, "r")
				if f then
					local content = f:read("*a")
					f:close()
					local formatted_content = string.format("%s\n```\n%s\n```", file_path, content)
					table.insert(file_contents, formatted_content)
				else
					vim.notify("Error reading file content: " .. file_path, vim.log.levels.ERROR)
				end
			else
				-- If we're not including content, just push the file path
				table.insert(file_contents, file_path)
			end
		end
	end
	return file_contents
end

return M
