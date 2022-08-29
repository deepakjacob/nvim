local M = {}

function M.setup()
  require('lsp/cmp').setup()
  require('lsp/diagnostic_signs').setup()
  require('lsp/language_servers').setup()

end

return M
