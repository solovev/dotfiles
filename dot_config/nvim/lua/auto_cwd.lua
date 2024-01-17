-- Array of file names indicating root directory. Modify to your liking.
local root_names = { '.git', 'Makefile', 'package.json', 'lazy-lock.json', 'stylua.toml' }

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

local set_root = function()
  local path = ''

  -- Get directory from nvim args.
  if vim.fn.argc() > 0 then
    local arg_path = vim.v.argv[#vim.v.argv]
    if vim.fn.isdirectory(arg_path) then
      path = arg_path
    end
  else
    path = vim.api.nvim_buf_get_name(0)
    if path ~= '' then
      path = vim.fs.dirname(path)
    end
  end

  if path == '' then
    return
  end

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then
      return
    end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  -- Set current directory
  vim.fn.chdir(root)

  print('[auto_cmd] Root is set to: ' .. root)
end

local root_augroup = vim.api.nvim_create_augroup('MyAutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, once = true, callback = set_root })
