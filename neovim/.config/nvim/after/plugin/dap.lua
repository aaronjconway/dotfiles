-- dap config

local dap, dapui = require('dap'), require('dapui')
dapui.setup()

require('nvim-dap-virtual-text').setup {}
--terminate on detach
dap.listeners.before.event_terminated["dapui_config"] =
    function() dapui.close() end

--term on exit
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- mfussenegger/nvim-dap
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {
    os.getenv('HOME') .. '/.local/share/nvim/lazy/vscode-node-debug2/out/src/nodeDebug.js'
  }
}

local function attach()
  print("attaching")
  dap.run({
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = { '<node_internals>/**/*.js' },
  })
end

local function attachToRemote()
  print("attaching")
  dap.run({
    type = 'node2',
    request = 'attach',
    address = "127.0.0.1",
    port = 9229,
    localRoot = vim.fn.getcwd(),
    remoteRoot = "/home/vcap/app",
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = { '<node_internals>/**/*.js' },
  })
end

vim.keymap.set('n', '<leader>da', function() attach() end)

vim.keymap.set('n', '<leader>dA',
  function() attachToRemote() end)

vim.fn.sign_define('DapBreakpoint',
  { text = '🟥', texthl = '', linehl = '', numhl = '' })

vim.fn.sign_define('DapBreakpointRejected',
  { text = '🟦', texthl = '', linehl = '', numhl = '' })

vim.fn.sign_define('DapStopped',
  { text = '->', texthl = '', linehl = '', numhl = '' })

vim.keymap.set('n', '<leader>dh',
  function() require "dap".toggle_breakpoint() end)

vim.keymap.set('n', '<leader>dH',
  ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

vim.keymap.set({ 'n', 't' }, '<A-k>', function() require "dap".step_out() end)

vim.keymap.set({ 'n', 't' }, "<A-l>", function() require "dap".step_into() end)

vim.keymap.set({ 'n', 't' }, '<A-j>', function() require "dap".step_over() end)

vim.keymap.set({ 'n', 't' }, '<A-h>', function() require "dap".continue() end)

vim.keymap.set('n', '<leader>dn', function() require "dap".run_to_cursor() end)

vim.keymap.set('n', '<leader>dc', function() require "dap".terminate() end)

vim.keymap.set('n', '<leader>dR',
  function() require "dap".clear_breakpoints() end)

vim.keymap.set('n', '<leader>de',
  function() require "dap".set_exception_breakpoints({ "all" }) end)


vim.keymap
    .set('n', '<leader>di', function() require "dap.ui.widgets".hover() end)

vim.keymap.set('n', '<leader>d?', function()
  local widgets = require "dap.ui.widgets";
  widgets.centered_float(widgets.scopes)
end)

vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
vim.keymap.set('n', '<leader>dr',
  ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')

-- toggle dap ui
vim.keymap.set('n', '<leader>du', ':lua require"dapui".toggle()<CR>')
