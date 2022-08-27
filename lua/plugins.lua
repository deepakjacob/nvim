local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end

    -- Run PackerCompile if there are changes in this file
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
    vim.api.nvim_create_autocmd(
      { "BufWritePost" },
      { pattern = "init.lua", command = "source <afile> | PackerCompile", group = packer_grp }
    )
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Performance
    use { "lewis6991/impatient.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "BufReadPre",
      config = function()
        require("config.notify").setup()
      end,
      disable = false,
    }
   
    -- Colorscheme
   
    use {
      "sainnhe/everforest",
      config = function()
        vim.g.everforest_better_performance = 1
        vim.cmd "colorscheme everforest"
      end,
      disable = false,
    }
    
    use {
      "norcalli/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
        require("colorizer").setup()
      end,
    }
    use {
      "rktjmp/lush.nvim",
      cmd = { "LushRunQuickstart", "LushRunTutorial", "Lushify", "LushImport" },
      disable = false,
    }

    -- Better Netrw
    use { "tpope/vim-vinegar", event = "BufReadPre" }

    -- Git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      config = function()
        require("config.neogit").setup()
      end,
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }
    

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      -- keys = { [[<leader>]] },
      config = function()
        require("config.whichkey").setup()
      end,
      disable = false,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("config.comment").setup()
      end,
      disable = false,
    }

    -- Motions
    use { "andymass/vim-matchup", event = "CursorMoved" }
    use { "wellle/targets.vim", event = "CursorMoved" }
    use { "unblevable/quick-scope", event = "CursorMoved", disable = false }
    use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } }

    -- Buffer
    use { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } }
    use {
      "matbme/JABS.nvim",
      cmd = "JABSOpen",
      config = function()
        require("config.jabs").setup()
      end,
      disable = false,
    }
    use {
      "chentoast/marks.nvim",
      event = "BufReadPre",
      config = function()
        require("marks").setup {}
      end,
    }

    -- IDE
    use {
      "antoinemadec/FixCursorHold.nvim",
      event = "BufReadPre",
      config = function()
        vim.g.cursorhold_updatetime = 100
      end,
    }
    use {
      "max397574/better-escape.nvim",
      event = { "InsertEnter" },
      config = function()
        require("better_escape").setup {
          mapping = { "jk" },
          timeout = vim.o.timeoutlen,
          keys = "<ESC>",
        }
      end,
    }
    
   


    use {
      "ggandor/leap.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        local leap = require "leap"
        leap.set_default_keymaps()
      end,
    }
    use {
      "abecodes/tabout.nvim",
      wants = { "nvim-treesitter" },
      after = { "nvim-cmp" },
      config = function()
        require("tabout").setup {
          completion = false,
          ignore_beginning = true,
        }
      end,
    }
    use { "AndrewRadev/splitjoin.vim", keys = { "gS", "gJ" }, disable = false }
    -- use {
    --   "ggandor/lightspeed.nvim",
    --   keys = { "s", "S", "f", "F", "t", "T" },
    --   config = function()
    --     require("lightspeed").setup {}
    --   end,
    -- }



    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "BufReadPre",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup()
      end,
      wants = "nvim-web-devicons",
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufReadPre",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
        { "windwp/nvim-ts-autotag", event = "InsertEnter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
        { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
        { "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
        -- { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre" },
        -- { "yioneko/nvim-yati", event = "BufReadPre" },
      },
    }

    use {
      "nvim-telescope/telescope.nvim",
      opt = true,
      config = function()
        require("config.telescope").setup()
      end,
      cmd = { "Telescope" },
      module = { "telescope", "telescope.builtin" },
      keys = { "<leader>f", "<leader>p", "<leader>z" },
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-fzf-native.nvim",
        "telescope-repo.nvim",
        "telescope-file-browser.nvim",
        "trouble.nvim",
        "telescope-frecency.nvim",
        "telescope-arecibo.nvim",
        "telescope-zoxide",
        "cder.nvim",
        "aerial.nvim",
      },
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "cljoly/telescope-repo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
   
        "dhruvmanila/telescope-bookmarks.nvim",
        "jvgrootveld/telescope-zoxide",
        "Zane-/cder.nvim",
        "nvim-telescope/telescope-symbols.nvim",
      },
    }

    -- nvim-tree
    use {
      "kyazdani42/nvim-tree.lua",
      opt = true,
      wants = "nvim-web-devicons",
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      -- module = "nvim-tree",
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
        require("config.bufferline").setup()
      end,
    }

    -- User interface
    use {
      "stevearc/dressing.nvim",
      event = "BufReadPre",
      config = function()
        require("dressing").setup {
          input = { relative = "editor" },
          select = {
            backend = { "telescope", "fzf", "builtin" },
          },
        }
      end,
      disable = false,
    }

    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "lukas-reineke/cmp-rg",
        "davidsierradz/cmp-conventionalcommits",
        -- "onsails/lspkind-nvim",
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        -- "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          wants = { "friendly-snippets", "vim-snippets" },
          config = function()
            require("config.snip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
      },
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      opt = true,
      event = "InsertEnter",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- Auto tag
    use {
      "windwp/nvim-ts-autotag",
      opt = true,
      wants = "nvim-treesitter",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      opt = true,
      wants = "nvim-treesitter",
      event = "InsertEnter",
      disable = false,
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = { "BufReadPre" },
      wants = {
        -- "nvim-lsp-installer",
        "mason.nvim",
        "mason-lspconfig.nvim",
        "mason-tool-installer.nvim",
        "cmp-nvim-lsp",
        "vim-illuminate",
        "null-ls.nvim",
        "typescript.nvim",
        "nvim-navic",
        "inlay-hints.nvim",
        -- "goto-preview",
      },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        -- "williamboman/nvim-lsp-installer",
        -- { "lvimuser/lsp-inlayhints.nvim", branch = "readme" },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "RRethy/vim-illuminate",
        "jose-elias-alvarez/null-ls.nvim",
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup {}
          end,
        },
        "jose-elias-alvarez/typescript.nvim",
        {
          "SmiteshP/nvim-navic",
          config = function()
            require("nvim-navic").setup {}
          end,
          module = { "nvim-navic" },
        },
        {
          "simrat39/inlay-hints.nvim",
          config = function()
            require("inlay-hints").setup()
          end,
        },
      },
    }

    -- trouble.nvim
    use {
      "folke/trouble.nvim",
      wants = "nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end,
    }

    -- lspsaga.nvim
    use {
      "glepnir/lspsaga.nvim",
      cmd = { "Lspsaga" },
      config = function()
        require("lspsaga").init_lsp_saga()
      end,
    }

    -- renamer.nvim
    use {
      "filipdutescu/renamer.nvim",
      module = { "renamer" },
      config = function()
        require("renamer").setup {}
      end,
    }

    -- Rust
    use {
      "simrat39/rust-tools.nvim",
      requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
      opt = true,
      module = "rust-tools",
      ft = { "rust" },
      -- branch = "modularize_and_inlay_rewrite",
      -- config = function()
      --   require("config.rust").setup()
      -- end,
    }
    use {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        -- local null_ls = require "null-ls"
        require("crates").setup {
          null_ls = {
            enabled = true,
            name = "crates.nvim",
          },
        }
      end,
      disable = false,
    }

    -- Go
    use {
      "ray-x/go.nvim",
      ft = { "go" },
      config = function()
        require("go").setup()
      end,
      disable = false,
    }

    -- Terminal
    use {
      "akinsho/toggleterm.nvim",
      keys = { [[<C-\>]] },
      cmd = { "ToggleTerm", "TermExec" },
      module = { "toggleterm", "toggleterm.terminal" },
      config = function()
        require("config.toggleterm").setup()
      end,
    }


    -- Legendary
    use {
      "mrjones2014/legendary.nvim",
      opt = true,
      keys = { [[<C-p>]] },
      -- wants = { "dressing.nvim" },
      module = { "legendary" },
      cmd = { "Legendary" },
      config = function()
        require("config.legendary").setup()
      end,
      -- requires = { "stevearc/dressing.nvim" },
    }

    -- Harpoon
    use {
      "ThePrimeagen/harpoon",
      keys = { [[<leader>j]] },
      module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
      wants = { "telescope.nvim" },
      config = function()
        require("config.harpoon").setup()
      end,
    }


    -- Performance
    use { "dstein64/vim-startuptime", cmd = "StartupTime" }
    use {
      "nathom/filetype.nvim",
      cond = function()
        return vim.fn.has "nvim-0.8.0" == 0
      end,
    }


   
    -- Sidebar
    use {
      "liuchengxu/vista.vim",
      cmd = { "Vista" },
      config = function()
        vim.g.vista_default_executive = "nvim_lsp"
      end,
    }
    use {
      "sidebar-nvim/sidebar.nvim",
      cmd = { "SidebarNvimToggle" },
      config = function()
        require("sidebar-nvim").setup { open = false }
      end,
    }
    use {
      "stevearc/aerial.nvim",
      config = function()
        require("aerial").setup()
      end,
      module = { "aerial" },
      cmd = { "AerialToggle" },
    }

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Neovim restart is required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"

  -- Performance
  pcall(require, "impatient")
  -- pcall(require, "packer_compiled")

  packer.init(conf)
  packer.startup(plugins)
end

return M
