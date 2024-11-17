-- stolen from teej https://github.com/tjdevries/config.nvim/lua/custom/telescope/multi-ripgrep.lua

local core         = require('core.utils')

local project_root = core.find_project_root()

local conf         = require("telescope.config").values
local finders      = require "telescope.finders"
local make_entry   = require "telescope.make_entry"
local pickers      = require "telescope.pickers"

local flatten      = vim.tbl_flatten

return function(opts)
  opts = opts or {}
  -- opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  opts.cwd = project_root
  opts.shortcuts = opts.shortcuts
      or {
        ["l"] = "*.lua",
        ["v"] = "*.vim",
        ["n"] = "*.{vim,lua}",
        ["c"] = "*.c",
        ["r"] = "*.rs",
        ["g"] = "*.go",
      }
  opts.pattern = opts.pattern or "%s"

  local custom_grep = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local prompt_split = vim.split(prompt, "  ")

      local args = { "rg" }
      if prompt_split[1] then
        table.insert(args, "-e")
        table.insert(args, prompt_split[1])
      end

      if prompt_split[2] then
        table.insert(args, "-g")

        local pattern
        if opts.shortcuts[prompt_split[2]] then
          pattern = opts.shortcuts[prompt_split[2]]
        else
          pattern = prompt_split[2]
        end

        table.insert(args, string.format(opts.pattern, pattern))
      end

      return flatten {
        args,
        {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "-uuu",
          "--iglob",
          "!*{.git,go.mod,go.run,build,cargo,rustup,node_modules,pnpm-lock.yml,.svelte-kit, .astro}"
        },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = project_root,
  }

  pickers
      .new(opts, {
        debounce = 100,
        prompt_title = "Live Grep (with shortcuts)",
        finder = custom_grep,
        previewer = conf.grep_previewer(opts),
        sorter = require("telescope.sorters").empty(),
      })
      :find()
end
