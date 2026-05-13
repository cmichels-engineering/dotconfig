# Contributing

Thanks for contributing.

## Branching

- `feature/*` for new features
- `bug/*` for fixes

## Configuration Rules

- Keep tracked config portable and machine-agnostic.
- Keep machine-local or org-specific values in ignored local overrides.
- Do not commit secrets, tokens, auth state, or private identifiers.

## Local Override Pattern

- `zsh/local.zsh` is local-only and ignored.
- `pr-monitor/config.yaml` is local-only and ignored.
- Tracked defaults use templates and safe placeholders.

## Pull Requests

- Target `dev` unless directed otherwise.
- Keep scope tight; avoid unrelated refactors.
- Include summary and validation details.
- Ensure CI passes before merge.
