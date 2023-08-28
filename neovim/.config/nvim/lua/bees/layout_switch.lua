local group = vim.api.nvim_create_augroup("layout_switcher", {clear = true})
vim.api.nvim_create_autocmd("InsertLeave", { command = "silent !setxkbmap br", group = group})
vim.api.nvim_create_autocmd("InsertEnter", { command = "silent !setxkbmap us -variant dvorak", group = group})
