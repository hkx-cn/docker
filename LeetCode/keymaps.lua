-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_create_user_command("Quit", function()
  vim.cmd [[ wall | if &buftype == 'quickfix' | cclose | elseif &buftype == 'prompt' | quit! | else | quit | endif ]]
end, { desc = 'Quit current window' })
vim.keymap.set("n", "q", "<cmd>Quit<CR>", { silent = true })
vim.keymap.set("v", "q", "<Esc>", { silent = true })
vim.keymap.set("n", "Q", "q", { silent = true, noremap = true })
vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("i", "kj", "<Esc>", { silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "kj", "<C-\\><C-n>", { silent = true })
