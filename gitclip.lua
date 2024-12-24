-- ~/Projects/semtex/semtex_spikemr/lua/semtex_spikemr/gitclip.lua
local M = {}
local validate_repo_path = require("semtex_spikemr.validate_repo_path")
local get_tracked_files = require("semtex_spikemr.get_tracked_files")
local process_files = require("semtex_spikemr.process_files")
local copy_file_paths_to_clipboard = require("semtex_spikemr.copy_file_paths_to_clipboard")

function M.run(repo_path, include_hidden, paths_only, file_paths)
	if repo_path == "" then
		vim.notify("Error: Missing repo path argument", vim.log.levels.ERROR)
		return
	end
	vim.notify("Repo path: " .. repo_path, vim.log.levels.INFO)

	-- If --file-paths specified
	if file_paths and #file_paths > 0 then
		vim.notify("Copying file paths: " .. vim.inspect(file_paths), vim.log.levels.INFO)
		copy_file_paths_to_clipboard.copy_file_paths_to_clipboard(file_paths)
		vim.notify("File paths copied to clipboard successfully.", vim.log.levels.INFO)
		return
	end

	-- Validate the repository path
	local valid, err = validate_repo_path.validate_repo_path(repo_path)
	if not valid then
		vim.notify(err, vim.log.levels.ERROR)
		return
	end

	-- Get tracked files
	local tracked_files, err = get_tracked_files.get_tracked_files(repo_path, include_hidden)
	if err then
		vim.notify(err, vim.log.levels.ERROR)
		return
	end
	vim.notify("Tracked files: " .. vim.inspect(tracked_files), vim.log.levels.DEBUG)

	if paths_only then
		vim.notify("Copying file paths to clipboard...", vim.log.levels.INFO)
		copy_file_paths_to_clipboard.copy_file_paths_to_clipboard(tracked_files)
		vim.notify("Tracked file paths copied to clipboard successfully.", vim.log.levels.INFO)
	else
		vim.notify("Copying file contents to clipboard...", vim.log.levels.INFO)
		local file_contents = process_files.process_files(repo_path, tracked_files, true)
		vim.notify("File contents: " .. vim.inspect(file_contents), vim.log.levels.DEBUG)
		copy_file_paths_to_clipboard.copy_file_paths_to_clipboard(file_contents)
		vim.notify("File contents copied to clipboard successfully.", vim.log.levels.INFO)
	end
end

return M
