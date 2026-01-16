{ config, lib, ... }:

{
  options.local.ghostty = {
    enable = lib.mkEnableOption "Ghostty terminal emulator configuration";
  };

  config = lib.mkIf config.local.ghostty.enable {
    home.file.".config/ghostty/config".text = ''
      # Theme configuration
      theme = Catppuccin Mocha

      # Font configuration
      font-family = JetBrainsMono Nerd Font
      font-size = 14

      # Window settings
      window-width = 120
      window-height = 32
      window-theme = dark

      # Cursor settings
      cursor-style = block
      #cursor-blink = false

      # Scrolling
      scrollback-limit = 10000

      # Key bindings for better productivity
      keybind = ctrl+h=goto_split:left
      keybind = ctrl+l=goto_split:right
      keybind = ctrl+j=goto_split:bottom
      keybind = ctrl+k=goto_split:top
      keybind = ctrl+shift+c=copy_to_clipboard
      keybind = ctrl+shift+v=paste_from_clipboard
      keybind = ctrl+shift+t=new_tab
      keybind = ctrl+shift+w=close_tab
      keybind = ctrl+tab=next_tab
      keybind = ctrl+shift+tab=previous_tab

      # Shell integration
      shell-integration = zsh

      # Terminal settings
      term = xterm-256color
    '';
  };
}
