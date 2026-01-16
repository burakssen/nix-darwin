{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

with lib;

let
  cfg = config.local.neovim;
in
{
  options.local.neovim = {
    enable = mkEnableOption "Neovim with LazyVim";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    home.packages = with pkgs; [
      # LazyVim dependencies
      git
      ripgrep
      fd
      lazygit
      gcc
      # Optional but useful
      lua-language-server
      stylua

      # Language Servers & Runtimes
      # C/C++
      clang-tools
      # Go
      go
      gopls
      # Zig
      zig
      zls
      # Python
      python3
      pyright
      black
      # JS/TS
      nodejs
      nodePackages.typescript
      nodePackages.typescript-language-server
      # Markdown
      marksman
      markdownlint-cli
      # TOML
      taplo
      # YAML
      yaml-language-server
      # JSON
      vscode-langservers-extracted
      # Rust
      rustc
      cargo
      rust-analyzer
    ];

    # Install LazyVim starter and configure theme
    home.activation.installLazyVim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "$HOME/.config/nvim" ]; then
        ${pkgs.git}/bin/git clone https://github.com/LazyVim/starter $HOME/.config/nvim
        rm -rf $HOME/.config/nvim/.git
      fi

      # Ensure plugin directory exists
      mkdir -p $HOME/.config/nvim/lua/plugins

      # Set Catppuccin Mocha theme
      cat > $HOME/.config/nvim/lua/plugins/theme.lua <<EOF
      return {
        { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
        {
          "LazyVim/LazyVim",
          opts = {
            colorscheme = "catppuccin-mocha",
          },
        },
      }
      EOF

      # Enable Language Extras
      cat > $HOME/.config/nvim/lua/plugins/languages.lua <<EOF
      return {
        { import = "lazyvim.plugins.extras.lang.clangd" },
        { import = "lazyvim.plugins.extras.lang.go" },
        { import = "lazyvim.plugins.extras.lang.json" },
        { import = "lazyvim.plugins.extras.lang.markdown" },
        { import = "lazyvim.plugins.extras.lang.python" },
        { import = "lazyvim.plugins.extras.lang.rust" },
        { import = "lazyvim.plugins.extras.lang.toml" },
        { import = "lazyvim.plugins.extras.lang.typescript" },
        { import = "lazyvim.plugins.extras.lang.yaml" },
        { import = "lazyvim.plugins.extras.lang.zig" },
      }
      EOF
    '';
  };
}
