local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local M = {}

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
-- dap
keymap("n", "<leader>dp", ":DapToggleBreakpoint<CR>", opts)
keymap("n", "<leader>dc", ":DapContinue<CR>", opts)
keymap("n", "<leader>di", ":DapStepInto<CR>", opts)
keymap("n", "<leader>do", ":DapStepOver<CR>", opts)
keymap("n", "<leader>dO", ":DapStepOut<CR>", opts)
keymap("n", "<leader>dr", ":DapToggleRepl<CR>", opts)
keymap("n", "<leader>dx", ":DapTerminate<CR>", opts)
keymap("n", "<leader>du", require("dapui").toggle, opts)
-- telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fl", ":Telescope live_grep<CR>", opts) -- require "ripgrep"
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
-- nvim tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- toggle term
keymap("n", "<leader>g", require("user.toggleterm").lazygit, opts)
-- lsp
keymap("n", "gl", vim.diagnostic.open_float, opts)
keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "gq", vim.diagnostic.setloclist, opts)

M.lsp_keymaps = function(bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Mappings.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
  keymap("n", "gd", vim.lsp.buf.definition, bufopts)
  keymap("n", "K", vim.lsp.buf.hover, bufopts)
  keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  keymap("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  keymap("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  keymap("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  keymap("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  keymap("n", "gr", vim.lsp.buf.references, bufopts)
end

return M
