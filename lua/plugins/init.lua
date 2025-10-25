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
}
