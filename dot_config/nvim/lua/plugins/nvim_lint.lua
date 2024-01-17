return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    }

    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })

    vim.api.nvim_create_autocmd({ 'TextChanged' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
