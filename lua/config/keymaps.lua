local keymap = vim.keymap.set

-- Leader key
vim.g.mapleader = "\\"

-- Yank/Paste to system clipboard
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+yg_')
keymap("n", "<leader>y", '"+y')
keymap("n", "<leader>yy", '"+yy')

keymap("n", "<leader>p", '"+p')
keymap("n", "<leader>P", '"+P')
keymap("v", "<leader>p", '"+p')
keymap("v", "<leader>P", '"+P')

-- Window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Tagbar
keymap("n", "<F8>", ":TagbarToggle<CR>")

-- NERDTree
keymap("n", "<C-t>", ":NvimTreeToggle<CR>")

-- Floaterm
keymap("n", "<leader>tt", ":FloatermToggle<CR>")
keymap("n", "<leader>tg", ":FloatermNew lazygit<CR>")
keymap("n", "<leader>tk", ":FloatermKill<CR>")
keymap("n", "<leader>tc", ":FloatermNew<CR>")
keymap("n", "<leader>tn", ":FloatermNext<CR>")
keymap("n", "<leader>tp", ":FloatermPrev<CR>")

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- BufferLine
keymap('n','<Tab>', ':BufferLineCycleNext<CR>')
keymap('n','<S-Tab>', ':BufferLineCyclePrev<CR>')
keymap('n', '<C-Tab>', ':BufferLineCloseOthers<CR>')

-- LSP keymaps
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" }) 
keymap("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, { desc = "Format buffer" })

-- Files
keymap("n", "<C-s>", ":w<CR>")