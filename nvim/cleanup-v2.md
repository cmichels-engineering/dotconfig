# Neovim Configuration Cleanup & Improvement Plan V2

Based on review of configuration at `/Users/chrismichels/.config/newVim/` (2025-01-15)

**Status of cleanup.md:** Most items completed ✅
**This document:** Remaining fixes + new recommendations

---

## Phase 1: Critical Bug Fixes (DO FIRST)

### 1.1 Fix CodeSnap Keymap
**File:** `lua/core/keymaps.lua:34`
```lua
# Current (wrong - normal mode, missing CR):
keymap.set('n', '<leader>cs', ':CodeSnap', { desc = '[C]ode[S]nap' })

# Fix to:
keymap.set('v', '<leader>cs', ':CodeSnap<CR>', { desc = '[C]ode[S]nap' })
```
**Reason:** CodeSnap requires visual selection to capture code

---

### 1.2 Fix Go Formatter Configuration
**File:** `lua/plugins/conform.lua:33`
```lua
# Current (wrong - golangci_lint is a linter, not a formatter):
go = { 'golangci_lint' },

# Fix to (option 1 - use gofumpt):
go = { 'gofumpt' },

# OR Fix to (option 2 - rely on gopls formatting):
-- Remove the 'go' line entirely, gopls already formats via gofumpt
```
**Reason:** golangci_lint is a linter, not a formatter. Use gofumpt or gopls.

---

### 1.3 Add Missing Language Parsers
**File:** `lua/plugins/treesitter.lua:11`
```lua
# Current:
ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },

# Fix to:
ensure_installed = {
  'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown',
  'markdown_inline', 'query', 'vim', 'vimdoc',
  'python', 'go', 'typescript', 'javascript', 'tsx', 'json', 'yaml'
},
```
**Reason:** Missing parsers for primary development languages

---

## Phase 2: Missing Productivity Plugins from cleanup.md

### 2.1 trouble.nvim - Better Diagnostics UI
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
    { "<leader>xS", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
  },
}
```

---

### 2.2 harpoon - Quick File Navigation
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

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next" })
  end,
}
```
**Note:** Changed keybinds from cleanup.md to avoid conflicts with window navigation

---

### 2.3 todo-comments.nvim - Highlight TODO/FIXME
**Create:** `lua/plugins/todo-comments.lua`
```lua
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPost",
  opts = {},
  keys = {
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [T]odos" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "[S]earch [T]odos (TODO/FIX only)" },
  },
}
```

---

### 2.4 nvim-spectre - Project-wide Search/Replace
**Create:** `lua/plugins/spectre.lua`
```lua
return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Spectre",
  opts = {},
  keys = {
    { "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
    { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word", mode = "n" },
    { "<leader>sw", '<cmd>lua require("spectre").open_visual()<CR>', desc = "Search selection", mode = "v" },
    { "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Search in current file" },
  },
}
```

---

## Phase 3: Go Development Enhancements

### 3.1 nvim-dap-go - Better Go Debugging
**Update:** `lua/plugins/language/go.lua` (or create if doesn't exist)
```lua
return {
  -- Better Go debugging with dap-go
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-go').setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
          port = "${port}",
          args = {},
          build_flags = "",
          detached = vim.fn.has("win32") == 0,
        },
      })
    end,
    keys = {
      { "<leader>dgt", function() require('dap-go').debug_test() end, desc = "Debug Go Test" },
      { "<leader>dgl", function() require('dap-go').debug_last() end, desc = "Debug Last Go Test" },
    },
  },

  -- Go testing with neotest
  {
    'nvim-neotest/neotest-go',
    dependencies = { 'nvim-neotest/neotest' },
    ft = 'go',
  },

  -- Go code generation and refactoring
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    keys = {
      { "<leader>gsj", "<cmd>GoTagAdd json<cr>", desc = "Add json struct tags" },
      { "<leader>gsy", "<cmd>GoTagAdd yaml<cr>", desc = "Add yaml struct tags" },
      { "<leader>gse", "<cmd>GoIfErr<cr>", desc = "Generate if err" },
      { "<leader>gsi", "<cmd>GoImpl<cr>", desc = "Implement interface" },
    },
  },
}
```

---

### 3.2 Add Go Tools to Mason
**File:** `lua/plugins/lsp/lsp.lua` (around line 295)
```lua
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua',
  'gofumpt',
  'eslint_d',
  'golangci-lint',
  'ruff',
  'prettierd',
  'prettier',
  'markdownlint',
  'shellcheck',
  -- Add these Go tools:
  'gomodifytags',  -- Modify struct tags
  'impl',          -- Generate interface implementations
  'gotests',       -- Generate Go tests
  'delve',         -- Go debugger
})
```

---

## Phase 4: TypeScript/Angular Development Enhancements

### 4.1 neotest-jest - JavaScript/TypeScript Testing
**Update:** `lua/plugins/language/angular.lua`

Add to the file:
```lua
-- Add to existing angular.lua file:

-- JavaScript/TypeScript testing
{
  'nvim-neotest/neotest-jest',
  dependencies = {
    'nvim-neotest/neotest',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-jest')({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
  keys = {
    { "<leader>tj", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test Nearest (Jest)", ft = { "javascript", "typescript" } },
    { "<leader>tF", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test File (Jest)", ft = { "javascript", "typescript" } },
  },
},
```

---

### 4.2 Enhanced TypeScript LSP (Optional Alternative)
**File:** `lua/plugins/lsp/typescript-tools.lua` (optional, better than ts_ls)

If you want enhanced TypeScript support:
```lua
return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = {
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
```

**Note:** If using typescript-tools, remove `ts_ls` from `lua/plugins/lsp/lsp.lua:256`

---

### 4.3 Angular-Specific LSP Configuration
**File:** `lua/plugins/lsp/lsp.lua` (update angularls config around line 230)
```lua
# Current:
angularls = {},

# Update to:
angularls = {
  filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx' },
  root_dir = require('lspconfig.util').root_pattern('angular.json', 'project.json'),
},
```

---

## Phase 5: General Productivity Enhancements

### 5.1 flash.nvim - Modern Navigation
**Create:** `lua/plugins/flash.lua`
```lua
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    modes = {
      char = {
        jump_labels = true,
      },
    },
  },
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
    { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
    { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
    { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
  },
}
```

---

### 5.2 aerial.nvim - Code Outline/Symbol Browser
**Create:** `lua/plugins/aerial.lua`
```lua
return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  cmd = { 'AerialToggle', 'AerialOpen', 'AerialNavToggle' },
  opts = {
    backends = { "treesitter", "lsp", "markdown", "man" },
    layout = {
      min_width = 28,
      default_direction = "prefer_right",
    },
    attach_mode = "global",
    show_guides = true,
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },
  },
  keys = {
    { '<leader>ao', '<cmd>AerialToggle!<CR>', desc = 'Aerial Toggle' },
    { '<leader>an', '<cmd>AerialNavToggle<CR>', desc = 'Aerial Nav Toggle' },
    { '[a', '<cmd>AerialPrev<CR>', desc = 'Aerial Prev' },
    { ']a', '<cmd>AerialNext<CR>', desc = 'Aerial Next' },
  },
}
```

---

### 5.3 refactoring.nvim - Code Refactoring
**Create:** `lua/plugins/refactoring.lua`
```lua
return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'VeryLazy',
  opts = {},
  keys = {
    { '<leader>re', function() require('refactoring').refactor('Extract Function') end, mode = 'x', desc = 'Extract Function' },
    { '<leader>rf', function() require('refactoring').refactor('Extract Function To File') end, mode = 'x', desc = 'Extract Function to File' },
    { '<leader>rv', function() require('refactoring').refactor('Extract Variable') end, mode = 'x', desc = 'Extract Variable' },
    { '<leader>ri', function() require('refactoring').refactor('Inline Variable') end, mode = { 'n', 'x' }, desc = 'Inline Variable' },
    { '<leader>rb', function() require('refactoring').refactor('Extract Block') end, desc = 'Extract Block' },
    { '<leader>rbf', function() require('refactoring').refactor('Extract Block To File') end, desc = 'Extract Block to File' },
    { '<leader>rr', function() require('refactoring').select_refactor() end, mode = { 'n', 'x' }, desc = 'Select Refactor' },
  },
}
```

---

### 5.4 inc-rename.nvim - Live Preview LSP Rename
**Create:** `lua/plugins/inc-rename.lua`
```lua
return {
  'smjonas/inc-rename.nvim',
  cmd = 'IncRename',
  config = true,
}
```

**Update:** `lua/plugins/lsp/lsp.lua:74` to use inc-rename:
```lua
# Current:
map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

# Update to:
map('grn', function()
  return ':IncRename ' .. vim.fn.expand('<cword>')
end, '[R]e[n]ame', { expr = true })
```

---

### 5.5 Better Git Integration
**Create:** `lua/plugins/git-enhanced.lua`
```lua
return {
  -- Diff viewer
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
    opts = {},
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView Open' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'DiffView File History' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'DiffView Project History' },
      { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = 'DiffView Close' },
    },
  },

  -- Magit-like Git client
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Neogit',
    opts = {
      integrations = {
        diffview = true,
      },
    },
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' },
      { '<leader>gC', '<cmd>Neogit commit<cr>', desc = 'Neogit Commit' },
    },
  },

  -- Git blame inline
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    opts = {
      enabled = true,
      message_template = ' <author> • <date> • <summary>',
      date_format = '%r',
      virtual_text_column = 80,
    },
    keys = {
      { '<leader>gb', '<cmd>GitBlameToggle<cr>', desc = 'Git Blame Toggle' },
    },
  },
}
```

---

### 5.6 vim-tmux-navigator - Seamless Tmux Navigation
**Create:** `lua/plugins/tmux.lua`
```lua
return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<c-h>', '<cmd>TmuxNavigateLeft<cr>', desc = 'Navigate Left (Tmux)' },
    { '<c-j>', '<cmd>TmuxNavigateDown<cr>', desc = 'Navigate Down (Tmux)' },
    { '<c-k>', '<cmd>TmuxNavigateUp<cr>', desc = 'Navigate Up (Tmux)' },
    { '<c-l>', '<cmd>TmuxNavigateRight<cr>', desc = 'Navigate Right (Tmux)' },
    { '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>', desc = 'Navigate Previous (Tmux)' },
  },
}
```

**Note:** This will replace existing window navigation keybinds in `lua/core/keymaps.lua:28-31` but work seamlessly with tmux.

---

### 5.7 yanky.nvim - Better Yank History
**Create:** `lua/plugins/yanky.lua`
```lua
return {
  'gbprod/yanky.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  event = 'VeryLazy',
  opts = {
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 200,
    },
  },
  keys = {
    { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank' },
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put After' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put Before' },
    { '<c-p>', '<Plug>(YankyPreviousEntry)', desc = 'Previous Yank' },
    { '<c-n>', '<Plug>(YankyNextEntry)', desc = 'Next Yank' },
    { '<leader>sy', '<cmd>Telescope yank_history<cr>', desc = '[S]earch [Y]ank History' },
  },
}
```

**Warning:** This changes `<c-p>` and `<c-n>` from buffer navigation to yank history. Adjust if conflicts.

---

### 5.8 nvim-ufo - Better Code Folding
**Create:** `lua/plugins/ufo.lua`
```lua
return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = 'BufReadPost',
  opts = {
    provider_selector = function()
      return { 'treesitter', 'indent' }
    end,
  },
  init = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  keys = {
    { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
    { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
    { 'zr', function() require('ufo').openFoldsExceptKinds() end, desc = 'Open folds' },
    { 'zm', function() require('ufo').closeFoldsWith() end, desc = 'Close folds' },
  },
}
```

---

## Phase 6: Quality of Life Improvements

### 6.1 better-escape.nvim - Faster jk/kj to Escape
**Create:** `lua/plugins/better-escape.lua`
```lua
return {
  'max397574/better-escape.nvim',
  event = 'InsertEnter',
  opts = {
    mapping = { 'jk', 'kj' },
    timeout = 200,
    clear_empty_lines = false,
    keys = '<Esc>',
  },
}
```

---

### 6.2 nvim-colorizer.lua - Show Colors Inline
**Create:** `lua/plugins/colorizer.lua`
```lua
return {
  'NvChad/nvim-colorizer.lua',
  event = 'BufReadPost',
  opts = {
    filetypes = { '*' },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = true,
      AARRGGBB = false,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      mode = 'background',
      tailwind = true,
    },
  },
}
```

---

### 6.3 nvim-autopairs Enhancement
**Check if exists:** `lua/plugins/autopairs.lua`

If it exists, ensure it has this configuration for better completion integration:
```lua
-- Add to autopairs config:
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')  -- or require('blink.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
```

---

### 6.4 Persistence - Session Management
**Create:** `lua/plugins/persistence.lua`
```lua
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    { '<leader>qs', function() require('persistence').load() end, desc = 'Restore Session' },
    { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore Last Session' },
    { '<leader>qd', function() require('persistence').stop() end, desc = "Don't Save Current Session" },
  },
}
```

---

## Phase 7: Performance & LSP Optimizations

### 7.1 Increase Format Timeout for Slow Formatters
**File:** `lua/plugins/conform.lua:26`
```lua
# Current:
timeout_ms = 500,

# Increase to:
timeout_ms = 1000,
```
**Reason:** Some formatters (especially prettier on large files) can be slow

---

### 7.2 Add LSP Progress Notifications
**Already have:** fidget.nvim ✅ (lua/plugins/lsp/lsp.lua:24)

---

### 7.3 nvim-lightbulb - Code Action Indicator
**Create:** `lua/plugins/lightbulb.lua`
```lua
return {
  'kosayoda/nvim-lightbulb',
  event = 'LspAttach',
  opts = {
    autocmd = { enabled = true },
    sign = {
      enabled = true,
      text = '󰌶',
      hl = 'DiagnosticSignHint',
    },
    virtual_text = {
      enabled = false,
    },
  },
}
```

---

## Phase 8: Documentation Updates

**Update:** `CLAUDE.md`

Add sections for:
1. **New Productivity Plugins:**
   - Trouble.nvim keybindings (`<leader>xx`, etc.)
   - Harpoon workflow (`<leader>a`, `<leader>1-4`)
   - Todo-comments (`<leader>st`)
   - Spectre search/replace (`<leader>S`, `<leader>sw`)

2. **Enhanced Language Support:**
   - Go: nvim-dap-go, neotest-go, gopher.nvim keybindings
   - TypeScript: neotest-jest, enhanced LSP
   - Python: Already documented ✅

3. **Navigation Enhancements:**
   - Flash.nvim (`s`, `S`)
   - Aerial.nvim (`<leader>ao`)
   - Tmux navigation (if added)

4. **Refactoring Tools:**
   - refactoring.nvim keybindings (`<leader>re`, `<leader>rv`, etc.)
   - inc-rename for live preview

5. **Git Enhancements:**
   - Diffview (`<leader>gd`, `<leader>gh`)
   - Neogit (`<leader>gg`)
   - Git blame (`<leader>gb`)

6. **Session Management:**
   - Persistence.nvim (`<leader>qs`, `<leader>ql`)

---

## Implementation Checklist

### Critical Fixes (Priority 1 - DO FIRST)
- [ ] Fix CodeSnap keymap (keymaps.lua:34)
- [ ] Fix Go formatter (conform.lua:33)
- [ ] Add language parsers to treesitter

### Missing from cleanup.md (Priority 2)
- [ ] Create trouble.lua
- [ ] Create harpoon.lua
- [ ] Create todo-comments.lua
- [ ] Create spectre.lua

### Go Enhancements (Priority 3)
- [ ] Add nvim-dap-go
- [ ] Add neotest-go
- [ ] Add gopher.nvim
- [ ] Add Go tools to Mason (gomodifytags, impl, gotests, delve)

### TypeScript/Angular Enhancements (Priority 3)
- [ ] Add neotest-jest
- [ ] Update angularls configuration
- [ ] (Optional) Add typescript-tools.nvim

### General Productivity (Priority 4)
- [ ] Add flash.nvim
- [ ] Add aerial.nvim
- [ ] Add refactoring.nvim
- [ ] Add inc-rename.nvim
- [ ] Add diffview.nvim
- [ ] Add neogit
- [ ] Add git-blame.nvim
- [ ] Add vim-tmux-navigator (if using tmux)

### Quality of Life (Priority 5)
- [ ] Add yanky.nvim
- [ ] Add nvim-ufo (better folding)
- [ ] Add better-escape.nvim
- [ ] Add nvim-colorizer.lua
- [ ] Add persistence.nvim (sessions)
- [ ] Add nvim-lightbulb

### Performance Tweaks (Priority 5)
- [ ] Increase format timeout in conform.lua

### Documentation (Priority 6)
- [ ] Update CLAUDE.md with all new plugins and keybindings

---

## Estimated Impact

- **Files to Modify:** 4 files (keymaps.lua, conform.lua, treesitter.lua, lsp.lua)
- **Files to Create:** 15-20 new plugin files
- **New Keybindings:** 50+ new keymaps
- **New Dependencies:** 20+ new plugins
- **Startup Impact:** Minimal (most plugins are lazy-loaded)
- **Total Time:** 1-2 hours for full implementation and testing

---

## Conflicts & Considerations

### Keybinding Conflicts
1. **yanky.nvim** changes `<c-p>/<c-n>` from buffer navigation to yank history
   - **Solution:** Keep current buffer nav or remap yanky

2. **vim-tmux-navigator** replaces window navigation keybinds
   - **Solution:** Only install if using tmux, seamless integration

3. **Harpoon** uses `<C-e>` which might conflict
   - **Solution:** Changed to `<leader>1-4` in this plan

### Plugin Overlap
1. **typescript-tools.nvim** vs **ts_ls**
   - **Solution:** Choose one, comment out the other

2. **inc-rename** vs **vim.lsp.buf.rename**
   - **Solution:** inc-rename provides live preview, worth the swap

### Performance Considerations
1. Many new plugins could slow startup
   - **Mitigation:** All are lazy-loaded via `event`, `ft`, `cmd`, or `keys`

2. LSP servers might use more memory
   - **Mitigation:** Already configured efficiently

---

## Post-Implementation Testing

1. **Restart Neovim** - `:Lazy sync` then restart
2. **Check Mason** - `:Mason` - verify all tools installed
3. **Check Lazy** - `:Lazy` - verify no plugin errors
4. **Test LSP** - Open Go, Python, TypeScript files
5. **Test Formatters** - Save files in each language
6. **Test Linters** - Introduce intentional errors
7. **Test Keybindings** - Go through each new keymap
8. **Test Productivity Plugins:**
   - Try Harpoon workflow
   - Open Trouble diagnostics
   - Search TODOs
   - Use Spectre for search/replace
9. **Test Language Features:**
   - Debug Go code with dap-go
   - Run tests with neotest
   - Use refactoring.nvim
10. **Check Performance** - `:Lazy profile` to check startup time

---

## Optional: Snippet Support

If you want snippet support (currently missing):

**Create:** `lua/plugins/luasnip.lua`
```lua
return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}
```

Then update blink.cmp config to use snippets.

---

## Summary

**Must Do:**
- Fix 3 critical bugs
- Add 4 missing productivity plugins from cleanup.md

**Should Do:**
- Go enhancements (dap-go, neotest-go, gopher)
- TypeScript testing (neotest-jest)
- Core productivity (flash, aerial, refactoring, trouble, harpoon)

**Nice to Have:**
- Better Git integration (diffview, neogit)
- Quality of life (yanky, ufo, colorizer, persistence)
- Tmux integration (if using tmux)

**Can Skip:**
- typescript-tools (ts_ls works fine)
- Any plugins that don't fit your workflow

Choose what fits your workflow best!
