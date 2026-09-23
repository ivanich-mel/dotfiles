return {
  -- Use Neovim's built-in command line instead of Noice's replacement UI.
  { "folke/noice.nvim", enabled = false },

  -- Keep completion in insert mode, but leave the command line fully native.
  {
    "saghen/blink.cmp",
    opts = {
      cmdline = { enabled = false },
    },
  },

  -- Open the default LazyVim file explorer in a floating window.
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
      },
      picker = {
        sources = {
          explorer = {
            jump = { close = true },
            layout = {
              preset = "vertical",
              preview = false,
            },
          },
        },
      },
    },
  },
}
