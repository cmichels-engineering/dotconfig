# dotconfig

Portable `.config` foundation for a keyboard-first engineering workflow across machines.

## Why This Exists

This repository is the environment layer for a repeatable personal platform workflow. It keeps shell, terminal, editor, and supporting tool configuration versioned in one place so setup is fast, changes are traceable, and behavior stays consistent across machines.

## Trio Architecture

This repo is part of a three-repository workflow stack:

- `dotconfig` (this repo): base environment and runtime behavior
- `claude-config`: Claude command/agent workflow system and guardrails
- `pr-monitor`: terminal PR and review awareness workflow

`dotconfig` provides the baseline shell, tmux, terminal, and integration points that allow the other two repositories to run consistently.

## Configuration Model

- Files in this repository are symlinked into required runtime paths (for example, `~/.config/...`).
- Portable defaults are tracked.
- Machine-local and organization-specific values are loaded from ignored local overrides.

Examples:

- `zsh/local.zsh` (ignored): local org/path/account overrides
- `pr-monitor/config.yaml` (ignored): runtime config generated from `pr-monitor/config.yaml.template`

## Public vs Local Artifacts

| Type | Examples | Git status |
|---|---|---|
| Portable tracked config | `zsh/`, `tmux/`, `nvim/`, `wezterm/`, `pr-monitor/config.yaml.template` | Tracked |
| Machine-local overrides | `zsh/local.zsh`, `pr-monitor/config.yaml` | Ignored |
| Runtime state/cache | `pr-monitor/status.json`, `.claude/`, tool auth/state files | Ignored |

## Repository Layout

- `zsh/`: shell exports, aliases, functions, platform-specific overlays
- `tmux/`: multiplexer workflow, navigation, status customization
- `nvim/`: Neovim configuration and plugin setup
- `wezterm/`, `ghostty/`: terminal integration
- `pr-monitor/`: monitor-specific config template and runtime integration points
- `bin/`: helper scripts used by the environment

## Setup Notes

- `install.sh` is deprecated and retained for reference.
- Current machine bootstrap and symlink orchestration is handled via your external setup workflow.

## Safety and Portability

- Do not commit secrets, auth tokens, or machine-local credentials.
- Keep tracked files portable and neutral.
- Keep org-specific/runtime-specific values in ignored local override files.
