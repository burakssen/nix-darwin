{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

with lib;

let
  cfg = config.local.doom-emacs;
  # Access home-manager's DAG logic for script ordering
  hmDag = inputs.home-manager.lib.hm.dag;
in
{
  options.local.doom-emacs = {
    enable = mkEnableOption "Doom Emacs";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-nox;
    };

    home.packages = with pkgs; [
      # Doom Emacs dependencies
      git
      (ripgrep.override { withPCRE2 = true; })
      gnutls
      fd

      # Optional language dependencies
      nodejs
      python3
      rustc
      cargo
    ];

    home.file.".doom.d" = {
      source = ./doom.d;
      recursive = true;
    };

    # Install Doom Emacs if not already installed
    home.activation.installDoomEmacs = hmDag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "$HOME/.config/emacs" ]; then
        ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
        ~/.config/emacs/bin/doom install
      fi
    '';
  };
}
