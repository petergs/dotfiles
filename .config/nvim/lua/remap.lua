vim.g.mapleader = " "
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnext)
vim.keymap.set("n", "<leader>tp", vim.cmd.tabprevious)
vim.keymap.set("n", "<leader>te", vim.cmd.tabnew)
vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, opts)
