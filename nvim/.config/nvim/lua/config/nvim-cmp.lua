local M = {}

M.setup = function()
	--require("cmp").setup {
		local cmp = require("cmp")
		local luasnip = require("luasnip")


		cmp.setup {
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

			mapping = {
				['<C-k>'] = cmp.mapping.select_prev_item(),
				['<C-j>'] = cmp.mapping.select_next_item(),
				['<Tab>'] = cmp.mapping.confirm({ select = true }),
				-- Add additional keybindings here if needed
			},
	}

end

return M
