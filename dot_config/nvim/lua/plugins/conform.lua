return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier', 'eslint_d' },
        typescript = { 'prettier', 'eslint_d' },
        typescriptreact = { 'prettier', 'eslint_d' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    }
  end,
}
