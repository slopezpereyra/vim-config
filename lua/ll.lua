require('lualine').setup{

    sections = {
        lualine_b = {
            'diagnostics'
        },
        lualine_c = {
            {
          'buffers',
          mode = 2
            }
        }, 
        lualine_a = {
            'datetime'
        }
    }
}
