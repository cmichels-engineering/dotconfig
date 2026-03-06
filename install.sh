#!/bin/bash



# sdkman
if [ -d ~/.sdkman ]; then
  echo "sdkman installed. skipping"
else
  echo "installing sdkman"
  curl -s "https://get.sdkman.io" | bash
fi

# kubectl krew
if command -v kubectl > /dev/null 2>&1 && kubectl plugin list | grep -q krew; then
  echo "krew installed. skipping"
else
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"$KREW" install krew
  );

  echo 'add to .zshrc: export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"'
fi

# nvm
if [[ -f "${HOME}/.nvm/nvm.sh" ]]; then
 echo "nvm is installed. Skipping"
else
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# rust
if command -v rustc >/dev/null 2>&1; then
  echo "rust is installed. Skipping"
else
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Go/Delve
go install github.com/go-delve/delve/cmd/dlv@latest
