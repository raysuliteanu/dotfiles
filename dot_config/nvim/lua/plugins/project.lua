return {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			-- All the patterns used to detect root dir, when **"pattern"** is in
			-- detection_methods
			patterns = { ".git", ".jj", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".idea", "build.gradle" },

			-- Don't calculate root dir on specific directories
			-- Ex: { "~/.cargo/*", ... }
			exclude_dirs = {},

			-- When set to false, you will get a message when project.nvim changes your directory.
			silent_chdir = false,

			-- What scope to change the directory, valid options are
			-- * global (default)
			-- * tab
			-- * win
			scope_chdir = "tab",
		})
	end,
}
