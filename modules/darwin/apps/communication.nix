{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Communication apps
    zoom-us
    slack
  ];
}
