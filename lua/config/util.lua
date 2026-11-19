local M = {}

--- Turn a key sequence into Alt-modified keys: alt("ef") -> "<A-e><A-f>"
---@param keys string
---@return string
function M.alt(keys)
	return (keys:gsub(".", "<A-%0>"))
end

return M
