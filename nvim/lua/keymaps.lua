local map = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Better movement
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>")
map("n", "<S-l>", "<cmd>bnext<cr>")
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<cr><Esc>")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==")
map("n", "<A-k>", "<cmd>m .-2<cr>==")
map("v", "<A-j>", ":m '>+1<cr>gv=gv")
map("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- Quickfix
map("n", "[q", "<cmd>cprev<cr>")
map("n", "]q", "<cmd>cnext<cr>")

-- Diagnostic navigation
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Save
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><Esc>", { desc = "Save file" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Telescope
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
