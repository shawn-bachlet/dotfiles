let
  pkgs = import ./dev/portal-worktrees/portal-suite {};
  pkgs-20-09 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/cd63096d6d887d689543a0b97743d28995bc9bc3.tar.gz"){};
  pkgs-21-05 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/7e9b0dff974c89e070da1ad85713ff3c20b0ca97.tar.gz"){};
  pkgs-21-11 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/a7ecde854aee5c4c7cd6177f54a99d2c1ff28a31.tar.gz"){};
  unstable   = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/22dc22f8cedc58fcb11afe1acb08e9999e78be9c.tar.gz"){};
in
  [ # These are required by nix itself
    pkgs.pkgs.cacert
    unstable.nix

    # Tools that we use; these will be pinned to the same versions as run in CI
    # Whoops, this one is commented out for now - investigating why it doesn't work.
    # pkgs.hsPkgs.simformat
    pkgs.pkgs.minio
    pkgs.pkgs.postgresqlWithPackages
    pkgs.pkgs.yarn
    pkgs-20-09.cabal-install
    pkgs-20-09.nodePackages.typescript
    pkgs-20-09.cabal2nix
    pkgs-21-05.emacs
    pkgs-20-09.jq
    pkgs-21-05.nodejs


    # Any software pinned in this version of nixpkgs can be installed this way.
    # Here are a few examples.
    pkgs.pkgs.fd
    pkgs.pkgs.fzf
    pkgs.pkgs.git
    pkgs.pkgs.ripgrep
    pkgs.pkgs.vim
    pkgs.pkgs.zsh
    pkgs.pkgs.niv
    pkgs-20-09.tree
    pkgs-20-09.gnupg1
    unstable.cachix
    pkgs-20-09.direnv
    pkgs-20-09.loc
    pkgs-21-05.ispell
    pkgs-21-11.kitty
    unstable.neovim
    unstable.hub

  ]
