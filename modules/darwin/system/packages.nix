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
    sqlc

    # programming languages
    zig
    go
    bun
    uv

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
    spotify

    # Applications
    firefox
  ];
}
