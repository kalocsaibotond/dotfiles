-- This is a temporary conform.nvim csharpier hotfix for the omnisharp extra
-- It overrides obsolete csharpier configuration.
-- The issue is described here:
-- https://github.com/stevearc/conform.nvim/issues/699

return {
	"stevearc/conform.nvim",
	optional = true,
	opts = function(_, opts)
		local use_dotnet = not vim.fn.executable("csharpier")

		local command = use_dotnet and "dotnet csharpier" or "csharpier"

		local version_out = vim.fn.system(command .. " --version")
		local major_version = tonumber((version_out or ""):match("^(%d+)"))
			or 0
		local is_new = major_version >= 1

		local args = is_new and { "format", "$FILENAME" }
			or { "--write-stdout" }

		-- vim.notify("Csharpier " .. version_out)

		opts.formatters.csharpier = {
			command = command,
			args = args,
			stdin = not is_new,
			require_cwd = false,
		}
	end,
}
