{ pkgs, lib, ...}: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = ["git"];
    };

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };

    history.size = 10000;

    plugins = [
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./config;
        file = ".p10k.zsh";
      }
    ];
  };
}