-- Cmds
local open_zellij_sessions_cmd = '<cmd>silent !zellij action launch-or-focus-plugin zellij:session-manager --floating<cr>'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>cj', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '<leader>ck', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- w [Window manipulation]
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>wv', '<CMD>:vsplit<CR>', { desc = 'Split Window vertical' })
vim.keymap.set('n', '<leader>ws', '<CMD>:split<CR>', { desc = 'Split Window horizontaly' })
vim.keymap.set('n', '<leader>wc', '<CMD>:close<CR>', { desc = 'Close Window' })
vim.keymap.set('n', '<leader>wh', '<CMD>:wincmd h<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>wj', '<CMD>:wincmd j<CR>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>wk', '<CMD>:wincmd k<CR>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>wl', '<CMD>:wincmd l<CR>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>wr', '<CMD>:wincmd r<CR>', { desc = 'Swap Windows' })

-- j [ Utils collection ]
vim.keymap.set('n', '<leader>jw', '<CMD>:only<CR>', { desc = 'Maximize current window' })
vim.keymap.set('n', '<leader>jp', open_zellij_sessions_cmd, { desc = 'Open zellij Session manager' })

-- d ["workspaces"]
vim.keymap.set('n', '<leader>dj', '<CMD>silent !zellij action go-to-tab 1<CR>', { desc = 'Zellij change to tab 1' })
vim.keymap.set('n', '<leader>dk', '<CMD>silent !zellij action go-to-tab 2<CR>', { desc = 'Zellij change to tab 2' })
vim.keymap.set('n', '<leader>dl', '<CMD>silent !zellij action go-to-tab 3<CR>', { desc = 'Zellij change to tab 3' })
vim.keymap.set('n', '<leader>dç', '<CMD>silent !zellij action go-to-tab 4<CR>', { desc = 'Zellij change to tab 4' })

-- "zellij action go-to-tab 1"

-- b [Buffer]
vim.keymap.set('n', '<leader>bp', '<CMD>:bprevious<CR>', { desc = 'Buffer previous' })
vim.keymap.set('n', '<leader>bn', '<CMD>:bnext<CR>', { desc = 'Buffer next' })
vim.keymap.set('n', '<leader>bN', '<CMD>:enew<CR>', { desc = 'Buffer new' })
vim.keymap.set('n', '<leader>bd', '<CMD>:bd<CR>', { desc = 'Buffer delete' })

vim.keymap.set('n', '<leader>fd', vim.cmd.ex)
vim.keymap.set('n', '<leader>fs', vim.cmd.w)
vim.keymap.set('n', '<leader>fw', function()
  local ok, res = pcall(vim.cmd.w)
  if ok then
    return
  elseif res:match '^Vim%(write%):E32:' then
    ok, res = pcall(vim.fn.input, 'File name: ')
    if ok and res and res ~= '' then
      vim.cmd('write ' .. res)
    end
  else
    vim.api.nvim_err_writeln(res)
  end
end)
vim.keymap.set('n', '<leader>qq', vim.cmd.qa)
vim.keymap.set('n', '<leader>pp', open_zellij_sessions_cmd, { desc = 'Open zellij Session manager' })

vim.keymap.set('n', '<leader>sr', [[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>]], { desc = 'Replace current word' })
--vim.keymap.set("n", "<leader>qQ", vim.exit)

-- Comiler
-- vim.api.nvim_set_keymap('n', '<leader>cc', '<CMD>CompilerOpen<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>cu', '<cmd>CompilerStop<cr>' .. '<cmd>CompilerRedo<cr>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>ci', '<cmd>CompilerToggleResults<cr>', { noremap = true, silent = true })
