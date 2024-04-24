{
  description = "Slstatus flake by jonwin";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;

        overlays = [
          (final: prev: {
            slstatus = prev.slstatus.overrideAttrs (old: {
              src = ./.;
              buildInputs = with prev; old.buildInputs ++ [wireplumber playerctl fira-code-nerdfont];
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
          wireplumber
          playerctl
          fira-code-nerdfont
        ];
      };
    });
}
