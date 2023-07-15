local ls = require('luasnip')

ls.filetype_extend("javascript", { "html" })
ls.filetype_extend("javascriptreact", { "html" })
ls.filetype_extend("typescriptreact", { "html" })
require("luasnip/loaders/from_vscode").lazy_load()
