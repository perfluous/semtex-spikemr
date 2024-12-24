-- ~/Projects/semtex/semtex_spikemr/lua/semtex_spikemr/validate_repo_path.lua
local M = {}

function M.validate_repo_path(repo_path)
	local stat = vim.loop.fs_stat(repo_path)
	if not stat or stat.type ~= "directory" then
		return false, "Error: The provided path is not a valid directory."
	end

	-- Check .git directory
	local git_dir = repo_path .. "/.git"
	local git_stat = vim.loop.fs_stat(git_dir)
	if not git_stat or git_stat.type ~= "directory" then
		return false, "Error: The directory is not a valid Git repository."
	end

	return true, nil
end

return M
