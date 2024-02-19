local status, conform = pcall(require, "conform")
if (not status) then return end



conform.setup {

    opts = {
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            sql = { { "sql-formatter", "sqlfmt" } },
        }
    }
}
