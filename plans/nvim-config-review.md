# Neovim Configuration Review

**Date:** 2026-05-29
**Scope:** Full review of `nvim/` (34 files, ~1688 lines)
**Environment:** nvim 0.12.2 stable, lazy.nvim, WSL2 (Debian 12)
**Measured startup:** ~112ms (headless)

This document lists optimizations, refactors, updates, and corrections,
prioritized by impact.

---

## ✅ Status: COMPLETED (2026-05-29)

All tiers addressed. **Startup: ~116ms median → ~31ms median (~73% faster), variance eliminated.**

| Item | Resolution |
|---|---|
| P1 #1 treesitter | ✅ Migrated to `main` branch (minimal); `tree-sitter` CLI built via cargo; highlight reliable |
| P1 #2 ghost LSPs | ✅ Uninstalled terraform-ls, gradle-language-server, golangci-lint-langserver |
| P2 lazy-loading | ✅ Deferred lspconfig (the big win), render-markdown, eyeliner, mini |
| P3 #3 vim.ui | ✅ Consolidated on snacks; removed dressing + telescope-ui-select |
| P3 #4 phantom group | ✅ Removed `<leader>h` whichkey group (git via CLI/lazygit) |
| P3 #5 fzf/fuzzy | ⏭️ Skipped (cosmetic; blink Rust risks glibc) |
| P3 #6 winborder | ⏭️ Skipped (explicit borders are defensive, not redundant) |
| P4 cleanup | ✅ Deleted 3 dead AI files; autocmd reindent; ColorColumn dead line removed; eslint_d uninstalled; CLAUDE.md refreshed |
| P5 #1 version shim | ✅ Removed dead `client_supports_method` shim |
| P5 vimwiki | ✅ Kept + tamed (`global_ext=0`, prefix off `<leader>w`, lazy-loaded) |
| P5 pinning | ⏭️ Skipped (optional, low value) |

Also done along the way: removed `venv-selector` (uv/poetry), eslint LSP + fix-on-save, ruff LSP consolidation, mason-lspconfig v2 `vim.lsp.config` migration.

---

## P1 — Breakage Risk (address soon)

### 1. nvim-treesitter is frozen on the archived `master` branch
- **Where:** `lazy-lock.json` pins `nvim-treesitter`, `nvim-treesitter-context`,
  and `nvim-treesitter-textobjects` to `branch: master`. `treesitter.lua:8`
  uses `main = 'nvim-treesitter.configs'` with an `opts` block
  (`ensure_installed` / `highlight` / `indent` / `textobjects`).
- **Problem:** The `master` branch was archived 2025-05-24. No further parser
  updates, bug fixes, or new languages. Active development is on the `main`
  branch, which is a full API rewrite — the current `opts`-based config does
  not exist there (highlighting becomes `vim.treesitter.start()`, textobjects
  configuration relocates).
- **Action:** Migrate to the `main` branch. This is a breaking change and
  should be scoped as its own task. Highest-value update in this review.

### 2. `automatic_enable = true` enables unconfigured LSP servers
- **Where:** `lsp/lsp.lua` mason-lspconfig setup; `servers` table.
- **Problem:** Mason has `terraform-ls`, `gradle-language-server`, and
  `golangci-lint-langserver` installed but absent from the `servers` table.
  `automatic_enable` enables them on bare defaults. On Go files this produces
  triple diagnostics: gopls + golangci-lint-langserver (LSP) + nvim-lint's
  `golangcilint`.
- **Action:** Either (a) add intended servers to the `servers` table,
  (b) `mason uninstall` the unused ones, or (c) set
  `automatic_enable = { exclude = { 'golangci_ls', 'terraformls', 'gradle_ls' } }`.

---

## P2 — Performance (startup ~112ms, roughly half is deferrable)

These plugins load at startup because they declare no `event`/`ft`/`keys`/`cmd`
trigger. lazy.nvim only defers a plugin when given a trigger.

| Plugin | File | Recommended trigger |
|---|---|---|
| `vimwiki` | `vimwiki.lua` | eager vimscript plugin (~5ms) — see P5 (consider removal) |
| `render-markdown` | `render-markdown.lua:1` | `ft = 'markdown'` |
| `snacks.nvim` | `snacks.lua` | `keys` (loaded entirely for one `<leader>gp` map) |
| `mini.nvim` | `mini.lua` | `event = 'VeryLazy'` for ai/surround (keep statusline early) |
| `eyeliner` | `eyeliner.lua` | `event = 'VeryLazy'` |
| `dressing` | `dressing.lua` | `event = 'VeryLazy'` (or remove — see P3 #3) |
| `nvim-lspconfig` | `lsp/lsp.lua:3` | `event = { 'BufReadPre', 'BufNewFile' }` |

**Biggest single win:** `snacks` — a kitchen-sink framework loaded for a single
GitHub PR picker. Either `keys`-gate it, or lean in and use its other modules
(it can replace dressing, telescope-ui-select, and indent-blankline).

---

## P3 — Redundancy & Conflicts

### 3. Three-way `vim.ui.select` override
`dressing.nvim`, `telescope-ui-select` (`telescope.lua:19,66`), and
`snacks.picker` all override `vim.ui.select`. Last to load wins,
non-deterministically. Pick one. Lean option: drop dressing + ui-select and use
`snacks.picker`, since snacks is already a dependency.

### 4. Phantom `<leader>h` Git Hunk group
`whichkey.lua:49` declares a `[H]unk` group, but gitsigns (`git.lua`) configures
no hunk keymaps — only `<leader>gsd` and line blame. The group is empty.
Either wire gitsigns `on_attach` hunk maps (stage/reset/preview) or remove the
group declaration.

### 5. fzf-native build vs Lua fuzzy matcher
`telescope.lua:7-18` builds `telescope-fzf-native`, while `blink.lua:111` runs
blink's fuzzy matcher in pure Lua. Not a conflict, just inconsistent. Optional.

### 6. Global `winborder` makes per-plugin border config redundant
`options.lua:104` sets `winborder = 'rounded'` globally. Per-plugin border
settings — blink (`blink.lua:76`), diagnostics (`lsp.lua:177`), mason — are now
redundant and can be removed.

---

## P4 — Cleanup / Hygiene

- **Dead commented-out files** (entire file is comments): `claude.lua`,
  `code-companion.lua`, `opencode.lua`. Delete or move to a `disabled/` dir.
- **`autocmd.lua`** uses 4-space indentation; the rest of the config is
  2-space. Run through stylua.
- **`options.lua:115`** sets the `ColorColumn` highlight before the colorscheme
  loads (colorscheme loads later via lazy), so darcula-dark likely overrides the
  `#2d2d2d` value. Move into a `ColorScheme` autocmd so it persists.
- **`eslint_d` mason package** is now orphaned (removed from config 2026-05-29).
  Run `mason uninstall eslint_d`.
- **`CLAUDE.md` is stale**: references `pylsp` (config uses `pyright`) and
  language plugins that no longer exist.

---

## P5 — Modernization (optional)

- **`lsp.lua:109-120`** — the `client_supports_method` nvim-0.10/0.11 shim is
  dead weight on 0.12.2; the adjacent comment ("nightly 0.11 and stable 0.10")
  is two versions stale.
- **`mini.nvim` / `vimwiki`** are unpinned (track default branch). Lower
  reproducibility; optional to pin.
- **vimwiki** hijacks the markdown filetype and binds `<leader>w*`, colliding
  with `<leader>w` = write (`keymaps.lua:4`). If used, set
  `vim.g.vimwiki_global_ext = 0` and remap its leader. If unused, removing it is
  the easiest P2 perf win.

---

## Suggested Sequencing

1. **P1 #2 + P4 quick wins** — safe, fast, high signal.
2. **P2 lazy-loading pass** — measurable startup improvement, low risk.
3. **P3 consolidation** — resolve the `vim.ui.select` overlap and border config.
4. **P1 #1 (treesitter `main` migration)** — separate, careful task; breaking
   API change.

## Notes on Stale Memory

The repo's auto-memory "Known Issues (nvim)" list is largely outdated as of this
review. Already resolved: `conform.lua` `standardrb` typo, `maplocalleader`,
`<leader>tf` autocmd conflict, the `lualine.lua` dead file (no longer exists),
and the mason-lspconfig v2 dead-handlers migration.
