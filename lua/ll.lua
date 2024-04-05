require('lualine').setup{

 sections = {
    lualine_a = {'mode', 'datetime'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', 'buffers'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
