-- lua/config/lsp-config.lua

local M = {}

M.setup = function()
    -- Your LSP server configurations go here
    require'lspconfig'.pyright.setup{}
    -- ... more LSP server setups ...
end

return M

