-- Cmds
local open_zellij_sessions_cmd = "<cmd>silent !zellij action launch-or-focus-plugin zellij:session-manager --floating<cr>"

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- w [Window manipulation]
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<leader>wv", "<CMD>:vsplit<CR>", {desc = 'Split Window vertical'})
vim.keymap.set("n", "<leader>ws", "<CMD>:split<CR>", {desc = 'Split Window horizontaly'})
vim.keymap.set("n", "<leader>wc", "<CMD>:close<CR>", {desc = 'Close Window'})
vim.keymap.set("n", "<leader>wh", "<CMD>:wincmd h<CR>", {desc = 'Move focus to the left window'})
vim.keymap.set("n", "<leader>wj", "<CMD>:wincmd j<CR>", {desc = 'Move focus to the lower window'})
vim.keymap.set("n", "<leader>wk", "<CMD>:wincmd k<CR>", {desc = 'Move focus to the upper window'})
vim.keymap.set("n", "<leader>wl", "<CMD>:wincmd l<CR>", {desc = 'Move focus to the right window'})

-- j [ Utils collection ]
vim.keymap.set("n", "<leader>jw", "<CMD>:only<CR>", {desc = 'Maximize current window'})
vim.keymap.set("n", "<leader>jp", open_zellij_sessions_cmd, {desc = 'Open zellij Session manager'})


-- b [Buffer]
vim.keymap.set("n", "<leader>bp", "<CMD>:bprevious<CR>")
vim.keymap.set("n", "<leader>bn", "<CMD>:bnext<CR>")
vim.keymap.set("n", "<leader>bN", "<CMD>:enew<CR>")
vim.keymap.set("n", "<leader>bd", "<CMD>:bd<CR>")

vim.keymap.set("n", "<leader>fd", vim.cmd.ex)
vim.keymap.set("n", "<leader>fs", vim.cmd.w)
vim.keymap.set('n', '<leader>fw', function()
  local ok, res = pcall(vim.cmd.w)
  if ok then
    return
  elseif res:match('^Vim%(write%):E32:') then
    ok, res = pcall(vim.fn.input, 'File name: ')
    if ok and res and res ~= '' then
      vim.cmd('write ' .. res)
    end
  else
    vim.api.nvim_err_writeln(res)
  end
end)
vim.keymap.set("n", "<leader>qq", vim.cmd.qa)
vim.keymap.set("n", "<leader>pp", open_zellij_sessions_cmd, {desc = 'Open zellij Session manager'})
--vim.keymap.set("n", "<leader>qQ", vim.exit)
