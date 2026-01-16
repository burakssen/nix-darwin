{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    # Add the custom tap
    taps = [
      "burakssen/cask"
    ];

    brews = [
      "libomp"
      "pkg-config"
      "gh"
    ];

    casks = [
      "iina"
      "docker-desktop"
      "burakssen/cask/ani-cli"
      "burakssen/cask/artixgamelauncher"
      "burakssen/cask/quitme"
    ];

    masApps = {
      "WhatsApp" = 310633997;
      "Telegram" = 747648890;
      "Microsoft Word" = 462054704;
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;
    };
  };
}
