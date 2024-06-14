
vim.api.nvim_set_keymap('n', '-', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '"', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
