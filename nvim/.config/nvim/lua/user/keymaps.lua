local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-------------- Normal  --------------
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-l>", ":bn<CR>", opts)
keymap("n", "<C-h>", ":bp<CR>", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("n", "k",[[(v:count > 5 ? "m'" . v:count: "") . 'k']], { noremap = true, expr = true })
keymap("n", "j",[[(v:count > 5 ? "m'" . v:count: "") . 'j']], { noremap = true, expr = true })
keymap("n", "<C-a>", "ggVG", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":Bd<CR>", opts)
keymap("n", "<leader>h", ":noh<CR>", opts)
-------------- Insert --------------
keymap("i", "{", "{<C-g>u", opts)
-------------- Visual --------------
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<A-k>", ":m .-2<CR>==gv", opts)
keymap("v", "<A-j>", ":m .+1<CR>==gv", opts)
keymap("v", "p", '"_dP', opts)
-------------- Visual Block ---------------
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
