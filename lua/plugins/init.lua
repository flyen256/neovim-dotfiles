return {
  -- Package manager
  {
    "folke/lazy.nvim",
    version = "*",
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "tsserver", "lua_ls" }
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Clangd for C/C++
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      -- TypeScript/JavaScript
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })

      -- Lua
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

      -- Global keymaps and diagnostics
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

  -- Autocompletion
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

  -- Mason - LSP manager
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },

  -- File explorer
  {
    "scrooloose/nerdtree",
    config = function()
      -- NERDTree configuration can go here
    end,
  },

  -- Status line
  {
    "vim-airline/vim-airline",
    config = function()
      -- Optional: Configure vim-airline here, e.g., enable powerline fonts
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_theme = 'base16_tomorrow' -- Example theme
    end,
  },

  -- Multiple cursors
  {
    "terryma/vim-multiple-cursors",
  },

  -- Tagbar
  {
    "majutsushi/tagbar",
  },

  -- CSS color highlighter
  {
    "ap/vim-css-color",
  },

  -- Terminal
  {
    "tc50cal/vim-terminal",
  },

  -- Icons
  {
    "ryanoasis/vim-devicons",
    config = function()
      vim.g.webdevicons_enable = 1
      vim.g.webdevicons_enable_nerdtree = 1
      vim.g.webdevicons_enable_airline_tabline = 1
      vim.g.webdevicons_enable_airline_statusline = 1
    end,
  },

  -- Colorschemes
  {
    "rafi/awesome-vim-colorschemes",
  },

  -- Commenting
  {
    "tpope/vim-commentary",
  },

  -- Surround
  {
    "tpope/vim-surround",
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Wakatime
  {
    "wakatime/vim-wakatime",
  },

  -- C++ highlighting (replaces vim-lsp-cxx-highlight)
  {
    "jackguo380/vim-lsp-cxx-highlight",
  },

  -- Cord colorscheme
  {
    "vyfor/cord.nvim",
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "lua", "vim", "vimdoc", "query", 
          "c", "cpp", "typescript", "javascript", "python" 
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

  -- Floating terminal
  {
    "voldikss/vim-floaterm",
    config = function()
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
    end,
  },

  -- Plenary (dependency for Telescope)
  {
    "nvim-lua/plenary.nvim",
  },

  -- Telescope
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

  -- Cobalt colorscheme
  {
    "github-main-user/lytmode.nvim",
    config = function()
      -- If you want to use the colorscheme directly in Lua:
      vim.cmd("colorscheme lytmode")
    end,
  },
}