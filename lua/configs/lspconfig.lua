local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

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
          check= {
            command = "clippy",
          },
          procMacro = { enable = true },
        },
      },
      capabilities = nvlsp.capabilities or vim.lsp.protocol.make_client_capabilities(),
    })
  end,
})

vim.lsp.config.clangd = {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
  capabilities = nvlsp.capabilities,
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  callback = function(args)
    local root = vim.fs.root(args.buf, { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' })
    
    if not root then
      root = vim.fn.getcwd()
    end
    
    vim.lsp.start({
      name = 'clangd',
      cmd = { 'clangd' },
      root_dir = root,
      capabilities = nvlsp.capabilities,
    })
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})
