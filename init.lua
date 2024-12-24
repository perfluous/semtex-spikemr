-- ~/Projects/semtex/semtex_spikemr/lua/semtex_spikemr/init.lua
local M = {}

-- Require the modules
local display_help = require("semtex_spikemr.display_help")
local validate_repo_path = require("semtex_spikemr.validate_repo_path")
local get_tracked_files = require("semtex_spikemr.get_tracked_files")
local prcess_files = require("semtex_spikemr.process_files")
local copy_file_paths_to_clipboard = require("semtex_spikemr.copy_file_paths_to_clipboard")
local gitclip = require("semtex_spikemr.gitclip")

-- We create a user command that mimics the argument behavior
vim.api.nvim_create_user_command("Gitclip", function(opts)
	local args = vim.split(opts.args, " ")
	-- Parse arguments like the Rust `clap` did
	-- Expected arguments:
	-- :Gitclip <repo_path> [--include-hidden] [--paths-only] [--file-paths <files>]

	if #args == 0 then
		vim.notify("Error: Missing repo path argument", vim.log.levels.ERROR)
		return
	end

	local repo_path = args[1] or ""
	local include_hidden = false
	local paths_only = false
	local file_paths = {}
	local show_help = false

	-- Parse remaining args
	local i = 2
	while i <= #args do
		local arg = args[i]
		if arg == "--help" or arg == "-h" then
			show_help = true
		elseif arg == "--include-hidden" then
			include_hidden = true
		elseif arg == "--paths-only" then
			paths_only = true
		elseif arg == "--file-paths" then
			-- The rest of the arguments after --file-paths are file paths
			for j = i + 1, #args do
				table.insert(file_paths, args[j])
			end
			break
		end
		i = i + 1
	end

	if show_help then
		display_help.display_help()
		return
	end

	-- Run the main logic
	gitclip.run(repo_path, include_hidden, paths_only, file_paths)
end, { nargs = "*" })

return M
