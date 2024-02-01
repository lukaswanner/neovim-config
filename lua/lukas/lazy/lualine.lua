return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local function truncate_branch_name(branch)
        if not branch or branch == "" then
          return ""
        end

        -- Match the branch name to the specified format
        local _, _, feature_name = string.find(branch, "feature/(%w+)")
        local _, _, bug_name = string.find(branch, "bugfix/(%w+)")

        -- If the branch name matches the format, display sko-{ticket_number}, otherwise display the full branch name
        if feature_name then
          return "f/" .. feature_name
        elseif bug_name then
          return "b/" .. bug_name
        else
          return branch
        end
      end

      require("lualine").setup({
        options = {
          theme = "rose-pine",
          globalstatus = true,
          component_separators = { left = "█", right = "█" },
          section_separators = { left = "█", right = "█" },
        },
        sections = {
          lualine_b = {
            { "branch", icon = "", fmt = truncate_branch_name },
            "diff",
            "diagnostics",
          },
          lualine_c = {
            { "filename", path = 1 },
          },
          lualine_x = {
            "filetype",
          },
        },
      })
    end,
  },
}
