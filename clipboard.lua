-- ~/Projects/semtex/semtex_spikemr/lua/semtex_spikemr/clipboard.lua
local M = {}

function M.set_clipboard_content(content)
	vim.fn.setreg("+", content)
	vim.notify("Clipboard content set.", vim.log.levels.INFO)
end

return M
