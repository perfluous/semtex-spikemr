-- ~/Projects/semtex/semtex_spikemr/lua/semtex_spikemr/copy_file_paths_to_clipboard.lua
local M = {}
local clipboard = require("semtex_spikemr.clipboard")

function M.copy_file_paths_to_clipboard(file_contents)
	local joined_contents = table.concat(file_contents, "\n\n")
	clipboard.set_clipboard_content(joined_contents)
	vim.notify("Joined contents for clipboard:\n" .. joined_contents, vim.log.levels.DEBUG)
end

return M
