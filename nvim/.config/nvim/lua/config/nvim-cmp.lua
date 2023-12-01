local M = {}

M.setup = function()
	require("cmp").setup {
		
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "git" },
		},
	}

end

return M
