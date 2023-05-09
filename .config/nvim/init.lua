-- modules
require("remap")
require("plugins")

-- colorscheme
vim.cmd.colorscheme("dracula")
vim.opt.termguicolors = true

-- sets
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false

-- globals
vim.g.netrw_banner = 0

