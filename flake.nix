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
          
          # Extra Analog & Layout
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
