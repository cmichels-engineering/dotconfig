# WSL2 Setup Notes

## Provisioning

WSL2 environment is managed by the **os-setup** repo:

```
~/projects/personal/os-setup/
├── WSLfile      # declarative manifest — what to install
├── setup.sh     # runner — ./setup.sh [module]
└── modules/     # apt, go, rust, node, python, java, tools, kubectl, dotfiles
```

Full audit, decisions, and execution log: `os-setup/plans/os.md`

## WSL2 Quirks
- `xdg-open` / browser open fails silently — don't rely on it
- PATH ordering matters: always prepend, never append for tool overrides
- Mac-specific tools (e.g. pbcopy, open) don't exist — use WSL2 equivalents
- Clipboard bridging uses `win32yank.exe` at `~/.local/bin/`
- GPG signing requires `pinentry-mode loopback` in `~/.gnupg/gpg.conf` and `allow-loopback-pinentry` in `gpg-agent.conf`
