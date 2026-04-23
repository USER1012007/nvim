-- lua/configs/lspconfig.lua

local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

-- ════════════════════════════════════════════════════════════════════════
-- TREE-SITTER: Protección contra errores de concealment
-- ════════════════════════════════════════════════════════════════════════
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    -- Deshabilitar concealment para evitar el error
    vim.opt_local.conceallevel = 0
    vim.opt_local.concealcursor = ''
  end,
})

-- ════════════════════════════════════════════════════════════════════════
-- LSP: Configuración de Diagnósticos
-- ════════════════════════════════════════════════════════════════════════
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- ════════════════════════════════════════════════════════════════════════
-- CLANGD: LSP para C/C++
-- ════════════════════════════════════════════════════════════════════════
vim.lsp.config.clangd = {
  cmd = { 
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--header-insertion=never',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = { 
    'compile_commands.json', 
    'compile_flags.txt', 
    '.clangd', 
    '.git' 
  },
  capabilities = nvlsp.capabilities,
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  callback = function(args)
    local root = vim.fs.root(args.buf, { 
      'compile_commands.json', 
      'compile_flags.txt', 
      '.clangd', 
      '.git' 
    }) or vim.fn.getcwd()
    
    vim.lsp.start({
      name = 'clangd',
      cmd = { 'clangd', '--background-index' },
      root_dir = root,
      capabilities = nvlsp.capabilities,
    })
  end,
})

-- ════════════════════════════════════════════════════════════════════════
-- RUST-ANALYZER: LSP para Rust
-- ════════════════════════════════════════════════════════════════════════
vim.lsp.config.rust_analyzer = {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
  capabilities = nvlsp.capabilities,
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function(args)
    local root = vim.fs.root(args.buf, { 'Cargo.toml', 'rust-project.json', '.git' })
    vim.lsp.start({
      name = 'rust_analyzer',
      cmd = { 'rust-analyzer' },
      root_dir = root,
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = true,
          check = {
            command = "clippy",
          },
          procMacro = { enable = true },
        },
      },
      capabilities = nvlsp.capabilities or vim.lsp.protocol.make_client_capabilities(),
    })
  end,
})

-- ════════════════════════════════════════════════════════════════════════
-- GOPLS: LSP para Go (Golang)
-- ════════════════════════════════════════════════════════════════════════
vim.lsp.config.gopls = {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  capabilities = nvlsp.capabilities,
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'gomod', 'gowork', 'gotmpl' },
  callback = function(args)
    local root = vim.fs.root(args.buf, { 'go.work', 'go.mod', '.git' })
    
    vim.lsp.start({
      name = 'gopls',
      cmd = { 'gopls' },
      root_dir = root,
      capabilities = nvlsp.capabilities,
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
  end,
})

-- Formateo automático e importaciones al guardar
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- Organizar importaciones
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
    -- Formatear
    vim.lsp.buf.format({async = false})
  end,
})
