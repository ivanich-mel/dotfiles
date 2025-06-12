return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      ignored = true, -- Следовать по симлинкам при навигации
      auto_hide = { "input" },
      focus = "list",
      auto_close = true,
    },
    picker = {
      sources = {
        explorer = {
          ignored = true, -- Следовать по симлинкам при навигации
          layout = {
            auto_hide = { "input" },
            focus = "list",
            auto_close = true,
          },
        },
      },
    },
  },
}
