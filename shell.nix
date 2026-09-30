let
  # Automatically fetch the flake compatibility bridge
  flake-compat = import (fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz") {
    src = ./.;
  };
in
  # Expose the default development shell from flake.nix
  flake-compat.shellNix
