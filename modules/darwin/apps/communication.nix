{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Communication apps
    zoom-us
    slack
  ];
  homebrew.masApps = {
    "WhatsApp" = 310633997;
    "Telegram" = 747648890;
  };
}
