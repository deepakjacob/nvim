local M = {}

function M.setup()
  -- empty setup using defaults

  require("nvim-tree").setup {
    open_on_setup = true,
    open_on_setup_file = true,
    update_focused_file = {enable = true, update_cwd = false},
    view = {side = "right"},
    renderer = {indent_markers = {enable = true}}
  }
end

return M
