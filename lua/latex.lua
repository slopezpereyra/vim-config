vim.cmd('filetype plugin indent on')

-- This enables Vim's and neovim's syntax-related features. Without this, some
-- VimTeX features will not work (see ":help vimtex-requirements" for more
-- info).
vim.cmd('syntax enable')

--LATEX : Reference: https://github.com/gillescastel/latex-snippets
-- Don't open QuickFix for warning messages if no errors are present
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_view_method = "zathura"

vim.g.tex_flavor='latex'
vim.g.vimtex_quickfix_mode=0
vim.cmd('set conceallevel=2')
vim.g.tex_conceal='abdmg'
vim.g.tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
vim.g.tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
vim.g.tex_conceal_frac=1

