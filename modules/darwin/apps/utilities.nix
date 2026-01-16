{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal and utilities
    ghostty-bin
    nerd-fonts.jetbrains-mono
    raycast
    ice-bar
  ];
}
