local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

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
keymap("n", "k", [[(v:count > 5 ? "m'" . v:count: "") . 'k']], { noremap = true, expr = true })
keymap("n", "j", [[(v:count > 5 ? "m'" . v:count: "") . 'j']], { noremap = true, expr = true })
keymap("n", "<C-d>", "m'<C-d>", opts)
keymap("n", "<C-d>", "m'<C-d>", opts)
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

-------------- Plugins ---------------
-- lsp
keymap("n", "gl", vim.diagnostic.open_float, opts)
keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "gq", vim.diagnostic.setloclist, opts)
-- telescope
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>tl", ":Telescope live_grep<CR>", opts) -- require "ripgrep"
keymap("n", "<leader>tp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>tb", ":Telescope buffers<CR>", opts)
-- dap
keymap("n", "<leader>dp", ":DapToggleBreakpoint<CR>", opts)
keymap("n", "<leader>dc", ":DapContinue<CR>", opts)
keymap("n", "<leader>di", ":DapStepInto<CR>", opts)
keymap("n", "<leader>do", ":DapStepOver<CR>", opts)
keymap("n", "<leader>dO", ":DapStepOut<CR>", opts)
keymap("n", "<leader>dr", ":DapToggleRepl<CR>", opts)
keymap("n", "<leader>dx", ":DapTerminate<CR>", opts)
keymap("n", "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", opts)
-- nvim tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- toggle term
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
