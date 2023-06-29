local dap = require('dap')

-- mfussenegger/nvim-dap
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {
    os.getenv('HOME') .. '/.local/share/nvim/lazy/vscode-node-debug2/out/src/nodeDebug.js'
  }
}

-- capabilites
--       - start a debugger process
--       - attach to
--       - open dapui
--       - handle restart
--       - handle exit or error
--       - don't pase end of file.

local function launch()
  print("launching debug")
  dap.run({
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = { '<node_internals>/**/*.js' },
  })
end

