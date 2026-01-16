{ config, pkgs, lib, inputs, ... }:

with lib;
let
  cfg = config.local.dock;
  inherit (pkgs) dockutil;
  # Access home-manager's DAG logic for script ordering
  hmDag = inputs.home-manager.lib.hm.dag;
in
{
  options = {
    local.dock = {
      enable = mkOption {
        description = "Enable dock";
        default = false;
        type = types.bool;
      };
      entries = mkOption {
        description = "Entries on the Dock";
        type = with types; listOf (submodule {
          options = {
            path = mkOption { type = str; };
            section = mkOption {
              type = str;
              default = "apps";
              description = "Section: 'apps' or 'others'";
            };
            options = mkOption {
              type = str;
              default = "";
              description = "Extra options for dockutil";
            };
          };
        });
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ dockutil ];

    home.activation.configure-dock = hmDag.entryAfter ["writeBoundary"] ''
      echo "Configuring Dock..."
      
      # Define the wrapper function
      run_dockutil() {
        ${dockutil}/bin/dockutil --no-restart "$@"
      }

      # 1. Disable "Show recent applications in Dock"
      #    Use absolute path for defaults
      /usr/bin/defaults write com.apple.dock show-recents -bool false

      # 2. Clear existing entries
      run_dockutil --remove all

      # 3. Add defined entries
      ${builtins.concatStringsSep "\n" (builtins.map (entry: ''
        run_dockutil --add "${entry.path}" --section ${entry.section} ${entry.options}
      '') cfg.entries)}

      # 4. Restart the Dock to apply changes
      /usr/bin/killall Dock
    '';  
  };
}
