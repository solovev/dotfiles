return {
  'lukas-reineke/virt-column.nvim',
  config = function()
    require('virt-column').setup {
      highlight = 'IblIndent',
      char = '▏',
    }
  end,
}
