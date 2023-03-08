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
set cursorline
set noswapfile
set backupdir=~/.cache/nvim
set clipboard+=unnamedplus
set background=dark
set termguicolors

" Tmux
if exists('$TMUX')

    " Colors in tmux
    let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"

endif

call plug#begin('~/local/share/nvim/plugged')

" Miscellaneous

Plug 'startup-nvim/startup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-sensible'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'karb94/neoscroll.nvim'
Plug 'scrooloose/nerdtree'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ryanoasis/vim-devicons'
Plug 'sbdchd/neoformat'
Plug 'sunjon/shade.nvim'
Plug 'tpope/vim-surround'
Plug 'nacro90/numb.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'tpope/vim-fugitive'

" Snippets 

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" LSP

Plug 'neovim/nvim-lspconfig'

" LaTex suppport

Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

" Julia

Plug 'JuliaEditorSupport/julia-vim'

" CMP 

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'kdheepak/cmp-latex-symbols'
" For ultisnips users.
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Colors schemes

Plug 'morhetz/gruvbox'
Plug 'EdenEast/nightfox.nvim' 
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'projekt0n/github-nvim-theme', { 'tag': 'v0.0.7' }
Plug 'savq/melange'
Plug 'AlexvZyl/nordic.nvim', { 'branch': 'main' }
Plug 'shaunsingh/nord.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
Plug 'LunarVim/lunar.nvim'

call plug#end()


set completeopt=menu,preview,menuone,noselect
"Useful NERDTree ignores for LaTex project
let NERDTreeIgnore=['\.gz', '\.fls', '\.fdb_latexmk', '\.aux', '\.pdf']

"let g:coq_settings = { 'auto_start': v:true }
"autocmd VimEnter * NERDTree | wincmd p

" LATEX : Reference: https://github.com/gillescastel/latex-snippets
" Don't open QuickFix for warning messages if no errors are present
syntax enable
filetype plugin indent on
let g:vimtex_quickfix_open_on_warning = 0  
let g:vimtex_view_method = "zathura"

let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0

set conceallevel=2
let g:tex_conceal='abdmg'
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'      
let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
let g:UltiSnipsListSnippets = '<c-x><c-s>'
let g:UltiSnipsRemoveSelectModeMappings = 0

" Lsp remaps 
nnoremap <silent> gtd :lua vim.lsp.buf.hover()<CR>

" Bufferline remaps
nnoremap <silent> gb :BufferLinePick<CR>
nnoremap <silent> ngb :BufferLineCycleNext<CR>
nnoremap <silent> bgb :BufferLineCyclePrev<CR>

lua << EOF

--- Autopairs 

require("nvim-autopairs").setup {}

-----------------------------------

require'lspconfig'.julials.setup{
    on_new_config = function(new_config, _)
        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        if require'lspconfig'.util.path.is_file(julia) then
	    vim.notify("Hello!")
            new_config.cmd[1] = julia
        end
    end
}

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.complete()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                    fallback()
                end
            end
        }),
        ["<S-Tab>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.complete()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                    fallback()
                end
            end
        }),

      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'latex_symbols' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['julials'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['r_language_server'].setup {
    capabilities = capabilities
  }

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

--- SMALLS
require("bufferline").setup{}
require('numb').setup()

require'shade'.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up    = '<C-Up>',
    brightness_down  = '<C-Down>',
    toggle           = '<Leader>s',
  }
})
-- Default configuration
require('neoscroll').setup()

-- Startup screen 
require"startup".setup()


-- TELESCOPE 

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- TREESITTER

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- LSP Servers
--local lsp = require "lspconfig"
--local coq = require "coq" -- add this
--
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
--require('lspconfig')['pyright'].setup {
--    capabilities = capabilities
--}
--require('lspconfig')['julials'].setup {
--    capabilities = capabilities
--} 
--require('lspconfig')['r_language_server'].setup {
--    capabilities = capabilities
--  }

--require'lspconfig'.pyright.setup{}
--require'lspconfig'.r_language_server.setup{}
--require'lspconfig'.julials.setup{}
--lsp.pyright.setup(coq.lsp_ensure_capabilities())
--lsp.julials.setup(coq.lsp_ensure_capabilities())
---- COQ
--
--require("coq_3p") {
--  { src = "vimtex",  short_name = "vTEX" }
--}

-- LUALINE
local custom_gruvbox = require'lualine.themes.nord'
--require('lualine').setup {
--  options = {
--    -- ... your lualine config
--    theme = 'tokyonight'
--    -- ... your lualine config
--  }
--}
require('lualine').setup {
  options = { theme  = custom_gruvbox },
}
--Change the background of lualine_c section for normal mode
custom_gruvbox.normal.c.bg = '#112233'



-- ICONS

require'nvim-web-devicons'.get_icons()
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

-- INDENT LINES

--vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_end_of_line = false,
    show_current_context = true,
    show_current_content_start = true,
}
 
require'lualine'.setup {
          options = {
            theme = 'tokyonight'
          }
        }

EOF

"colorscheme gruvbox
" Example config in Vim-Script
let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:nord_disable_background = v:false
let g:nord_italic = v:false
let g:nord_uniform_diff_background = v:true
let g:nord_bold = v:false

let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_foreground = "material"
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_dim_inactive_windows = 0
let g:gruvbox_material_better_performance = 1
" Load the colorscheme
colorscheme tokyonight-night
"set runtimepath-=~/local/share/nvim/plugged/indent-blankline
