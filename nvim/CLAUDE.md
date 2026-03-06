# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration repository using lazy.nvim as the plugin manager. The configuration is structured with a modular approach, separating core settings, keymaps, LSP configuration, and plugins into distinct files.

## Architecture

### Entry Point
- `init.lua` - Main entry point that bootstraps lazy.nvim and imports core modules

### Core Modules (lua/core/)
- `options.lua` - Vim options (leader key, line numbers, tabs/spaces, colors, etc.)
- `keymaps.lua` - Global keymaps outside of plugin-specific bindings
- `autocmd.lua` - Autocommands (highlight on yank, floating window test)

### Plugin Organization
Plugins are lazy-loaded and organized into three directories:
- `lua/plugins/` - General plugins (telescope, conform, treesitter, etc.)
- `lua/plugins/lsp/` - LSP configuration and related plugins
- `lua/plugins/language/` - Language-specific plugins (Go, etc.)

### Key Plugin Structure
- **LSP Setup**: `lua/plugins/lsp/lsp.lua` contains the main LSP configuration using mason, mason-lspconfig, and nvim-lspconfig
- **LSP Keymaps**: Configured via LspAttach autocmd with `gr*` prefix (grn=rename, gra=code action, grr=references, grd=definition, etc.)
- **Formatting**: Handled by conform.nvim with format-on-save enabled (except C/C++)
- **Linting**: nvim-lint runs on BufEnter, BufWritePost, InsertLeave
- **Debugging**: nvim-dap configured primarily for Go with delve debugger

## Language Servers

Currently configured LSP servers (auto-installed via mason):
- `gopls` - Go (with gofumpt formatting)
- `lua_ls` - Lua
- `ts_ls` - TypeScript/JavaScript
- `bashls` - Bash/Zsh
- `dockerls`, `docker_compose_language_service`
- `yamlls`, `jsonls`
- `angularls`, `pylsp`, `postgres_lsp`

## Development Tools

**Formatters** (via conform.nvim):
- `stylua` - Lua formatting
- `gofumpt` - Go formatting

**Linters** (via nvim-lint):
- `eslint_d` - TypeScript/JavaScript
- `golangci-lint` - Go
- `markdownlint` - Markdown

## Key Bindings

### Global
- `<leader>` = Space
- `<leader>w` - Write file
- `<leader>q` - Quit
- `<leader>f` - Format buffer
- `<leader>pv` - Open Oil file explorer
- `<C-h/j/k/l>` - Navigate between windows

### LSP (after LSP attaches)
- `grn` - Rename symbol
- `gra` - Code action
- `grr` - Find references
- `grd` - Go to definition
- `grD` - Go to declaration
- `gri` - Go to implementation
- `grt` - Go to type definition
- `gO` - Document symbols
- `gW` - Workspace symbols

### Telescope
- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader>sw` - Search word under cursor
- `<leader>sh` - Search help
- `<leader>sd` - Search diagnostics
- `<leader><leader>` - Find buffers
- `<leader>/` - Fuzzy find in current buffer

### Debugging (Go)
- `<F5>` - Continue/Start debugging
- `<F1>` - Step into
- `<F2>` - Step over
- `<F3>` - Step out
- `<F7>` - Toggle DAP UI
- `<leader>b` - Toggle breakpoint
- `<leader>B` - Set conditional breakpoint

## Configuration Details

### Tab Settings
- Tabs converted to spaces (expandtab=true)
- Tab display width: 2 spaces
- Auto-indent width: 4 spaces

### Key Features
- Mouse disabled (keyboard-centric workflow)
- Relative line numbers enabled
- Persistent undo enabled
- Case-insensitive search (smartcase)
- Sign column always visible
- Format on save enabled (via conform.nvim)
- Auto-highlight on yank
- Vertical layout for Telescope
- Rounded window borders

## Adding New Plugins

1. Create a new file in `lua/plugins/`, `lua/plugins/lsp/`, or `lua/plugins/language/`
2. Return a table with plugin spec (lazy.nvim format)
3. Plugin will be auto-loaded via the `import` directives in `init.lua`

## Adding New LSP Servers

Edit `lua/plugins/lsp/lsp.lua`:
1. Add server name to the `servers` table with optional configuration
2. Add any additional tools to the `ensure_installed` table if needed
3. Mason will auto-install on next Neovim start
