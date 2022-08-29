local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end
    }
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path
      }
      vim.cmd [[packadd packer.nvim]]
    end

    -- Run PackerCompile if there are changes in this file
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      pattern = "init.lua",
      command = "source <afile> | PackerCompile",
      group = packer_grp
    })
  end

  -- Plugins
  local function plugins(use)

    use 'wbthomason/packer.nvim'
    -- use { "folke/tokyonight.nvim", config = "vim.cmd('colorscheme tokyonight')" }
    use { "rebelot/kanagawa.nvim", config = 'vim.cmd("colorscheme kanagawa")' }
    use {
      'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      event = "BufWinEnter",
      config = "require('bufferline-config').setup()"
    }
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ":TSUpdate",
      event = "BufWinEnter",
      config = "require('treesitter-config')"
    }
    use {
      'hoob3rt/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      event = "BufWinEnter",
      config = "require('lualine-config')"
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons' -- optional, for file icons
      },
      tag = 'nightly', -- optional, updated every week. (see issue #1193)
      cmd = "NvimTreeToggle",
      config = "require('nvim-tree-config')"
    }
    use { 'windwp/nvim-ts-autotag', event = "InsertEnter", after = "nvim-treesitter" }
    -- use { 'p00f/nvim-ts-rainbow', after = "nvim-treesitter" }
    use {
      'windwp/nvim-autopairs',
      config = "require('autopairs-config').setup()",
      after = "nvim-cmp"
    }
    use { 'folke/which-key.nvim', event = "BufWinEnter", config = "require('whichkey-config')" }
    use {
      'nvim-telescope/telescope.nvim',
      tag = "0.1.0",
      requires = { { 'nvim-lua/plenary.nvim' } },
      cmd = "Telescope",
      config = "require('telescope-config').setup()"
    }
    use { 'neovim/nvim-lspconfig', config = "require('lsp')" }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }

    -- For vsnip users.
    use { 'hrsh7th/cmp-vsnip' }
    use { 'hrsh7th/vim-vsnip' }
    use { 'onsails/lspkind-nvim' }

    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup { current_line_blame = true }
      end
    }
    use { "akinsho/toggleterm.nvim", config = "require('toggleterm-config')" }
    use {
      'glepnir/lspsaga.nvim',
      branch = "main",
      config = function()
        require('lspsaga-config').setup()
      end
    }
    use { 'williamboman/nvim-lsp-installer' }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        require('null-ls-config').setup()
      end
    }

    if packer_bootstrap then
      print "Neovim restart is required after installation!"
      require("packer").sync()
    end
  end

  -- init and start packer
  packer_init()
  local packer = require "packer"

  -- performance
  pcall(require, "impatient")

  packer.init(conf)
  packer.startup(plugins)
end

return M
