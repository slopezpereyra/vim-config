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
set smartindent
set showmatch
set signcolumn=yes
set cc=80
set noswapfile
set backupdir=~/.cache/nvim
set clipboard+=unnamedplus
set background=dark
set termguicolors
set hidden
set autoread
set smartcase
set ruler
set wrap
set nocursorcolumn
set nocursorline
set cursorline
set backupdir=~/.cache/vim
set wildignore+=.aux,.fdb_latexmk,.fls,.synctex,.log,.pdf
set hidden

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
    set termguicolors
endif

" Tmux
if exists('$TMUX')

    " Colors in tmux
    let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"

endif

call plug#begin('~/local/share/nvim/plugged')

" Miscellaneous

Plug 'stevearc/aerial.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'voldikss/vim-floaterm'
Plug 'rush-rs/tree-sitter-asm'
Plug 'vim-autoformat/vim-autoformat'"
Plug 'startup-nvim/startup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-sensible'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'karb94/neoscroll.nvim'
"Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'use':  'rush-rs/tree-sitter-asm'}
Plug 'ryanoasis/vim-devicons'
Plug 'sbdchd/neoformat'
Plug 'kylechui/nvim-surround'
Plug 'nacro90/numb.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'tpope/vim-fugitive'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'jbyuki/instant.nvim'

"Snippets

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"LSP

Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind.nvim'
Plug 'ray-x/lsp_signature.nvim'


"LaTex suppport

Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

" Julia

Plug 'JuliaEditorSupport/julia-vim'
Plug 'axvr/zepl.vim'

" R

Plug 'jalvesaq/Nvim-R'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'gaalcaras/ncm-R'

" Vim 8 only
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

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

Plug 'drewtempelmeyer/palenight.vim'
Plug 'morhetz/gruvbox'
Plug 'EdenEast/nightfox.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'projekt0n/github-nvim-theme', { 'tag': 'v0.0.7' }
Plug 'AlexvZyl/nordic.nvim', { 'branch': 'main' }
Plug 'shaunsingh/nord.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
Plug 'embark-theme/vim'
Plug 'jnurmine/Zenburn'
Plug 'Mofiqul/vscode.nvim'
"Plug 'marko-cerovac/material.nvim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'mipmip/vim-petra'
Plug 'savq/melange-nvim'
Plug 'sainnhe/everforest'
Plug 'dracula/vim'
Plug 'chriskempson/base16-vim'
Plug 'nyoom-engineering/oxocarbon.nvim'

call plug#end()

" Custom functions 

function! SetLatexWritingConfig()
    set tw=80
    set wrap 
    set spell 
endfunction

function! SetJuliaEnvironment()
    execute "buffer zepl: julia"
    call chansend(&channel, "using Pkg\n")
    call chansend(&channel, "Pkg.activate(".")\n")
    execute "buffer #"
endfunction

function! SetJuliaRepl()
    execute 'keep Repl julia' 
    execute 'write'
    res 45
    execute "normal! \<C-w>\<C-r>"
    if !(filereadable("Manifest.toml") && filereadable("Project.toml"))
        call SetJuliaEnvironment()
    endif
endfunction

function! RunFile()
    let extension = expand('%:e')
    if extension  == 'py'
        execute "!python3 " . expand('%')
    end 
    if extension == 'jl' 
        execute "!julia " . expand('%')
    endif
endfunction  

function! LaTexToMD()
    %s/\\textit{\(.\{-}\)}/\*\1\*/g
    %s/\\textbf{\(.\{-}\)}/\**\1\**/g
    %s/\\\\/\\newline/g
    %s/---/—/g
" Add $$ symbol and new line character before each \begin{align*} environment
    g/\\begin{align\*}/normal! O$$
  " Add $$ symbol and new line character after each \end{align*} environment
    g/\\end{align\*}/normal! o$$
    g/^\\usepackage/d
    g/^\\documentclass/d
    g/\\[^{}]*{document}/d
endfunction

let g:Curscheme = 3
function! ChangeColors()
    let themes = ['dracula', 'petra', 'gruvbox', 'gruvbox-material', 'nord', 'tokyonight-moon', 'catppuccin', "vscode", "material"]
    if g:Curscheme == 7 
        let g:Curscheme = 0 
    else 
        let g:Curscheme  = g:Curscheme + 1
    endif
    execute "colorscheme " . themes[g:Curscheme]
    echo themes[g:Curscheme]
    let lua_code = 'require"lualine".setup({options = {theme = "' . themes[g:Curscheme] . '"}})'
    call luaeval(lua_code)
endfunction

nnoremap <F5> :source $MYVIMRC<CR>
nnoremap <F3> :e ~/.config/alacritty/alacritty.yml<CR>
nnoremap <F4> :!make runQEMU<CR>
tnoremap <Esc> <C-\><C-n>
nnorema <Tab> :call ChangeColors()<CR>

autocmd BufRead,BufNewFile *.tex,*.md :call SetLatexWritingConfig()
autocmd BufRead,BufNewFile *.jl :call SetJuliaRepl()

set completeopt=menu,preview,menuone,noselect

"" ------ NERDTree Config -------
"let NERDTreeIgnore=['\.gz', '\.fls', '\.fdb_latexmk', '\.aux', '\.pdf', '.in']
"let NERDTreeMinimalUI = 1
"let NERDTreeSortOrder = ['[[extension]]']
"let NERDTreeShowLineNumbers=1
"let g:NERDTreeWinPos = "right"
"autocmd VimEnter * NERDTree | wincmd p

" Instant 
let g:instant_username = "bebutron"


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
let g:tex_conceal_frac=1

let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
let g:UltiSnipsListSnippets = '<c-x><c-s>'
let g:UltiSnipsRemoveSelectModeMappings = 0

" Python Documentation DOGE 
let g:doge_doc_standard_python = 'google'

" Lsp remaps
nnoremap <silent> sd :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gtd :lua vim.lsp.buf.definition()<CR>

" Bufferline remaps
nnoremap <silent> cb :BufferLinePick<CR>
nnoremap <silent> nb :BufferLineCycleNext<CR>
nnoremap <silent> pb :BufferLineCyclePrev<CR>
nnoremap <silent> fb :BufferLineTogglePin<CR>


" MARKDOWN PREVIEW

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'


lua << EOF


-- AERIAL 

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,

  attach_mode = "global"
})

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

--- LSP extra
local lspkind = require('lspkind')
local cfg = {…}  -- add your config here
require "lsp_signature".setup(cfg)

--- ASM Treesitter 

require('nvim-treesitter.parsers').get_parser_configs().asm = {
    install_info = {
        url = 'https://github.com/rush-rs/tree-sitter-asm.git',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}

--- NvimTree 

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.api.nvim_command('NvimTreeOpen | wincmd p')

--- Autopairs and surround

require("nvim-autopairs").setup {}

require("nvim-surround").setup()

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
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...'})},
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
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
  require('lspconfig')['clangd'].setup {
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

-- Default configuration
require('neoscroll').setup()

-- Startup screen
require"startup".setup()


-- TELESCOPE

--require('telescope').setup()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ft', builtin.find_files, {})
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

require("ibl").setup {  }

require'lualine'.setup {
          options = {
            theme = 'gruvbox-material'
          }
        }

-- THEME CONFIGURATION
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = false },
    functions = { bold = true },
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = true, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})






EOF
"let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
"
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:material_theme_style = 'darker-community'
let g:gruvbox_material_foreground = 'mix'
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_cursor = "red"
let g:gruvbox_material_ui_contrast = "low"
let g:gruvbox_material_statusline_style = "original"

let g:gruvbox_material_background = 'medium'
colorscheme tokyonight-moon
