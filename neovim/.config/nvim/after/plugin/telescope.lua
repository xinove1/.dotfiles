local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader><Space>", builtin.find_files)
vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>")
vim.keymap.set("n", "<leader>fw", builtin.live_grep)
vim.keymap.set('n', '<leader>pa', builtin.grep_string, {})
vim.keymap.set('n', '<leader>pS', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
vim.keymap.set('n', '<leader>hf', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ht', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>hm', builtin.man_pages, {})
vim.keymap.set('n', '<leader>:', builtin.commands, {})
require('telescope').load_extension("file_browser")
require('telescope').load_extension("fzf")
require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-d>"] = "which_key",
                ["<C-h>"] = "move_selection_next",
                ["<C-t>"] = "move_selection_previous",
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
            theme = "ivy"
        }
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}
