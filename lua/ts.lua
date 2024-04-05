require('nvim-treesitter.parsers').get_parser_configs().asm = {
    ignore_install = { "latex" },
    highlight = {
         enable = true,
         disable = { "latex" },
       },
    install_info = {
        url = 'https://github.com/rush-rs/tree-sitter-asm.git',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}
 

require'nvim-treesitter.configs'.setup {
  ignore_install = { "latex" },
  highlight = {
         enable = true,
         disable = { "latex" },
       },
}

