local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

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
