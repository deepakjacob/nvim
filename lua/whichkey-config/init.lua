local wk = require("which-key")
local mappings = {
  q = {":q<cr>", "Quit"}, 
  Q = {":wq<cr>", "Save & Quit"}, 
  w = {"w<cr>", "Save"},
  x = {":bdelete<cr>", "Close Buffer"},
  E = {":e ~/.config/nvim/init.lua<cr>", "Open Config"},
  f = {":Telescope find_files<cr>", "Find Files"},
  r = {":Telescope live_grep<cr>", "Live Grep"},
  b = {":Telescope buffers<cr>", "Buffers"},
}
local opts = {prefix = '<leader>'}

wk.register(mappings, opts)

