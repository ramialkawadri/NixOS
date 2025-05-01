{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      upgrade = "sudo nix flake update && sudo nixos-rebuild switch --upgrade";
      clean = "sudo nix-collect-garbage --delete-old; sudo /run/current-system/bin/switch-to-configuration boot";
      tx = "tmuxinator";
    };
    histSize = 10000;
    ohMyZsh = {
      enable = true;
      plugins = [ "tmux" "git" "man" "colored-man-pages" "colorize" "command-not-found" ];
    };
    autosuggestions.highlightStyle = "fg=244";
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
  users.defaultUserShell = pkgs.zsh;
}
