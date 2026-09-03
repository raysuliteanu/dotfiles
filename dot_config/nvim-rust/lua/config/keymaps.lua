-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- move selected text up and down like IntelliJ <c-shift-up/down>
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- join line with next but keep cursor at current location
vim.keymap.set("n", "J", "mzJ`z")

-- paste over selected text without 'destroying' what's in the default register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Navigate to next diagnostic with F2
vim.keymap.set("n", "<F2>", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
