-- Function to toggle between color schemes
function toggle_colorscheme()
    local current_colorscheme = vim.api.nvim_get_var('colors_name')

    if current_colorscheme == 'dracula' then
        vim.cmd('colorscheme gruvbox-material')
    elseif current_colorscheme == 'gruvbox-material' then
        vim.cmd('colorscheme dracula')
    end
end

-- Define the mapping for Tab key in normal mode
vim.api.nvim_set_keymap('n', '<Tab>', '<Cmd>lua toggle_colorscheme()<CR>', { noremap = true, silent = true })
