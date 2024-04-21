{
  description = "Slstatus flake by jonwin";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = import nixpkgs {
        inherit system;

        overlays = [
          (final: prev: {
            slstatus = prev.slstatus.overrideAttrs (old: {
              src = ./.;
              buildInputs = with prev; old.buildInputs ++ [];
            });
          })
        ];
      };
    in {
      packages.default = pkgs.slstatus;

      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          gnumake
          xorg.libX11
          xorg.libXft
          xorg.libXinerama
        ];
      };
    });
}
