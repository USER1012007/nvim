require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "H", "5h", { desc = "move left 5 chars" })
map("n", "L", "5l", { desc = "move right 5 chars" })
map("n", "J", "5j", { desc = "move down 5 lines" })
map("n", "K", "5k", { desc = "move up 5 lines" })

map("v", "H", "5h", { desc = "move left 5 chars" })
map("v", "L", "5l", { desc = "move right 5 chars" })
map("v", "J", "5j", { desc = "move down 5 lines" })
map("v", "K", "5k", { desc = "move up 5 lines" })


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
