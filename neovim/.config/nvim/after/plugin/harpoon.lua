local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")
local cmd_ui = require("harpoon.cmd-ui")

-- File nav
vim.keymap.set("n", "<leader>aa", mark.add_file)
vim.keymap.set("n", "<leader>aq", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>aj", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>ak", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>al", function() ui.nav_file(3) end)

-- Term nav
vim.keymap.set("n", "<leader>jv", function () term.gotoTerminal(1) end)
vim.keymap.set("n", "<leader>js", cmd_ui.toggle_quick_menu)
