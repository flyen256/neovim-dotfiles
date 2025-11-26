local keymap = vim.keymap.set

-- Leader key
vim.g.mapleader = " "

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
keymap("n", "<C-n>", ":NERDTree<CR>")
keymap("n", "<C-t>", ":NERDTreeToggle<CR>")

-- Floaterm
keymap("n", "tt", ":FloatermToggle<CR>")
keymap("n", "tg", ":FloatermNew lazygit<CR>")
keymap("n", "tk", ":FloatermKill<CR>")
keymap("n", "tc", ":FloatermNew<CR>")
keymap("n", "tn", ":FloatermNext<CR>")
keymap("n", "tp", ":FloatermPrev<CR>")

-- Telescope
keymap("n", "ff", "<cmd>Telescope find_files<cr>")
keymap("n", "fg", "<cmd>Telescope live_grep<cr>")
keymap("n", "fb", "<cmd>Telescope buffers<cr>")
keymap("n", "fh", "<cmd>Telescope help_tags<cr>")

-- LSP keymaps
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, { desc = "Format buffer" })

-- Auto-pairs and snippets
keymap("i", "\"<tab>", '\"\"<Left>', { noremap = true })
keymap("i", "'<tab>", "''<Left>", { noremap = true })
keymap("i", "(<tab>", "()<Left>", { noremap = true })
keymap("i", "[<tab>", "[]<Left>", { noremap = true })
keymap("i", "{<tab>", "{}<Left>", { noremap = true })
keymap("i", "{<CR>", "{<CR>}<ESC>O", { noremap = true })
keymap("i", "{;<CR>", "{<CR>};<ESC>O", { noremap = true })