local M = {}

function M.setup()
  vim.lsp.handlers['textDocument/publishDiagnostics'] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {spacing = 5, severity_limit = 'Warning'},
        update_in_insert = true
      })

  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = {"c", "lua", "rust", "html", "javascript"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      additional_vim_regex_highlighting = false
    },
    -- this is autotag config which is a plug-in to the tree-sitter
    autotag = {enable = true},
    -- rainbow brackets
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
    autopairs = {enable = true}
  }
end

return M
