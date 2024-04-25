local harpoon = require("harpoon")
harpoon:setup({
    settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
    },
})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>kn", function() toggle_telescope(harpoon:list()) end, { desc = "Open Telec harpoon window" })
vim.keymap.set('n', '<leader>kj', function() harpoon:list():add() end, { desc = "Harpoon add file" })
vim.keymap.set('n', '<leader>kk', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon open window" })
vim.keymap.set('n', '<leader>ka', function() harpoon:list():select(1) end, { desc = "Harpoon jump to file 1" })
vim.keymap.set('n', '<leader>ks', function() harpoon:list():select(2) end, { desc = "Harpoon jump to file 2" })
vim.keymap.set('n', '<leader>kd', function() harpoon:list():select(3) end, { desc = "Harpoon jump to file 3" })
vim.keymap.set('n', '<leader>kf', function() harpoon:list():select(4) end, { desc = "Harpoon jump to file 4" })
vim.keymap.set('n', '<leader>kq', function() harpoon:list():select(5) end, { desc = "Harpoon jump to file 5" })
vim.keymap.set('n', '<leader>kw', function() harpoon:list():select(6) end, { desc = "Harpoon jump to file 6" })
vim.keymap.set('n', '<leader>ke', function() harpoon:list():select(7) end, { desc = "Harpoon jump to file 7" })
vim.keymap.set('n', '<leader>kr', function() harpoon:list():select(8) end, { desc = "Harpoon jump to file 8" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<leader>kh', function() harpoon:list():prev() end, { desc = "Harpoon previous file" })
vim.keymap.set('n', '<leader>kl', function() harpoon:list():next() end, { desc = "Harpoon next file" })
