local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    cs = { "csharpier" },
    go = { "goimports", "gofumpt", "gofmt", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    java = { "google-java-format" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "jq", "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    nix = { "nixfmt", "alejandra", stop_after_first = true },
    php = { "pint", "php_cs_fixer", "pretty-php", stop_after_first = true },
    python = { "ruff_format", "black", "autopep8", stop_after_first = true },
    rust = { "rustfmt", lsp_format = "fallback" },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
}

return options
