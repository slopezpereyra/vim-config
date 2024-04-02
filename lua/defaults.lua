
-- Set number
vim.opt.number = true

-- Set mouse
vim.opt.mouse = 'v'

-- Set showcmd
vim.opt.showcmd = true

-- Set encoding
vim.opt.encoding = 'utf-8'

-- Set showmatch
vim.opt.showmatch = true

-- Set relativenumber
vim.opt.relativenumber = true

-- Set ignorecase
vim.opt.ignorecase = true

-- Set hlsearch
vim.opt.hlsearch = true

-- Set tabstop
vim.opt.tabstop = 4

-- Set expandtab
vim.opt.expandtab = true

-- Set shiftwidth
vim.opt.shiftwidth = 4

-- Set autoindent
vim.opt.autoindent = true

-- Set smartindent
vim.opt.smartindent = true

-- Set showmatch
vim.opt.showmatch = true

-- Set signcolumn
vim.opt.signcolumn = 'yes'


-- Set noswapfile
vim.opt.swapfile = false

-- Set backupdir
vim.opt.backupdir = '~/.cache/nvim'

-- Set clipboard
vim.opt.clipboard:append('unnamedplus')

-- Set background
vim.opt.background = 'dark'

-- Set termguicolors
vim.opt.termguicolors = true

-- Set hidden
vim.opt.hidden = true

-- Set autoread
vim.opt.autoread = true

-- Set smartcase
vim.opt.smartcase = true

-- Set ruler
vim.opt.ruler = true

-- Set wrap
vim.opt.wrap = true

-- Set nocursorcolumn
vim.opt.cursorcolumn = false

-- Set nocursorline
vim.opt.cursorline = true

-- Set backupdir
vim.opt.backupdir = '~/.cache/vim'

-- Set wildignore
vim.opt.wildignore:append('.aux,.fdb_latexmk,.fls,.synctex,.log,.pdf')

-- For Neovim 0.1.3 and 0.1.4
if vim.fn.has('nvim') then
    vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end

-- For Neovim > 0.1.5 and Vim > patch 7.4.1799
if vim.fn.has('termguicolors') then
    vim.opt.termguicolors = true
end
