{
  config,
  lib,
  pkgs,
  ...
}:

let
  wallpaperPath = ./wallpapers/wolf.png;
in
{
  imports = [
    ./modules/home-manager/core/dock.nix
    ./modules/home-manager/core/git.nix
    ./modules/home-manager/core/ghostty.nix
    ./modules/home-manager/core/zsh.nix
    ./modules/home-manager/core/doom-emacs.nix
  ];

  home.homeDirectory = "/Users/burakssen";
  home.username = "burakssen";
  home.stateVersion = "25.11";

  home.file.".background-image" = {
    source = wallpaperPath;
    onChange = ''
      /usr/bin/osascript -e 'tell application "System Events" to set picture of every desktop to "${config.home.homeDirectory}/.background-image"'
    '';
  };

  home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /usr/bin/osascript -e 'tell application "System Events" to set picture of every desktop to "${config.home.homeDirectory}/.background-image"'
  '';

  programs.git.enable = true;

  local.dock.enable = true;
  local.dock.entries = [
    { path = "/System/Applications/Apps.app/"; }
    { path = "/System/Applications/Mail.app/"; }
    { path = "/Applications/Safari.app/"; }
    { path = "/Applications/Nix Apps/Slack.app/"; }
    { path = "/Applications/WhatsApp.app"; }
    { path = "/Applications/Telegram.app"; }
    { path = "/Applications/Nix Apps/Ghostty.app/"; }
    { path = "${pkgs.vscode}/Applications/Visual Studio Code.app"; }
  ];

  # Enable Ghostty configuration
  local.ghostty.enable = true;

  # Enable Zsh with Oh My Zsh
  local.zsh.enable = true;

  # Enable Doom Emacs
  local.doom-emacs.enable = true;

}
