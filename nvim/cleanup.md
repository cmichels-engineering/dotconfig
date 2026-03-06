# Neovim Configuration Cleanup & Improvement Plan

Based on comprehensive analysis of the configuration at `/Users/chrismichels/.config/newVim/`

---

## Phase 1: Fix Critical Bugs & Typos

### 1.1 Fix Tab/Indentation Mismatch
**File:** `lua/core/options.lua:101`
```lua
# Current (line 101):
vim.o.shiftwidth = 4      -- Use 2 spaces for autoindent

# Fix to:
vim.o.shiftwidth = 2      -- Use 2 spaces for autoindent
```
**Reason:** Inconsistent with tabstop=2 and softtabstop=2, causing unexpected indentation

---

### 1.2 Fix gopls Configuration Typo
**File:** `lua/plugins/lsp/lsp.lua:210`
```lua
# Current:
gopls = {
    setting = {  -- WRONG: should be "settings"
        gopls = {

# Fix to:
gopls = {
    settings = {  -- CORRECT
        gopls = {
```
**Reason:** Typo prevents all gopls configuration from being applied

---

### 1.3 Fix golangci-lint Linter Name
**File:** `lua/plugins/lint.lua:11`
```lua
# Current:
go = { 'golangcilint' },

# Fix to:
go = { 'golangci_lint' },
```
**Reason:** Wrong linter name, linting won't work for Go files

---

### 1.4 Fix ColorColumn Color
**File:** `lua/core/options.lua:119`
```lua
# Current:
vim.api.nvim_set_hl(0,'ColorColumn', {bg = '#ffffff'})

# Fix to:
vim.api.nvim_set_hl(0,'ColorColumn', {bg = '#2d2d2d'})
```
**Reason:** White background is distracting/invisible, use subtle dark gray

---

### 1.5 Fix CodeSnap Keymap
**File:** `lua/core/keymaps.lua:34`
```lua
# Current:
keymap.set('n', '<leader>cs', ':CodeSnap')

# Fix to:
keymap.set('v', '<leader>cs', ':CodeSnap<CR>', { desc = 'Code Snapshot' })
```
**Reason:** CodeSnap needs visual selection, missing CR and description

---

### 1.6 Fix guess-indent.nvim Setup
**File:** `lua/plugins/guess-indent.lua`
```lua
# Current:
return {
  'NMAC427/guess-indent.nvim',
}

# Fix to:
return {
  'NMAC427/guess-indent.nvim',
  opts = {},
}
```
**Reason:** Plugin installed but never initialized, not doing anything

---

## Phase 2: Add Missing Formatters & Linters

### 2.1 Python Tools (Switch to pyright + ruff)

**File:** `lua/plugins/lsp/lsp.lua`

Remove or comment out:
```lua
pylsp = {},
```

Add:
```lua
pyright = {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
            },
        },
    },
},
```

Add to ensure_installed list (around line 283):
```lua
'ruff',  -- Python linter and formatter
```

**File:** `lua/plugins/conform.lua`

Add to formatters_by_ft (around line 31):
```lua
python = { 'ruff_format' },
```

**File:** `lua/plugins/lint.lua`

Add to linters_by_ft (around line 8):
```lua
python = { 'ruff' },
```

---

### 2.2 TypeScript/Angular Tools

**File:** `lua/plugins/lsp/lsp.lua`

Add to servers table:
```lua
html = {},
cssls = {},
emmet_ls = {
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
},
```

Add to ensure_installed:
```lua
'prettierd',
'prettier',
```

**File:** `lua/plugins/conform.lua`

Add to formatters_by_ft:
```lua
javascript = { 'prettierd', 'prettier', stop_after_first = true },
javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
typescript = { 'prettierd', 'prettier', stop_after_first = true },
typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
html = { 'prettierd', 'prettier', stop_after_first = true },
css = { 'prettierd', 'prettier', stop_after_first = true },
json = { 'prettierd', 'prettier', stop_after_first = true },
yaml = { 'prettierd', 'prettier', stop_after_first = true },
markdown = { 'prettierd', 'prettier', stop_after_first = true },
```

---

### 2.3 General Tools

**File:** `lua/plugins/lsp/lsp.lua`

Add to ensure_installed:
```lua
'markdownlint',
'shellcheck',
```

**File:** `lua/plugins/lint.lua`

Add to linters_by_ft:
```lua
sh = { 'shellcheck' },
bash = { 'shellcheck' },
zsh = { 'shellcheck' },
```

---

## Phase 3: Add Productivity Plugins

### 3.1 trouble.nvim - Better Diagnostics UI
**Create:** `lua/plugins/trouble.lua`
```lua
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
  },
}
```

---

### 3.2 harpoon - Quick File Navigation
**Create:** `lua/plugins/harpoon.lua`
```lua
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next" })
  end,
}
```

---

### 3.3 undotree - Undo History Visualization
**Create:** `lua/plugins/undotree.lua`
```lua
return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
  },
}
```

---

### 3.4 nvim-treesitter-context - Code Context
**Create:** `lua/plugins/treesitter-context.lua`
```lua
return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    enable = true,
    max_lines = 3,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = 'outer',
    mode = 'cursor',
  },
}
```

---

### 3.5 todo-comments.nvim - Highlight TODO/FIXME
**Create:** `lua/plugins/todo-comments.lua`
```lua
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPost",
  opts = {},
  keys = {
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [T]odos" },
  },
}
```

---

### 3.6 indent-blankline.nvim - Indentation Guides
**Create:** `lua/plugins/indent-blankline.lua`
```lua
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "BufReadPost",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
}
```

---

### 3.7 nvim-spectre - Project-wide Search/Replace
**Create:** `lua/plugins/spectre.lua`
```lua
return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Spectre",
  keys = {
    { "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
    { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word" },
    { "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Search in current file" },
  },
}
```

---

## Phase 4: Add Language-Specific Plugins

### 4.1 Python Development Plugins
**Create:** `lua/plugins/language/python.lua`
```lua
return {
  -- Virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    ft = "python",
    opts = {
      name = { "venv", ".venv", "env", ".env" },
    },
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },

  -- Python debugging
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-python").setup("python")
    end,
  },

  -- Python testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "python",
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
          }),
        },
      })
    end,
    keys = {
      { "<leader>tn", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test Nearest" },
      { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test File" },
      { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Test" },
      { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Test Summary" },
      { "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Test Output" },
    },
  },
}
```

---

### 4.2 TypeScript/Angular Plugins
**Create:** `lua/plugins/language/typescript.lua`
```lua
return {
  -- Auto close/rename HTML tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- Show package versions in package.json
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    opts = {},
    keys = {
      { "<leader>ns", "<cmd>lua require('package-info').show()<cr>", desc = "Show package info" },
      { "<leader>nc", "<cmd>lua require('package-info').hide()<cr>", desc = "Hide package info" },
      { "<leader>nu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package" },
      { "<leader>nd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete package" },
      { "<leader>ni", "<cmd>lua require('package-info').install()<cr>", desc = "Install package" },
    },
  },
}
```

---

### 4.3 Enhanced Treesitter Text Objects
**Update:** `lua/plugins/treesitter.lua`

Add treesitter-textobjects as a dependency and configure it:

```lua
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown',
      'markdown_inline', 'query', 'vim', 'vimdoc',
      'python', 'go', 'typescript', 'javascript', 'tsx', 'json', 'yaml'
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },

    -- Add textobjects configuration
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
      },
    },
  },
}
```

---

## Phase 5: Update Documentation

**Update:** `CLAUDE.md`

Add sections for:
- New productivity plugins and their keybindings
- Updated Python tooling (pyright, ruff)
- New TypeScript/Angular tools (prettier, emmet_ls, etc.)
- Testing framework (neotest) usage
- Harpoon workflow
- Trouble.nvim for diagnostics

---

## Implementation Checklist

### Bug Fixes (Priority 1)
- [x] Fix shiftwidth in options.lua
- [x] Fix gopls settings typo in lsp.lua
- [x] Fix golangci_lint name in lint.lua
- [x] Fix ColorColumn color in options.lua
- [x] Fix CodeSnap keymap in keymaps.lua
- [x] Fix guess-indent setup

### Python Tools (Priority 2)
- [x] Replace pylsp with pyright in lsp.lua
- [x] Add ruff to ensure_installed
- [x] Add ruff_format to conform.lua
- [x] Add ruff to lint.lua
- [x] Create python.lua language plugin

### TypeScript/Angular Tools (Priority 2)
- [x] Add html, cssls, emmet_ls to LSP servers
- [x] Add prettierd/prettier to ensure_installed
- [x] Add prettier config to conform.lua
- [x] Create typescript.lua language plugin

### General Tools (Priority 2)
- [x] Add markdownlint to ensure_installed
- [x] Add shellcheck to ensure_installed and lint config

### Productivity Plugins (Priority 3)
- [ ] Create trouble.lua
- [ ] Create harpoon.lua
- [x] Create undotree.lua
- [x] Create treesitter-context.lua
- [ ] Create todo-comments.lua
- [x] Create indent-blankline.lua
- [ ] Create spectre.lua

### Treesitter Enhancement (Priority 3)
- [x] Update treesitter.lua with textobjects

### Documentation (Priority 4)
- [ ] Update CLAUDE.md with new tools and keybindings

---

## Post-Implementation Steps

1. **Restart Neovim** - Close and reopen to load changes
2. **Check Mason** - Run `:Mason` to verify all tools are being installed
3. **Check Lazy** - Run `:Lazy` to verify all plugins are installed
4. **Test LSP** - Open Python, Go, TypeScript files and verify LSP works
5. **Test Formatters** - Save files and verify formatting works
6. **Test Linters** - Check diagnostics appear for issues
7. **Test Keybindings** - Verify new keymaps work as expected

---

## Potential Issues & Solutions

**Issue:** Mason fails to install tools
- **Solution:** Run `:Mason` and manually install with `i` key

**Issue:** Pyright can't find Python interpreter
- **Solution:** Use `<leader>vs` to select virtual environment

**Issue:** Prettier conflicts with LSP formatting
- **Solution:** Already handled with `lsp_format = 'fallback'` in conform.lua

**Issue:** Harpoon keybinds conflict with existing window navigation
- **Solution:** May need to adjust harpoon keybinds if conflicts arise

**Issue:** Too many plugins slow down startup
- **Solution:** Most are lazy-loaded on events/filetypes, should be minimal impact

---

## Estimated Impact

- **Files Modified:** ~8 files
- **Files Created:** ~10 new plugin files
- **New LSP Servers:** 4 (pyright, html, cssls, emmet_ls)
- **New Formatters/Linters:** 4 (ruff, prettierd/prettier, markdownlint, shellcheck)
- **New Plugins:** 10+ productivity and language-specific plugins
- **New Keybindings:** 20+ new keymaps

**Total Time:** 15-30 minutes for implementation and testing
