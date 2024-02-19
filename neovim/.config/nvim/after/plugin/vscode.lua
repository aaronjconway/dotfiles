vim.o.background = 'dark'

local c = require('vscode.colors').get_colors()
require('vscode').setup({

  transparent = true,

  italic_comments = true,

  -- Disable nvim-tree background color
  disable_nvimtree_bg = true,

  color_overrides = {
    vscLineNumber = '#FFFFFF',
  },

  group_overrides = {
    Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
    NotificationInfo = { fg = c.vscGreen, bg = c.vscBack, bold = true },
    IncSearch = { bg = c.vscLightGreen, fg = c.vscDarkBlue, bold = true }
  }
})

require('vscode').load()
