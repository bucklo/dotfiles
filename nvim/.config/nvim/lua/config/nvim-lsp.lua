local M = {}

M.setup = function()
    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    -- Update the capabilities of the LSP client for nvim-cmp
    M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M

