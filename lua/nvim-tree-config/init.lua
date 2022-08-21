-- empty setup using defaults
require("nvim-tree").setup {
  open_on_setup = true,
  open_on_setup_file = true,

  view = {
    side = "right"
  },
  renderer = {
    indent_markers = {
      enable = true
    }
  }
}

vim.cmd('nnoremap <space>e :NvimTreeToggle<CR>')
