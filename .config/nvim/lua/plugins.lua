local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer itself!
	use("wbthomason/packer.nvim")

	-- Theme: Tokyo Night ('night' variant)
	use({
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup { style = "night",
				transparent = true,
			}
			vim.cmd [[colorscheme tokyonight]]
		end
	})

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup {
				theme = "tokyonight",
				icons_enabled = false,
				sections = {
					lualine_x = {
						"encoding",
						{
							"fileformat",
							symbols = {
								unix = 'lf',
								dos = 'crlf',
								mac = 'cr',
							},
						},
						"filetype",
					},
				},
			}
		end
	})

	-- Comment with 'gc' etc
	use("tomtom/tcomment_vim")

	-- --------------

	-- Programming specific

	-- Treesitter: Highlighting and more
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "c", "lua", "python", "rust" },
				highlight = {
					enable = true,
				},
			}
		end,
	})

	-- Autopairs: Pair brackets
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {}
		end,
	})

	-- surround
	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup {}
		end,
	})

	-- editorconfig (lua/fennel plugin)
	use("gpanders/editorconfig.nvim")

	-- Multi-cursors
	use("mg979/vim-visual-multi")

	-- Fugitive
	use("tpope/vim-fugitive")

	-- Colorizer
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup {}
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end,
	})
	
	-- LSP support
	use("neovim/nvim-lspconfig")

	-- nvim-cmp: Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip", -- Using luasnip as engine
			"hrsh7th/cmp-nvim-lsp", -- Built-in LSP source
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" }, -- Completion with words in buffer
			{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }, -- Call signatures
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					['<C-n>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<C-p>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = {
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
				},
			}

			require('cmp_nvim_lsp').default_capabilities()

			local lsp = require('lspconfig')
			lsp.clangd.setup{
			}
			lsp.rust_analyzer.setup{
			}
		end,
	})

	-- --------------

	if packer_bootstrap then
		require("packer").sync()
	end
end)
