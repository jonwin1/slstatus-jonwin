# slstatus-jonwin

My slstatus configuration with flake.nix.

<img src=bar.png alt=slstatus>

## slstatus - suckless status

slstatus is a small tool for providing system status information to other
programs over the EWMH property of the root window (used by dwm(1)) or
standard input/output. It is designed to be as efficient as possible by
only issuing the minimum of system calls required.

## Requirements

- Nerd Font
- Font Awesome
- wpctl for volume
- Xlib header files

## Installation

### Most distros

    make clean install

### NixOS

Add this repo as an input in your flake.nix:

    inputs = {
        slstatus = {
            url = "github:jonwin1/slstatus-jonwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

Then add this to your configuration.nix to install slstatus:

    environment = {
        systemPackages = with pkgs; [
            inputs.slstatus.packages."x86_64-linux".default
        ];
    };

## Current Fields

- CPU usage/temperature
- RAM usage
- Free disk space
- WiFi strength icon & ESSID
- Volume
- Date and time (YYYY-MM-DD hh:mm:ss)
- Battery state icon (if battery exists)
