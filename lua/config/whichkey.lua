local M = {}

local whichkey = require "which-key"
local legendary = require "legendary"
local next = next

local conf = {
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
whichkey.setup(conf)

local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
  local keymap_f = nil -- File search
  local keymap_p = nil -- Project search

  keymap_f = {
    name = "Find",
    f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
    b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
    h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
    m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
    o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
    g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
    c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
    w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  }

  keymap_p = {
    name = "Project",
    P = { "<cmd>TermExec cmd='BROWSER=brave yarn dev'<cr>", "Slidev" },
  }

  local keymap = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>lua require('utils').quit()<CR>", "Quit" },
    -- ["t"] = { "<cmd>ToggleTerm<CR>", "Terminal" },

    a = {
      name = "Attempt",
      n = { "<Cmd>lua require('attempt').new_select()<Cr>", "New Select" },
      i = { "<Cmd>lua require('attempt').new_input_ext()<Cr>", "New Input Extension" },
      r = { "<Cmd>lua require('attempt').run()<Cr>", "Run" },
      d = { "<Cmd>lua require('attempt').delete_buf()<Cr>", "Delete Buffer" },
      c = { "<Cmd>lua require('attempt').rename_buf()<Cr>", "Rename Buffer" },
      s = { "<Cmd>Telescope attempt<Cr>", "Search" },
    },

    b = {
      name = "Buffer",
      c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
      f = { "<Cmd>BDelete! this<Cr>", "Force Close Buffer" },
      D = { "<Cmd>BWipeout other<Cr>", "Delete All Buffers" },
      b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
      p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
      m = { "<Cmd>JABSOpen<Cr>", "Menu" },
    },

    c = {
      name = "Code",
      x = "Swap Next Param",
      X = "Swap Prev Param",
      -- f = "Select Outer Function",
      -- F = "Select Outer Class",
    },

    f = keymap_f,
    p = keymap_p,

    o = {
      name = "Overseer",
      C = { "<cmd>OverseerClose<cr>", "OverseerClose" },
      a = { "<cmd>OverseerTaskAction<cr>", "OverseerTaskAction" },
      b = { "<cmd>OverseerBuild<cr>", "OverseerBuild" },
      c = { "<cmd>OverseerRunCmd<cr>", "OverseerRunCmd" },
      d = { "<cmd>OverseerDeleteBundle<cr>", "OverseerDeleteBundle" },
      l = { "<cmd>OverseerLoadBundle<cr>", "OverseerLoadBundle" },
      o = { "<cmd>OverseerOpen!<cr>", "OverseerOpen" },
      q = { "<cmd>OverseerQuickAction<cr>", "OverseerQuickAction" },
      r = { "<cmd>OverseerRun<cr>", "OverseerRun" },
      s = { "<cmd>OverseerSaveBundle<cr>", "OverseerSaveBundle" },
      t = { "<cmd>OverseerToggle!<cr>", "OverseerToggle" },
    },
    r = {
      name = "Refactor",
      i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
      b = { [[<cmd>lua require('refactoring').refactor('Exract Block')<cr>]], "Extract Block" },
      B = { [[<cmd>lua require('refactoring').refactor('Exract Block To File')<cr>]], "Extract Block to File" },
      P = {
        [[<cmd>lua require('refactoring').debug.printf({below = false})<cr>]],
        "Debug Print",
      },
      p = {
        [[<cmd>lua require('refactoring').debug.print_var({normal = true})<cr>]],
        "Debug Print Variable",
      },
      c = { [[<cmd>lua require('refactoring').debug.cleanup({})<cr>]], "Debug Cleanup" },
    },

    

    z = {
      name = "System",
      -- c = { "<cmd>PackerCompile<cr>", "Compile" },
      c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
      D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Macros" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
      -- x = { "<cmd>cd %:p:h<cr>", "Change Directory" },
      -- x = { "<cmd>set autochdir<cr>", "Auto ChDir" },
      x = { "<cmd>Telescope cder<cr>", "Change Directory" },
      e = { "!!$SHELL<CR>", "Execute line" },
      z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status - Neogit" },
    },
  }
  whichkey.register(keymap, opts)
  legendary.bind_whichkey(keymap, opts, false)
end

local function visual_keymap()
  local keymap = {
    g = {
      name = "Git",
      y = {
        "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Link",
      },
    },

    r = {
      name = "Refactor",
      f = { [[<cmd>lua require('refactoring').refactor('Extract Function')<cr>]], "Extract Function" },
      F = {
        [[ <cmd>lua require('refactoring').refactor('Extract Function to File')<cr>]],
        "Extract Function to File",
      },
      v = { [[<cmd>lua require('refactoring').refactor('Extract Variable')<cr>]], "Extract Variable" },
      i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
      r = { [[<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>]], "Refactor" },
      d = { [[<cmd>lua require('refactoring').debug.print_var({})<cr>]], "Debug Print Var" },
    },
  }

  whichkey.register(keymap, v_opts)
  legendary.bind_whichkey(keymap, v_opts, false)
end

local function code_keymap()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      vim.schedule(CodeRunner)
    end,
  })
end

function M.setup()
  normal_keymap()
  visual_keymap()
  code_keymap()
end

return M
