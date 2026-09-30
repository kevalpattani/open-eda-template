### Please Follow Installation steps one by one

1. We will be using curl to fetch the official installer
   ```
   sudo apt-get install -y curl
   ```
2. This script installs Nix and automatically configures the required LibreLane binary caches and experimental features (flakes).
   ```
   curl --proto '=https' --tlsv1.2 -fsSL https://artifacts.nixos.org/nix-installer | sh -s -- install --no-confirm --extra-conf "    extra-substituters = https://nix-cache.fossi-foundation.org    extra-trusted-public-keys = nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs=    extra-experimental-features = nix-command flakes"
   ```
3. **CRITICAL:** _Close your current terminal completely_ and _open a new one_.
   To test if nix is installed try executing this,
   ```
   nix --version
   ```

   The expected output should be like this
   ```
   [keval@archlinux ~]$ nix --version
   nix (Nix) 2.35.1
   ```
4. Make a folder in your home directory where you want to store your projects and `cd` to navigate into that foldere
   ```
   mkdir your_folder_name
   cd your_folder_name
   ```
5. In `your_folder_name` make a file named `flake.nix`
   ```
   touch flake.nix
   ```

   Using any text editor write this code into the `flake.nix` file. One approach is to use nano
   ```
   nano flake.nix
   ```

   after `nano flake.nix` copy the following code and paste it once nano text editor window opens up, paste it while pressing `Ctrl+Shift+V` in nano
```
{
  description = "Complete Open-Source Silicon & FPGA Environment";

  nixConfig = {
    extra-substituters = [
      "https://nix-cache.fossi-foundation.org"
    ];
    extra-trusted-public-keys = [
      "nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs="
    ];
  };

  inputs = {
    nix-eda.url = "github:fossi-foundation/nix-eda/7.4.0";
    librelane = {
      url = "github:librelane/librelane/dev";
      inputs.nix-eda.follows = "nix-eda";
    };
  };

  outputs = { self, librelane, nix-eda, ... }: let
    devshell = librelane.inputs.devshell;
    nixpkgs = nix-eda.inputs.nixpkgs;
  in {
    legacyPackages = nix-eda.forAllSystems (system:
      import nixpkgs {
        inherit system;
        overlays = [
          nix-eda.overlays.default
          devshell.overlays.default
          librelane.overlays.default
        ];
      }
    );

    packages = nix-eda.forAllSystems (system: {
      inherit (self.legacyPackages.${system}.python3.pkgs);
    });

    devShells = nix-eda.forAllSystems (system: let
      pkgs = self.legacyPackages.${system};
    in {
      default = pkgs.librelane-shell.override {
        extra-packages = with pkgs; [
          # Simulation
          iverilog
          verilator
          gtkwave

          # FPGA prototyping
          nextpnr
          icestorm
          trellis
          openfpgaloader
          
          # Analog & Layout
          xschem
          xterm
          ngspice
          klayout
          magic
          netgen
          openvaf-r
        ];

        extra-python-packages = ps: with ps; (
          pkgs.lib.optionals (pkgs.lib.meta.availableOn pkgs.stdenv.hostPlatform cocotb) [ cocotb ]
        );
      };
    });
  };
}
```

6. same as `flake.nix` make `shell.nix`
   ```
   touch shell.nix
   ```
   
   And paste this code into `shell.nix`
```
let
  # Automatically fetch the flake compatibility bridge
  flake-compat = import (fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz") {
    src = ./.;
  };
in
  # Expose the default development shell from flake.nix
  flake-compat.shellNix
```

> [!NOTE]
> `flake.nix` is the modern blueprint and source of truth for your environment, while `shell.nix` serves as a backward-compatibility bridge for older commands.

7. Now you are ready to go, let's launch your nix-shell.
   ``` 
   nix-shell
   ```
   It will take a while to open because it will be installing all the tools required and after it installs a text will pop up like this,
   ```
   [nix-shell:~/your_folder_name]$
   ```
   Also after first time executing `nix-shell` it generates `flake.lock` which is completely safe to commit or ignore.
   
8. To test if installation is complete will do a smoke test
   ```
   librelane --smoke-test
   ```
   This will look really cool and at the end of the execution the output should be like this,
   ```
   [18:43:05] INFO     Smoke test passed. 
   ```

Now you can run your designs and test them.
Happy Hacking!

> [!TIP]
> If you are running out of storage in your device you can remove tools which are cached, LibreLane tools are just sitting dormant in your `/nix/store` cache taking up disk space. run the Nix garbage collector to completely wipe tools from your drive (you can install them again by running nix-shell where you have stored flake and shell) by executing
> `nix-collect-garbage -d`
