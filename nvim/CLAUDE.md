# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration repository using lazy.nvim as the plugin manager. The configuration is structured with a modular approach, separating core settings, keymaps, LSP configuration, and plugins into distinct files. Targets Neovim 0.12+.

## Architecture

### Entry Point
- `init.lua` - Bootstraps lazy.nvim and imports core modules + the three plugin directories

### Core Modules (lua/core/)
- `options.lua` - Vim options (leader keys, line numbers, tabs/spaces, colorcolumn, etc.)
- `keymaps.lua` - Global keymaps outside of plugin-specific bindings
- `autocmd.lua` - Autocommands (currently: highlight on yank)

### Plugin Organization
Plugins are lazy-loaded (via `event`/`ft`/`keys`/`cmd` triggers) and organized into three directories:
- `lua/plugins/` - General plugins (telescope, conform, treesitter, snacks, etc.)
- `lua/plugins/lsp/` - LSP configuration and related plugins
- `lua/plugins/language/` - Language-specific plugins (python, angular)

### Key Plugin Structure
- **LSP Setup**: `lua/plugins/lsp/lsp.lua` uses mason, mason-lspconfig (v2), and nvim-lspconfig. nvim-lspconfig is deferred to `BufReadPre`/`BufNewFile`.
- **LSP Keymaps**: Configured via LspAttach autocmd with `gr*` prefix (grn=rename, gra=code action, grr=references, grd=definition, etc.)
- **Completion**: blink.cmp with LuaSnip as the snippet engine
- **Formatting**: conform.nvim with format-on-save enabled (except C/C++)
- **Linting**: nvim-lint runs on BufEnter, BufWritePost, InsertLeave
- **Debugging**: nvim-dap configured primarily for Go (delve) and Python (debugpy)
- **UI**: snacks.nvim provides `vim.ui.select` and `vim.ui.input`

## Language Servers

mason-lspconfig v2 with `automatic_enable` enables installed servers; per-server config is applied via `vim.lsp.config` (NOT the old `handlers`/`lspconfig.setup` pattern). `stylua` is excluded from `automatic_enable` (it's a formatter, not an LSP).

Configured in the `servers` table (`lsp/lsp.lua`):
- `gopls` - Go (with gofumpt formatting, staticcheck, inlay hints)
- `lua_ls` - Lua
- `ts_ls` - TypeScript/JavaScript
- `pyright` - Python (type checking)
- `bashls` - Bash/Zsh
- `dockerls`, `docker_compose_language_service`
- `yamlls`, `jsonls`
- `html`, `cssls`, `emmet_ls`
- `angularls`, `postgres_lsp`

Auto-enabled (installed via mason, not in the `servers` table):
- `eslint` - JS/TS linting via LSP, with fix-on-save (`LspEslintFixAll` on `BufWritePre`)
- `ruff` - Python linting + code actions via LSP

## Development Tools

**Formatters** (via conform.nvim):
- `stylua` - Lua
- `gofumpt` - Go
- `ruff_format` - Python
- `prettierd` / `prettier` - JS/TS/HTML/CSS/JSON/YAML/Markdown
- `standardrb` - Ruby

**Linters** (via nvim-lint):
- `markdownlint` - Markdown
- `golangcilint` - Go
- `shellcheck` - sh/bash/zsh
- `standardrb` - Ruby

Note: JS/TS linting is handled by the eslint LSP (not nvim-lint), and Python linting by the ruff LSP.

## Treesitter

On the `main` branch (the legacy `master` branch is archived), configured minimally in `treesitter.lua`:
- `lazy = false` (the main-branch rewrite does not support lazy-loading)
- Parsers installed via `require('nvim-treesitter').install{...}`
- Highlighting via the Neovim builtin `vim.treesitter.start()` in a FileType autocmd
- No textobjects module; indentation relies on builtin `smartindent`

**Requires the `tree-sitter` CLI** to compile parsers. Installed via `cargo install tree-sitter-cli --no-default-features` (the prebuilt mason/npm binaries require a newer glibc than this system has).

## Key Bindings

### Global
- `<leader>` = Space, `<localleader>` = `\`
- `<leader>w` - Write file
- `<leader>q` - Quit
- `<leader>f` - Format buffer
- `<leader>pv` - Open Oil file explorer
- `<leader>y` (visual) - Yank to system clipboard
- `<C-h/j/k/l>` - Navigate windows/tmux panes (vim-tmux-navigator)
- `<C-n>` / `<C-p>` - Next/previous buffer
- `<leader>bc` - Close buffer

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
- `<leader>th` - Toggle inlay hints

### Telescope
- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader>sw` - Search word under cursor
- `<leader>sh` - Search help
- `<leader>sd` - Search diagnostics
- `<leader>sn` - Search Neovim config files
- `<leader><leader>` - Find buffers
- `<leader>/` - Fuzzy find in current buffer

### Debugging
- `<F5>` - Continue/Start debugging
- `<F1>` - Step into
- `<F2>` - Step over
- `<F3>` - Step out
- `<F7>` - Toggle DAP UI
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Set conditional breakpoint

### Python (neotest)
- `<leader>tn` - Test nearest, `<leader>tf` - Test file, `<leader>td` - Debug test, `<leader>ts` - Summary, `<leader>to` - Output

## Configuration Details

### Tab Settings
- Tabs converted to spaces (expandtab=true)
- Tab display width / indent width: 2 spaces (tabstop, softtabstop, shiftwidth all = 2)
- smartindent enabled

### Key Features
- Mouse disabled (keyboard-centric workflow)
- Relative line numbers enabled
- Persistent undo enabled
- Case-insensitive search (smartcase)
- Sign column always visible
- colorcolumn at 80
- Format on save enabled (via conform.nvim)
- Auto-highlight on yank
- Vertical layout for Telescope
- Rounded window borders globally (`winborder`)

## Adding New Plugins

1. Create a new file in `lua/plugins/`, `lua/plugins/lsp/`, or `lua/plugins/language/`
2. Return a table with the plugin spec (lazy.nvim format)
3. Include a lazy trigger (`event`/`ft`/`keys`/`cmd`) unless the plugin must load at startup
4. Plugin will be auto-loaded via the `import` directives in `init.lua`

## Adding New LSP Servers

Edit `lua/plugins/lsp/lsp.lua`:
1. Add the server name to the `servers` table with optional configuration (applied via `vim.lsp.config`)
2. Add the mason package to the `ensure_installed` table if it isn't already installed
3. Mason will auto-install on next Neovim start; `automatic_enable` enables it
