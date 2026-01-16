{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.local.zsh = {
    enable = lib.mkEnableOption "zsh with oh-my-zsh";
  };

  config = lib.mkIf config.local.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
      history.save = 10000;
      history.ignoreAllDups = true;
      history.ignoreSpace = true;
      historySubstringSearch.enable = true;

      initContent = ''
        # Source oh-my-zsh if available
        if [[ -d "${pkgs.oh-my-zsh}/share/oh-my-zsh" ]]; then
          export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
          export ZSH_THEME="bira"
          source "$ZSH/oh-my-zsh.sh"
        fi

        # Custom aliases
        alias ll="ls -la"
        alias la="ls -a"
        alias l="ls -l"
        alias ..="cd .."
        alias ...="cd ../.."
        alias ....="cd ../../.."

        # Nix related aliases
        alias rebuild="sudo darwin-rebuild switch"
        alias nixedit="code /etc/nix-darwin/"
        alias update="sudo nix flake update"

        # Git aliases (additional to oh-my-zsh)
        alias gs="git status"
        alias ga="git add"
        alias gc="git commit"
        alias gp="git push"
        alias gl="git pull"

        # Enable vi mode
        bindkey -v

        # Better completion
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors ""
        export PATH="$HOME/.config/emacs/bin:$PATH"
        export PATH="$HOME/.local/bin:$PATH"
      '';

      plugins = [ ];
    };

    home.packages = with pkgs; [
      zsh
      oh-my-zsh
    ];
  };
}
