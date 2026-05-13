# Architecture Overview

## Problem Statement

This repository defines a reproducible, machine-portable configuration baseline for a keyboard-first engineering environment. The goal is fast setup, predictable behavior, and versioned control over shell/editor/terminal workflow layers.

## Layered Architecture

1. Environment runtime layer
   - shell exports, aliases, functions (`zsh/`)
   - terminal multiplexer workflow (`tmux/`)
2. Editing and interaction layer
   - editor configuration (`nvim/`)
   - terminal clients (`wezterm/`, `ghostty/`)
3. Workflow integration layer
   - helper scripts (`bin/`)
   - `pr-monitor` template config and status integration

## Symlink-Based Delivery Model

- Repository files are symlinked into canonical runtime locations under `~/.config` and related paths.
- This keeps one source of truth while preserving expected tool locations.

## Configuration Strategy

- Track portable defaults in git.
- Keep machine- or org-specific values in ignored local override files.

Primary examples:

- `zsh/local.zsh` (ignored) for local paths, org names, and account-specific values
- `pr-monitor/config.yaml.template` (tracked) with local `pr-monitor/config.yaml` (ignored)

## Interoperability with Companion Repositories

This repository is the foundation for the broader workflow stack:

- `claude-config` depends on stable shell/tmux/runtime behavior from `dotconfig`
- `pr-monitor` integrates with terminal/tmux environment and local config conventions from `dotconfig`

Together, the stack provides:

- consistent cross-machine setup
- reduced context switching
- repeatable automation with explicit guardrails

## Tradeoffs

- Template + local override pattern adds setup steps but improves portability and privacy.
- Explicit local overrides require maintenance, but prevent accidental leakage of internal context.
- Symlink management introduces path coupling, but keeps runtime behavior deterministic.

## Operational Guardrails

- No secrets or auth tokens in tracked files.
- Internal identifiers and private domains should not appear in public-facing defaults.
- Runtime/generated state stays ignored.
