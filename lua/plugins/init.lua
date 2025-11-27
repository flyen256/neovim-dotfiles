return {
	{
		"folke/lazy.nvim",
		version = "*",
	},
	{
		"mason-org/mason.nvim",
		opts = {}
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "lua_ls", "csharp_ls", "omnisharp" }
			})

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			require("vim.lsp").start({
				name = "typescript",
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx"
				},
				root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				update_in_insert = false,
				underline = true,
				severity_sort = false,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
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
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
	},
	{
		"vim-airline/vim-airline-themes"
	},
	{
		"vim-airline/vim-airline",
		config = function()
			vim.g.airline_powerline_fonts = 1
		end,
	},
	{
		"terryma/vim-multiple-cursors",
	},
	{
		"majutsushi/tagbar",
	},
	{
		"ap/vim-css-color",
	},
	{
		"tc50cal/vim-terminal",
	},
	{
		"ryanoasis/vim-devicons",
		config = function()
			vim.g.webdevicons_enable = 1
			vim.g.webdevicons_enable_nerdtree = 0 -- Отключаем для NERDTree, т.к. не используем
			vim.g.webdevicons_enable_airline_tabline = 1
			vim.g.webdevicons_enable_airline_statusline = 1
			vim.g.webdevicons_enable_unity = 1
			vim.g.webdevicons_enable_ctrlp = 0
			
			-- Настройки для nvim-tree
			vim.g.webdevicons_enable_nvim_tree = 1
			
			-- Дополнительные настройки иконок
			vim.g.WebDevIconsUnicodeDecorateFolderNodes = 1
			vim.g.DevIconsEnableFoldersOpenClose = 1
			vim.g.WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
			vim.g.WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
		end,
	},
	{
		"rafi/awesome-vim-colorschemes",
	},
	{
		"tpope/vim-commentary",
	},
	{
		"tpope/vim-surround",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"wakatime/vim-wakatime",
	},
	{
		"jackguo380/vim-lsp-cxx-highlight",
	},
	{
		"vyfor/cord.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua", "vim", "vimdoc", "query",
					"c", "cpp", "typescript", "javascript", "python", "c_sharp"
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{
		"adelarsq/neofsharp.vim",
		ft = "cs"
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- Добавьте это как зависимость
			"ryanoasis/vim-devicons"
		},
		config = function()
			require("nvim-tree").setup({
				view = {
						side = "left",           -- Фиксировать слева
						width = 40,
						float = {
								enable = false,      -- Отключить плавающий режим
						},
				},
				tab = {
						sync = {
								open = false,        -- Не открывать новую вкладку для nvim-tree
								close = false,       -- Не закрывать при закрытии вкладки
						},
				},
				renderer = {
					icons = {
						glyphs = {
							default = "",
							symlink = "",
							folder = {
								arrow_open = "",
								arrow_closed = "",
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
								symlink_open = "",
							},
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "★",
								deleted = "",
								ignored = "◌"
							}
						},
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						}
					}
				},
				filters = {
					dotfiles = false,
					custom = { 
						"^.git$", "^.svn$", "^.vs$", 
						"^Library$", "^Temp$", "^Build$", 
            "^.vscode$", "^.idea$", "^.csproj$",
            "^.*\\.meta$", "^.*\\.asset$", "^.*\\.inputactions$",
            "^.*\\.csproj$", "^.*\\.DotSettings$", "^.*\\.log$",
            "^.*\\.unity$", "^.*\\.prefab$", "^.*\\.mat$", "^.*\\.shadergraph$",
            "^UserSettings$", "^ProjectSettings$",
            "^Packages$",
						"^obj$", "^Logs$", "^MemoryCaptures$"
					},
				},
			})
		end
	},
	{
		"voldikss/vim-floaterm",
		config = function()
			vim.g.floaterm_width = 0.8
			vim.g.floaterm_height = 0.8
		end,
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.1.9",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						".git",
					},
				},
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			vim.cmd("colorscheme gruvbox")
		end,
	},
  {
  "apyra/nvim-unity-sync",
    lazy = false,
    config = function()
      require("unity.plugin").setup()
    end,
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
    end,
  },
	{ 'echasnovski/mini.nvim', version = false },
	{ 'echasnovski/mini.move', version = false },
	{ 'echasnovski/mini.pairs', version = false },
	{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
	{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
}
