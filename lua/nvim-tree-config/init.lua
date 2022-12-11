-- empty setup using defaults
require("nvim-tree").setup {
  open_on_setup = true,
  open_on_setup_file = true,
  view = {
    side = "right",
 mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },

  },
  renderer = {
    indent_markers = {
      enable = true,
         }, 
     group_empty = true,
        icons = {
            git_placement = "after",
            glyphs = {
                git = {
                    unstaged = "-",
                    staged = "s",
                    untracked = "u",
                    renamed = "r",
                    deleted = "d",
                    ignored = "i",
                },
            },
        },
  },
  filters = {
    dotfiles = false,
  },
  git = {
   ignore = false,
  },
}
