# look at the derivation tree for a program
function nix-browse {
  nix-tree $(nix-store -q -d $(readlink -f $(which ${1})))
}

function ghci-with {
  nix-shell --run ghci -p "ghc.withPackages (pkgs: with pkgs; [ $* ])"
}

# vim binds
bindkey -v
export KEYTIMEOUT=1

# jump
eval "$(jump shell)"

# direnv
eval "$(direnv hook zsh)"

function nixify {
  if [ ! -e ./.envrc ]; then
    echo "use nix" > .envrc
    direnv allow
  fi
  if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
    cat > default.nix <<'EOF'
with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    bashInteractive
  ];
}
EOF
    ${EDITOR:-vim} default.nix
  fi
}

function flakify {
  if [ ! -e flake.nix ]; then
    nix flake new -t github:nix-community/nix-direnv .
  elif [ ! -e .envrc ]; then
    echo "use flake" > .envrc
    direnv allow
  fi
  ${EDITOR:-vim} flake.nix
}
