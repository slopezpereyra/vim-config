-- Define mappings for buffer navigation using bufferline
vim.api.nvim_set_keymap('n', '<silent>cb', ':BufferLinePick<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<silent>nb', ':BufferLineCycleNext<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<silent>pb', ':BufferLineCyclePrev<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<silent>fb', ':BufferLineTogglePin<CR>', { silent = true })
