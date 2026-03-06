local wezterm = require 'wezterm'
local act = wezterm.action

local const = {
  ALT = 'ALT',
  CTRL = 'CTRL',
  SHIFT = 'SHIFT',
  SUPER = 'SUPER',
  CURRENT_PANE_DOMAIN = 'CurrentPaneDomain',
  LEADER = 'CTRL|ALT|SHIFT',
}

local function bind(key, action, mod)
  mod = mod or const.LEADER
  return {
    key = key,
    mods = mod,
    action = action
  }
end
return {
  -- Tabs
  bind('d', act.ActivateTabRelative(-1)),             -- Move to the left tab
  bind('f', act.ActivateTabRelative(1)),              -- Move to the right tab
  bind('t', act.SpawnTab(const.CURRENT_PANE_DOMAIN)), -- Create a new tab
  bind('w', act.CloseCurrentTab({ confirm = false })), -- Close the current tab

  -- Panes
  bind('u', act.SplitHorizontal { domain = const.CURRENT_PANE_DOMAIN }), -- Split horizontally
  bind('i', act.SplitPane {
    direction = 'Down',
    size = { Percent = 15 },
  }
  ),                                                  -- Split vertically
  bind('j', act.ActivatePaneDirection('Down')),       -- Move to the pane below
  bind('k', act.ActivatePaneDirection('Up')),         -- Move to the pane above
  bind('h', act.ActivatePaneDirection('Left')),       -- Move to the pane left
  bind('l', act.ActivatePaneDirection('Right')),      -- Move to the pane right
  bind('y', act.CloseCurrentPane({ confirm = false })), -- Close the current pane
  bind('n', act.AdjustPaneSize({ 'Left', 4 })),       --
  bind(',', act.AdjustPaneSize({ 'Up', 4 })),         --
  bind('m', act.AdjustPaneSize({ 'Down', 4 })),       --
  bind('.', act.AdjustPaneSize({ 'Right', 4 })),      --
  bind('p', act.TogglePaneZoomState),                 -- toggle full screen
  bind('v', act.IncreaseFontSize),
  bind('c', act.DecreaseFontSize),

  -- Copy/Paste
  { key = 'v', mods = 'SUPER', action = act.PasteFrom('Clipboard') }, -- Paste from clipboard
  { key = 'c', mods = 'SUPER', action = act.CopyTo('Clipboard') }, -- copy to clipboard
  -- PR Monitor
  {
    key = 'g',
    mods = const.LEADER,
    action = wezterm.action.SpawnCommandInNewTab {
      args = { '/bin/zsh', '-lic', 'pr-monitor; exec zsh' },
    },
  },

  {
    key = 'r',
    mods = const.LEADER,
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}
