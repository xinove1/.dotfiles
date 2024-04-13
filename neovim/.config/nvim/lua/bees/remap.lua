vim.g.mapleader = " "

-- Buffer
vim.keymap.set("n", "<leader>bp", "<CMD>:bprevious<CR>")
vim.keymap.set("n", "<leader>bn", "<CMD>:bnext<CR>")

-- Window
vim.keymap.set("n", "<leader>wv", "<CMD>:vsplit<CR>")
vim.keymap.set("n", "<leader>ws", "<CMD>:split<CR>")
vim.keymap.set("n", "<leader>wc", "<CMD>:close<CR>")
vim.keymap.set("n", "<leader>wh", "<CMD>:wincmd h<CR>")
vim.keymap.set("n", "<leader>wj", "<CMD>:wincmd j<CR>")
vim.keymap.set("n", "<leader>wk", "<CMD>:wincmd k<CR>")
vim.keymap.set("n", "<leader>wl", "<CMD>:wincmd l<CR>")
vim.keymap.set("n", "<leader>jw", "<CMD>:only<CR>")

vim.keymap.set("n", "<leader>fd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>fs", vim.cmd.w)
vim.keymap.set("n", "<leader>qq", vim.cmd.q)
vim.keymap.set("n", "<leader>pp", "<CMD>silent !zellij run -fc -- zellij-sessionizer<CR>")
--vim.keymap.set("n", "<leader>qq", vim.exit)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- TODO Change this to its on sub thing
vim.keymap.set("x", "<leader>P", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["_d]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
--vim.keymap.set("n", "<leader>Y", [["+Y]])

-- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>hf", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
--vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

--vim.keymap.set("n", "<leader><leader>", function()
--    vim.cmd("so")
--end)
