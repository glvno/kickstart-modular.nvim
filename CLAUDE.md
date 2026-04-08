# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modular Neovim configuration based on [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim), a fork of the popular kickstart.nvim that splits configuration from a single file into multiple modules. The configuration is written entirely in Lua.

## Architecture & Structure

### Entry Point
- **`init.lua`**: Main entry point that sets leader keys, loads options, keymaps, lazy.nvim bootstrap, and plugin configurations. Also configures the Expert LSP for Elixir development.

### Configuration Organization

The configuration is split into modular files under the `lua/` directory:

- **`lua/options.lua`**: Neovim editor options (line numbers, mouse, clipboard sync, indentation, search behavior, UI settings, etc.)
- **`lua/keymaps.lua`**: Basic keymaps (navigation, terminal mode, autocommands for yanking). Also contains custom keymaps for plugins like DiffView, NoNeckPain, and Telescope.
- **`lua/lazy-bootstrap.lua`**: Bootstraps lazy.nvim plugin manager
- **`lua/lazy-plugins.lua`**: Entry point for plugin specifications using `lazy.nvim`

### Plugin Architecture

Plugins are organized in two locations:

1. **`lua/kickstart/plugins/`**: Core plugins (bundled with kickstart-modular)
   - `lspconfig.lua` - LSP configuration with Mason language server installation
   - `telescope.lua` - Fuzzy finder with builtin keymaps
   - `conform.lua` - Code formatting
   - `blink-cmp.lua` - Completion engine
   - `treesitter.lua` - Syntax highlighting and AST
   - `tokyonight.lua` - Color scheme
   - `which-key.lua` - Keymap hints
   - `gitsigns.lua` - Git integration
   - `debug.lua` - DAP (debugger) configuration
   - `mini.lua` - Various mini plugins (statusline, surround, etc.)
   - `autopairs.lua` - Auto-closing brackets
   - `indent_line.lua` - Visual indent guides
   - `lint.lua` - Linting integration
   - `neo-tree.lua` - File tree (disabled by default)
   - `todo-comments.lua` - Highlight TODO comments
   - `health.lua` - Plugin health checks

2. **`lua/custom/plugins/init.lua`**: User-added plugins and custom configurations
   - Rainbow bracket highlighting (rainbow-delimiters)
   - Hop.nvim for character-based jumping
   - nvim-ts-autotag for auto-closing HTML tags
   - Bufferline for tab/buffer management
   - Color schemes (gruvbox-material, everforest, seoul256)
   - DiffView for git diffs
   - Undotree for undo visualization
   - Treesitter context for sticky function signatures
   - NoNeckPain for centered editing
   - nvim-notify and noice.nvim for notifications
   - Rustaceanvim for Rust support
   - vimtex for LaTeX support
   - Obsidian.nvim for Logseq integration
   - Better-escape for faster escape sequences
   - And more...

### Plugin Management

- **Package Manager**: lazy.nvim - plugins are installed lazily based on file types, events, and commands
- **Lock File**: `lazy-lock.json` - tracks plugin versions (should be committed to version control)
- **Configuration**: Plugins are loaded with `require('lazy').setup()` in `lua/lazy-plugins.lua`

### Code Style

- **Code Formatter**: Lua files are formatted with stylua
- **Stylua Config** (`.stylua.toml`):
  - Column width: 160
  - Line endings: Unix
  - Indent: 2 spaces
  - Quote style: Auto (prefer single quotes)
  - Call parentheses: None

## Important Keymaps

Most keymaps are defined in plugin configurations and can be discovered with:
- `<space>sh` - Search Neovim help documentation
- `<space>sk` - Search keymaps via Telescope
- `<space>tk` - Telescope keymaps picker

Core navigation (from `lua/keymaps.lua`):
- `<C-h/j/k/l>` - Window navigation
- `Esc` - Clear search highlighting
- `<Esc><Esc>` - Exit terminal mode

Plugin-specific keymaps:
- `<space>npt` / `<space>npu` / `<space>npd` - NoNeckPain toggle and width adjustment
- `<space>tu` - Undotree toggle
- `<space>dvo/dvc/dvf/dvb` - DiffView commands
- `<space>bp` / `<space>bk` - Buffer/tab picking
- `s` - Hop character jump (in normal and visual modes)

## Development Notes

### LSP Configuration

LSP is configured in `lua/kickstart/plugins/lspconfig.lua` with:
- **Mason**: Automatic LSP installation and management
- **Capabilities**: blink.cmp integration for better completions
- **Language Servers**: Configured via Mason. Expert LSP is set up in `init.lua` for Elixir development with root markers `mix.exs` and `.git`

Key LSP keymaps (attached to each buffer):
- `grn` - Rename symbol
- `<leader>gca` - Code action
- `<leader>gr` - Find references
- `<leader>gi` - Find implementations
- `<leader>gd` - Goto definition
- `<leader>gD` - Goto declaration

### Formatting

Code formatting is handled by conform.nvim (`lua/kickstart/plugins/conform.lua`). Add formatters per filetype through Mason.

### Completion

Blink.cmp is the completion engine (`lua/kickstart/plugins/blink-cmp.lua`), providing:
- LSP completion
- Snippet support (via luasnip)
- Buffer completion
- Keyword completion

## Dependencies

Required system tools (per README):
- `git`, `make`, `gcc` (C compiler)
- `ripgrep` (for Telescope grep)
- `fd-find` (for file finding)
- Clipboard tool (xclip/xsel/win32yank)
- Optional: Nerd Font (for icons)

Language-specific:
- Typescript: `npm`
- Go: `go`
- Rust: Installed via rustup (rustaceanvim manages it)
- Elixir: Expert LSP (referenced in init.lua)

## Common Tasks

### Adding a new plugin

1. Add plugin spec to `lua/custom/plugins/init.lua` following lazy.nvim format
2. Configure via `config = function()` blocks
3. Set dependencies if needed
4. Use events/filetypes for lazy loading

### Configuring LSP for a new language

1. Ensure language executable is available
2. LSP will be auto-installed by Mason
3. Configure in `lspconfig` setup within `lua/kickstart/plugins/lspconfig.lua` if custom settings needed

### Formatting and linting

- Formatters: Configure through Conform in `lua/kickstart/plugins/conform.lua`
- Linters: Configure through Lint in `lua/kickstart/plugins/lint.lua`

### Extending keymaps

- Global keymaps: Add to `lua/keymaps.lua`
- LSP keymaps: Modify the `LspAttach` autocmd in `lspconfig.lua`
- Plugin keymaps: Configure within plugin's `config` function

## Special Configuration

The `init.lua` file includes:
- Expert LSP setup for Elixir with stdio transport
- Manual LSP configuration using Neovim 0.11+ API: `vim.lsp.config()` and `vim.lsp.enable()`
- Comment about alternative Lexical setup (currently disabled)

## References

- `init.lua` contains extensive inline comments explaining configuration concepts
- Full Neovim Lua guide: `:help lua-guide`
- Plugin documentation: Check each plugin's GitHub repository
- Lazy.nvim plugin spec format: `:help lazy.nvim-plugin-spec`
