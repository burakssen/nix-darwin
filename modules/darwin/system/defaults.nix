{ config, ... }:

{
  system.defaults.CustomUserPreferences = {
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        "64" = {
          enabled = false;
        };
        "65" = {
          enabled = false;
        };
      };
    };
  };

  system.activationScripts.postActivation.text = ''
    # Activate settings for the primary user
    sudo -u ${
      config.system.primaryUser or "burakssen"
    } /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
