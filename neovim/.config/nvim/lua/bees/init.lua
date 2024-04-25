require('bees.keymaps')
require('bees.set')
require('bees.harpoon')
--vim.cmd 'colorscheme rose-pine'
local themes = {"rose-pine", "kanagawa-dragon"}
vim.cmd('colorscheme ' .. themes[math.random(#themes)])
print('colothemes' .. themes[math.random(#themes)])
