-- Compile lua to bytecode if the nvim version supports it.
vim.g.base46_cache = vim.fn.stdpath('data') .. '/base46_cache/'
if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then vim.loader.enable() end

require("core")
