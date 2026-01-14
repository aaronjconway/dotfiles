local runtime_path = vim.split(package.path, ';')
vim.lsp.config.lua_ls = {
    root_markers = { '.luarc.json', '.luarc.jsonc' , '.git' },
    settings = {
        Lua = {
            telemetry = { enable = false },
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim' },
                disable = { 'missing-fields' }
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.fn.expand '$VIMRUNTIME/lua',
                    vim.fn.stdpath 'config' .. '/lua',
                },
            },
        },
    },
}
