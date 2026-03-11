-- telescope keymaps
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Grep in Files" })

-- mason keymaps
vim.keymap.set("n", "<leader>m", ":Mason<CR>", { noremap = true, silent = true })

-- neo tree keymaps
vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle left<CR>")
