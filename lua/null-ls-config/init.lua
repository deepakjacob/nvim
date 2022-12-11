-- null-ls for Markdown linters
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.markdownlint.with({
            diagnostics_format = "[#{c}] #{m} (#{s})",
            filter = function(diagnostic)
                return diagnostic.code ~= "MD013/line-length"
            end,
        }),
    },
