-- nvim status line
require('lualine').setup {
    options = {
        theme = 'kanagawa',
        fmt = string.lower,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    }
}
