

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
	{
		{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
		'neovim/nvim-lspconfig', 'onsails/lspkind.nvim',
		'hrsh7th/cmp-nvim-lsp',
		'ray-x/lsp_signature.nvim', 
		'hrsh7th/nvim-cmp', 
		'SirVer/ultisnips',
		'honza/vim-snippets',
		'lervag/vimtex',
		{'KeitaNakamura/tex-conceal.vim'},
        'dracula/vim',
		'quangnguyen30192/cmp-nvim-ultisnips',
		'kylechui/nvim-surround',
		'kyazdani42/nvim-web-devicons',
        'jalvesaq/Nvim-R',
        'ncm2/ncm2',
        'roxma/nvim-yarp',
        'gaalcaras/ncm-R',
	    'preservim/nerdtree',
        'JuliaEditorSupport/julia-vim',
        'hrsh7th/cmp-nvim-lsp',
        'Vigemus/iron.nvim',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'kdheepak/cmp-latex-symbols',
        'quangnguyen30192/cmp-nvim-ultisnips',
        {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
        },
        {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            config = true
            -- use opts = {} for passing setup options
            -- this is equalent to setup({}) function
        },
        'sainnhe/gruvbox-material',
        'folke/tokyonight.nvim'
    }
	)

require("defaults")
require("lsp")
require("ts")
require("latex")
require("NT")
require("nvim-surround").setup()
require("nvim-autopairs").setup {}
require("icons")
require('ll')
require('drac')
require('gruvbox')
require('theme_switch')
require('iron_repl')
--require('julia_config')
require('tokyo')

		
vim.cmd('colorscheme dracula')

