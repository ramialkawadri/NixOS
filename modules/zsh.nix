{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      upgrade = "sudo nix flake update && sudo nixos-rebuild switch --upgrade";
      clean = "sudo nix-collect-garbage --delete-old; sudo /run/current-system/bin/switch-to-configuration boot";
      tx = "tmuxinator";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "tmux" "git" "man" "colored-man-pages" "colorize" "command-not-found" ];
    };
    localVariables = {
      ZSH_TMUX_AUTOSTART = true;
    };
    autosuggestion = {
      enable = true;
      highlight = "fg=244";
    };
    initContent = ''
      source ~/.p10k.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };
}
