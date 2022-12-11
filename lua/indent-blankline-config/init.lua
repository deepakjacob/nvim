-- Ident Lines
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#2d3033 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#2d3033 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#2d3033 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#2d3033 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#2d3033 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#2d3033 gui=nocombine]]

require("indent_blankline").setup {
    -- char = '┊',
    char = ' ',
    use_treesitter = true,
    use_treesitter_scope = true,
    show_first_indent_level = true,
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}

