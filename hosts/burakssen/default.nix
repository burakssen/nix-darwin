{ pkgs, ... }:

{
  imports = [
    ../../modules/darwin/system/packages.nix
    ../../modules/darwin/system/homebrew.nix
    ../../modules/darwin/system/defaults.nix
    ../../modules/darwin/apps/communication.nix
    ../../modules/darwin/apps/utilities.nix
  ];

  system.primaryUser = "burakssen";

  users.users.burakssen = {
    name = "burakssen";
    home = "/Users/burakssen";
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 6;

  programs.zsh.enable = true;
}
