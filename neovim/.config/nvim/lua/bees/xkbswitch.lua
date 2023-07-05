-- stolen from https://raw.githubusercontent.com/ivanesmantovich/xkbswitch.nvim/master/lua/xkbswitch.lua
local M = {}
-- nvim_create_autocmd shortcut
local autocmd = vim.api.nvim_create_autocmd
local xkb_switch_lib = nil

-- g3kb-switch
if vim.fn.filereadable('/usr/local/lib64/libg3kbswitch.so') == 1 then
	xkb_switch_lib = '/usr/local/lib64/libg3kbswitch.so'
elseif vim.fn.filereadable('/usr/local/lib/libg3kbswitch.so') == 1 then
	xkb_switch_lib = '/usr/local/lib/libg3kbswitch.so'
else
	-- xkb-switch
	local all_libs_locations = vim.fn.systemlist('ldd $(which xkb-switch)')
	for _, value in ipairs(all_libs_locations) do
		if string.find(value, 'libxkbswitch.so.1') then
			if string.find(value, 'not found') then
				xkb_switch_lib = nil
			else
				xkb_switch_lib = string.sub(
				value, string.find(value, "/"), string.find(value, "%(") - 2
				)
			end
		end
	end
end

if xkb_switch_lib == nil then
    error("(xkbswitch.lua) Error occured: layout switcher file was not found.")
end

function M.setup()
    -- When leaving insert mode:
    -- 1. Save the current layout
    -- 2. Switch to the US layout
    autocmd(
        'InsertLeave',
        {
            pattern = "*",
            callback = function()
                vim.schedule(function()
			vim.cmd("silent exec '!setxkbmap br'")
			print(vim.api.nvim_buf_get_name(0))
                    --vim.fn.libcall(xkb_switch_lib, 'Xkb_Switch_setXkbLayout', 'br')
                end)
            end
        }
    )

    -- When entering Insert mode:
    -- 1. Switch to the previously saved layout
    autocmd(
        'InsertEnter',
        {
            pattern = "*",
            callback = function()
                vim.schedule(function()
			vim.cmd("silent exec '!setxkbmap dvorak'")
			print(vim.api.nvim_buf_get_name(0))
--                    vim.fn.libcall(xkb_switch_lib, 'Xkb_Switch_setXkbLayout', 'dvorak')
                end)
            end
        }
    )
end

return M
