" A note on virtual environments:
" When using a Python virtual environment we will 
" need to install python-lsp-server an pynvim on it.
" Try 
"
" >pipacs pynvim python-lsp-server
" 



set number
set mouse=a
set showcmd
set encoding=utf-8
set showmatch
set relativenumber
set ignorecase
set hlsearch
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set cc=80
set clipboard=unnamedplus
set cursorline
set noswapfile
set backupdir=~/.cache/nvim
set background=dark


call plug#begin('~/local/share/nvim/plugged')

Plug 'numToStr/Comment.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'dylanaraps/wal'
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake'
Plug 'terryma/vim-multiple-cursors'
Plug 'machakann/vim-highlightedyank'
Plug 'morhetz/gruvbox'
Plug 'jalvesaq/Nvim-R'
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sainnhe/gruvbox-material'
Plug 'marko-cerovac/material.nvim'
Plug 'RRethy/nvim-base16'
Plug 'michaelb/sniprun', {'do': 'bash ./install.sh'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
";Plug 'L3MON4D3/LuaSnip'
"''Plug 'rafamadriz/friendly-snippets'
Plug 'lervag/vimtex'
"Plug 'dcampos/nvim-snippy'
Plug 'honza/vim-snippets'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'sirver/ultisnips'
Plug 'shaunsingh/nord.nvim'
Plug 'vim-airline/vim-airline-themes'
Plug 'ayu-theme/ayu-vim'
Plug 'Yazeed1s/minimal.nvim'
Plug 'sunjon/shade.nvim'
Plug 'koenverburg/peepsight.nvim'
Plug 'savq/melange'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

call plug#end()


imap <expr> <Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-advance)' : '<Tab>'
imap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
smap <expr> <Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>'
smap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
xmap <Tab> <Plug>(snippy-cut-text)


let g:deoplete#enable_at_startup = 1
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
let g:coq_settings = {'auto_start': v:true}

call deoplete#enable()

let g:jedi#autocompletions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"

let g:neomake_python_enabled_makers = ['pylint']

call neomake#configure#automake('nrwi', 500)


lua << EOF

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<C-r>", ":SnipRun", {silent = true})

map("v", "<C-r>", ":SnipRun", {silent = true})

require'lspconfig'.pylsp.setup{}
require 'lspconfig'.r_language_server.setup{}

local lsp = require "lspconfig"
local coq = require "coq"
lsp.pylsp.setup(coq.lsp_ensure_capabilities())

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"python"},
	auto_install = true,
	highlight = { enable = true },
}

vim.g.material_style = "darker"

require('material').setup({
    contrast = {
        terminal = true, -- Enable contrast for the built-in terminal
        sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true, -- Enable contrast for floating windows
        cursor_line = true, -- Enable darker background for the cursor line
        non_current_windows = true, -- Enable darker background for non-current windows
        filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
    },
    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = true -- Enable higher contrast text for darker style
    },
    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },
})

require'sniprun'.setup({
	display = { "Terminal" },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


local highlights = require("nord").bufferline.highlights({
    italic = true,
    bold = true,
})


require('peepsight').setup({
  -- go
  "function_declaration",
  "method_declaration",
  "func_literal",
  "def",

  -- typescript
  "class_declaration",
  "method_definition",
  "arrow_function",
  "function_declaration",
  "generator_function_declaration"
})


require('neoscroll').setup()
require('Comment').setup()

vim.cmd 'colorscheme material'

EOF

let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:nord_disable_background = v:false
let g:nord_italic = v:true
let g:nord_uniform_diff_background = v:true
let g:nord_bold = v:true
" JULIA
let g:latex_to_unicode_auto = 1
let g:latex_to_unicode_tab = 0
let g:latex_to_unicode_cmd_mapping = ['<C-J>']

let g:slime_default_config = {"sessionname": "jl", "windowname": "0"}
let g:slime_dont_ask_default = 1


" LATEX : Reference: https://github.com/gillescastel/latex-snippets

" Don't open QuickFix for warning messages if no errors are present
let g:vimtex_quickfix_open_on_warning = 0  
let g:UltiSnipsSnippetDirectories = ["/home/santi/.config/nvim/mysnippets"]
"let g:vimtex_view_method = "zathura"

let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0

set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

filetype plugin indent on
autocmd VimEnter * NERDTree | wincmd p
