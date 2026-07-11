-- lua/configs/lspconfig.lua

local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

-- LSP: Configuración de Diagnósticos
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- CLANGD: LSP para C/C++
vim.lsp.config("clangd", {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--header-insertion=never',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    '.git',
  },
})

-- RUST-ANALYZER: LSP para Rust
vim.lsp.config("rust_analyzer", {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = true,
      check = {
        command = "clippy",
      },
      procMacro = { enable = true },
    },
  },
})

-- GOPLS: LSP para Go (Golang)
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
})

-- PYRIGHT: LSP para Python
vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
      },
    },
  },
})

vim.lsp.enable({ "clangd", "rust_analyzer", "gopls", "pyright" })
