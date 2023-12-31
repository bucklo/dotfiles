local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme
    use {
      "folke/tokyonight.nvim",
      config = function()
        vim.cmd "colorscheme tokyonight-moon"
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
			cmd = "Neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }

		-- WhichKey
		use {
			 "folke/which-key.nvim",
			 event = "VimEnter",
			 config = function()
				 require("config.whichkey").setup()
			 end,
		}

		-- IndentLine
		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indentblankline").setup()
			end,
		}

		-- Leap
		use {
			"ggandor/leap.nvim",
			config = function()
				require('leap').add_default_mappings()
			end,
		}

		-- Lualine
		use {
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			config = function()
				require("config.lualine").setup()
			end,
			requires = { "nvim-tree/nvim-web-devicons" },
		}

		-- nvim-navic
		use {
			"SmiteshP/nvim-navic",
			requires = "neovim/nvim-lspconfig"
		}

		-- nvim-tree
		use {
			"kyazdani42/nvim-tree.lua",
			requires = {
			 "kyazdani42/nvim-web-devicons",
			},
			cmd = { "NvimTreeToggle", "NvimTreeClose" },
			 config = function()
				 require("config.nvimtree").setup()
			 end,
		}

		-- fzf
		use { "junegunn/fzf", run = "./install --all" }
		use { "junegunn/fzf.vim" }
		

		-- Buffer line
		use {
			"akinsho/nvim-bufferline.lua",
			event = "BufReadPre",
			wants = "nvim-web-devicons",
			config = function()
				require("config.bufferline").setup()
			end,
		}

		use {
			"hrsh7th/nvim-cmp",
			config = function()
				require("config.nvim-cmp").setup()
			end,
		}

		use { 
			"L3MON4D3/LuaSnip",
			tag = "v2.*",
			build = "make install_jsregexp",
			config = function()
				require("config.luasnip").setup()
			end,
		}

		use {"rafamadriz/friendly-snippets"}
		use {"hrsh7th/cmp-buffer"}
		
		use {
			"hrsh7th/cmp-nvim-lsp",
			config = function()
				require("config.nvim-lsp").setup()
			end,
		}
	
		use {
			"neovim/nvim-lspconfig",
			config = function()
				require("config.lspconfig").setup()
			end,
		}

		use {"hrsh7th/cmp-path"}
		use {"petertriho/cmp-git"}
		
		use {
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup()
			end,
		}
		
		use {
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("mason-lspconfig").setup()
			end
		}

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
