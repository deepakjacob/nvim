-- FTerm
require 'FTerm'.setup({
    border     = 'single',
    cmd        = 'zsh',
    blend      = 0,
    dimensions = {
        height = 0.9,
        width = 0.9,
    },
})
vim.keymap.set('n', 't', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
