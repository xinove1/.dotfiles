function ColorBees(color)
	--color = color or "catppuccin-mocha"
	color = color or "citruszest"
    -- TODO 
	--color = color or "kanagawa-dragon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
end

ColorBees()
