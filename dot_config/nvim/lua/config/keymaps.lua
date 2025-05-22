-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "\\", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree viewer" })

-- from Primeagen https://raw.githubusercontent.com/ThePrimeagen/init.lua/master/lua/theprimeagen/remap.lua

-- move selected text up and down like IntelliJ <c-shift-up/down>
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- join line with next but keep cursor at current location
vim.keymap.set("n", "J", "mzJ`z")

-- paste over selected text without 'destroying' what's in the default register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- end Primeagen

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- take a screenshot of selectionm with ctrl-t
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>", { desc = "toggle terminal" })

-- Cloak.nvim keybindings
vim.keymap.set("n", "<leader>Ct", "<cmd>CloakToggle<cr>")

-- Navigate to next diagnostic with F2
vim.keymap.set("n", "<F2>", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
