# Neovim Config

Personal Neovim configuration from my dotfiles repository.

This setup is built around:
- `lazy.nvim` for plugin management
- a modular `lua/config` + `lua/plugins` layout
- `mason.nvim` for installing LSP servers and developer tools
- `conform.nvim` for formatting
- `nvim-treesitter` for syntax highlighting

It is intended to stay readable, easy to change, and easy to extend when adding new languages or tools.

## Compatibility

This configuration is intended for:
- Neovim `0.11.x`

Current tested target:
- Neovim `0.11.5`

Older versions are not supported because the LSP setup uses the Neovim `0.11` API (`vim.lsp.config` and `vim.lsp.enable`).

## Features

- Modular configuration layout
- Automatic plugin installation with `lazy.nvim`
- Automatic LSP/tool installation with Mason
- Formatting on save through Conform
- Treesitter syntax highlighting
- Telescope for search and navigation
- Neo-tree as the file explorer
- Theme switching from a central UI module
- Optional floating terminal integrations such as `lazygit`

## Installation

Neovim should use this directory as its config root:

- Linux/macOS: `~/.config/nvim`
- or via `XDG_CONFIG_HOME`

Clone or sync this folder into your Neovim config location, then start Neovim:

```sh
nvim
```

On first run:
- `lazy.nvim` installs missing plugins
- Mason installs configured LSP servers and tools

Useful follow-up commands:

```vim
:Lazy sync
:Mason
:MasonToolsInstall
:checkhealth
```

## External Dependencies

Recommended tools:

- `git`
- `make`
- `ripgrep`
- `fd`
- a Nerd Font
- clipboard provider for your OS

Language-specific tools depend on what you enable. For example:

- Go tooling requires `go`
- TypeScript / JavaScript tooling requires `node` and `npm`

## Project Structure

```text
nvim/
├── init.lua
├── lazy-lock.json
└── lua/
    ├── config/
    │   ├── autocmds.lua
    │   ├── globals.lua
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   └── options.lua
    └── plugins/
        ├── completion.lua
        ├── debug.lua
        ├── editor.lua
        ├── explorer.lua
        ├── formatting.lua
        ├── lint.lua
        ├── lsp.lua
        ├── terminal.lua
        └── ui.lua
```

## How It Loads

Entry point:
- `init.lua`

Boot order:

1. `lua/config/globals.lua`
2. `lua/config/options.lua`
3. `lua/config/keymaps.lua`
4. `lua/config/autocmds.lua`
5. `lua/config/lazy.lua`

`lua/config/lazy.lua` bootstraps `lazy.nvim` and imports every plugin spec from:

- `lua/plugins/*.lua`

That means:
- core editor behavior lives in `config/*`
- plugin-specific behavior lives in `plugins/*`

## What Goes Where

### `lua/config`

Use this directory for base editor configuration that does not belong to one plugin.

- `globals.lua`
  - global variables
  - leader keys
  - built-in plugin toggles such as `netrw`

- `options.lua`
  - `vim.opt` and editor options

- `keymaps.lua`
  - global keymaps not tied to a plugin API

- `autocmds.lua`
  - general-purpose autocommands

- `lazy.lua`
  - `lazy.nvim` bootstrap and plugin import

### `lua/plugins`

Use this directory for plugin specs and plugin-specific configuration.

- `ui.lua`
  - theme plugins
  - Telescope
  - which-key
  - colorscheme selection logic

- `lsp.lua`
  - LSP server definitions
  - Mason integration
  - LSP keymaps on attach

- `formatting.lua`
  - Conform setup
  - filetype-to-formatter mapping

- `editor.lua`
  - Treesitter
  - gitsigns
  - editor enhancement plugins

- `explorer.lua`
  - Neo-tree configuration

- `completion.lua`
  - completion engine and snippets

- `lint.lua`
  - linting setup

- `debug.lua`
  - DAP and debugger integration

- `terminal.lua`
  - terminal-related plugins or floating terminal integrations

## Adding a New Language

In most cases, adding language support means updating three places:

### 1. Add the LSP server

Edit:
- `lua/plugins/lsp.lua`

Add the server to the `servers` table.

Example:

```lua
rust_analyzer = {},
```

If the server needs custom settings:

```lua
rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      cargo = { allFeatures = true },
    },
  },
},
```

### 2. Add a formatter

Edit:
- `lua/plugins/formatting.lua`

Map the filetype to one or more formatters.

Example:

```lua
rust = { 'rustfmt' },
```

If Mason should install the formatter automatically, also add it to:
- `lua/plugins/lsp.lua`

inside `mason-tool-installer`.

### 3. Add Treesitter highlighting

Edit:
- `lua/plugins/editor.lua`

Add the parser name to `ensure_installed`.

Example:

```lua
'rust',
```

## Supported Language Setup

Current config includes support for:

- Lua
- Go
- TypeScript
- JavaScript
- JSON
- YAML
- Cucumber / Gherkin via `cucumber_language_server`

Depending on filetype, this includes:
- LSP
- formatting
- Treesitter highlighting where a parser exists

## Themes

Colorscheme logic is centralized in:
- `lua/plugins/ui.lua`

This file contains:
- installed colorscheme names
- the default colorscheme
- colorscheme switching helpers

To change the default theme, edit:

```lua
local default_colorscheme = '...'
```

## Notes

- `lazy-lock.json` should be committed if you want reproducible plugin versions.
- If startup errors appear before plugin loading completes, plugin-dependent configuration may not finish initializing.
- For debugging startup issues, use:

```vim
:checkhealth
:messages
:Lazy
:LspInfo
```
