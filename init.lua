vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

vim.g.neoformat_try_node_exe = 1

vim.cmd [[
  augroup fmt
    autocmd!
    autocmd BufWritePre *.c Neoformat
    autocmd BufWritePre *.cpp Neoformat
    autocmd BufWritePre *.cs Neoformat
    autocmd BufWritePre *.json Neoformat
    autocmd BufWritePre *.js Neoformat
    autocmd BufWritePre *.nix Neoformat
    autocmd BufWritePre *.rs Neoformat
  augroup END
]]

local lazy_config = require "configs.lazy"

require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
