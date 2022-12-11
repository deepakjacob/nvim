local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then 
	fn.system({
		'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
	})
	vim.api.nvim_command('packadd packer.nvim')
end

return require('packer').startup({
	function(use)
		-- packer can manage itself
		use 'wbthomason/packer.nvim'
		-- for faster startup
		use 'lewis6991/impatient.nvim' 
		-- colorscheme	
		use { "rebelot/kanagawa.nvim", config = "require('kanagawa-config')" }
		-- Filesystem navigation
		use { 'kyazdani42/nvim-tree.lua', requires = "kyazdani42/nvim-web-devicons", config = "require('nvim-tree-config')" }
		-- status line 
		 use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }, config = "require('lualine-config')" }
	end,
})
