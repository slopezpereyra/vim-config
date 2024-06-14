

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
		'neovim/nvim-lspconfig', 
        'lewis6991/gitsigns.nvim',
        'simrat39/symbols-outline.nvim',
        'junegunn/goyo.vim',
        'onsails/lspkind.nvim',
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
        'folke/tokyonight.nvim',
        {
          'mrcjkb/haskell-tools.nvim',
          version = '^3', -- Recommended
          ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
        },
        -- install without yarn or npm
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
            build = function() vim.fn["mkdp#util#install"]() end,
        }, 
        {
            'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                              , branch = '0.1.x',
              dependencies = { 'nvim-lua/plenary.nvim' }
        }, 
        {
          'nvim-java/nvim-java',
          dependencies = {
            'nvim-java/lua-async-await',
            'nvim-java/nvim-java-core',
            'nvim-java/nvim-java-test',
            'nvim-java/nvim-java-dap',
            'MunifTanjim/nui.nvim',
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-dap',
            {
              'williamboman/mason.nvim',
              opts = {
                registries = {
                  'github:nvim-java/mason-registry',
                  'github:mason-org/mason-registry',
                },
              },
            }
          },
        }
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
require('remaps')
require('telescope')
require('java').setup()
require('gitsigns').setup()
require("symbols-outline").setup()

require('lspconfig').jdtls.setup({})
vim.api.nvim_set_keymap('n', '<Leader>o', '<Cmd>SymbolsOutline<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>g', '<Cmd>Goyo<CR>', { noremap = true, silent = true })
		
--vim.api.nvim_exec([[autocmd VimEnter * NERDTree | wincmd p]], false)
vim.cmd('colorscheme gruvbox-material')

