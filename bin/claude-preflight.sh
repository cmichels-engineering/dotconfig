#!/usr/bin/env bash
# WSL2 dev environment preflight check
# Run when something feels off before spending time debugging
# Usage: claude-preflight.sh

PASS=0
FAIL=0

check() {
    local label="$1"
    local result="$2"
    local detail="$3"
    if [ "$result" = "ok" ]; then
        echo "  [OK]   $label"
        PASS=$((PASS + 1))
    else
        echo "  [FAIL] $label — $detail"
        FAIL=$((FAIL + 1))
    fi
}

echo ""
echo "WSL2 Preflight Check"
echo "===================="

# 1. gpg-agent running
if gpg-connect-agent --no-autostart 'getinfo version' /bye &>/dev/null; then
    check "gpg-agent running" "ok"
else
    check "gpg-agent running" "fail" "start with: gpg-agent --daemon"
fi

# 2. pinentry-mode loopback in gpg.conf
if grep -q 'pinentry-mode loopback' ~/.gnupg/gpg.conf 2>/dev/null; then
    check "pinentry-mode loopback (gpg.conf)" "ok"
else
    check "pinentry-mode loopback (gpg.conf)" "fail" "add to ~/.gnupg/gpg.conf: pinentry-mode loopback"
fi

# 3. allow-loopback-pinentry in gpg-agent.conf
if grep -q 'allow-loopback-pinentry' ~/.gnupg/gpg-agent.conf 2>/dev/null; then
    check "allow-loopback-pinentry (gpg-agent.conf)" "ok"
else
    check "allow-loopback-pinentry (gpg-agent.conf)" "fail" "add to ~/.gnupg/gpg-agent.conf: allow-loopback-pinentry"
fi

# 4. git GPG signing configured
signing_key=$(git config --global user.signingkey 2>/dev/null)
gpg_sign=$(git config --global commit.gpgsign 2>/dev/null)
if [ -n "$signing_key" ] && [ "$gpg_sign" = "true" ]; then
    check "git GPG signing config" "ok"
else
    check "git GPG signing config" "fail" "signingkey='$signing_key' commit.gpgsign='$gpg_sign'"
fi

# 5. win32yank on PATH (clipboard bridging)
if command -v win32yank.exe &>/dev/null; then
    check "win32yank (clipboard)" "ok"
else
    check "win32yank (clipboard)" "fail" "not found on PATH — clipboard bridging broken"
fi

# 6. fzf resolves to non-system binary (PATH ordering)
fzf_path=$(command -v fzf 2>/dev/null)
if [ -z "$fzf_path" ]; then
    check "fzf PATH" "fail" "fzf not found"
elif echo "$fzf_path" | grep -q '^/usr/bin/fzf'; then
    check "fzf PATH (non-system)" "fail" "resolves to system fzf at $fzf_path — prepend user install to PATH"
else
    check "fzf PATH (non-system)" "ok"
fi

# 7. Docker daemon accessible
if docker info &>/dev/null 2>&1; then
    check "Docker daemon" "ok"
else
    check "Docker daemon" "fail" "not running or credentials misconfigured"
fi

# 8. GPG can actually sign (passphrase cache warm)
test_sig=$(echo "preflight-test" | gpg --clearsign 2>&1)
if echo "$test_sig" | grep -q 'BEGIN PGP SIGNED MESSAGE'; then
    check "GPG passphrase cache (can sign)" "ok"
else
    check "GPG passphrase cache (can sign)" "fail" "run: echo test | gpg --clearsign  (to warm cache)"
fi

echo ""
echo "Result: $PASS passed, $FAIL failed"
echo ""
[ $FAIL -gt 0 ] && exit 1 || exit 0
