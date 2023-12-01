
-- lua/config/lsp-config.lua

local M = {}

M.setup = function()
    require "lspconfig".pyright.setup{}
		require "lspconfig".gopls.setup{}
		require "lspconfig".bashls.setup{}
end

return M

