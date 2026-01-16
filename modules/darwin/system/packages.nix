{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # System utilities
    dockutil
    mas
    fastfetch
    ffmpeg
    nixfmt
    pre-commit
    cmake
    fzf
    utm

    # programming languages
    zig
    go

    # Development tools
    neovim
    vscode
    zed-editor
    docker-client
    emacs
    gemini-cli
    opencode
    typst
    discord
    gh

    # Applications
    firefox
  ];
}
