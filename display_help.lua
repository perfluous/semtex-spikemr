-- ~/Projects/semtex/semtex_spikemr/lua/semtex_spikemr/display_help.lua
local M = {}

function M.display_help()
	local lines = {
		"Usage: Gitclip [OPTION] <repo_path>",
		"-h, --help             display this help and exit",
		"--include-hidden       include hidden files in the output",
		"--paths-only           only copy file paths to the clipboard",
		"--file-paths <files>   copy specific file paths to the clipboard",
	}
	for _, line in ipairs(lines) do
		vim.notify(line, vim.log.levels.INFO)
	end
end

return M
