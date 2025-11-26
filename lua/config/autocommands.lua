local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- LSP and formatting autocommands
local lsp_formatting_group = augroup("LspFormatting", {})

autocmd("LspAttach", {
  group = augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method("textDocument/formatting") then
      autocmd("BufWritePre", {
        group = lsp_formatting_group,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})