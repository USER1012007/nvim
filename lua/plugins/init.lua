return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
	{
		"mg979/vim-visual-multi",
		enabled = true,
		lazy = false,
		init = function()
			vim.g.VM_maps = {
				["Find Under"] = "<C-x>",
				["Find Subword Under"] = "<C-X>",
			}
		end,
	},
  {
    "sbdchd/neoformat",
    lazy = false,
    keys = {
      { "<leader>m", "<cmd>Neoformat<CR>", desc = "Format with Neoformat" },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    'github/copilot.vim',
    lazy = false,
    enabled = true,
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.keymap.set('i', '<C-a>', 'copilot#Accept("\\<CR>")', {
        silent = true,
        expr = true,
        replace_keycodes = false,
        desc = "Copilot: Accept suggestion"
      })
      vim.keymap.set('i', '<C-e>', '<cmd>Copilot dismiss<CR>', {
        silent = true,
        desc = "Copilot: Dismiss suggestion"
      })
      vim.keymap.set('i', '<C-i>', '<cmd>Copilot panel<CR>', {
        silent = true,
        desc = "Copilot: Open suggestion panel"
      })
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      
      local config = {
        cmd = {
          "jdtls",
          "-data", vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
        },
        root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "pom.xml", "build.gradle"}),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            completion = {
              favoriteStaticMembers = {
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.Assert.*",
              },
            },
          },
        },
        on_attach = function(client, bufnr)
          jdtls.setup_dap({ hotcodereplace = "auto" })
          
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      }
      
      jdtls.start_or_attach(config)
    end,
  },
  {
    'ravsii/timers.nvim',
    version = "*",
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    enabled = true,
    opts = {
      sections = {
        lualine_z = {
          { function() return require("timers.integrations.lualine").closest_timer() end },
          { 'progress' },
        },
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("user.colors").setup()
    end,
  },
}
