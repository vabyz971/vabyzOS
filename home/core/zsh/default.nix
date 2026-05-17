{
  pkgs,
  lib,
  config,
  variables,
  ...
}:
{

  home.packages = with pkgs; [
    eza
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };

    shellAliases = {
      ll = "eza -la --icons --git";
      lt = "eza --tree --level=2";
      c = "clear";
      upgrade = "
      cd ~/vabyzOS/
      sudo nix flake update
      sudo nixos-rebuild switch --flake ~/vabyzOS/#${variables.profile}";
      update = "sudo nixos-rebuild switch --flake ~/vabyzOS/#${variables.profile}";
    };

    plugins = [
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./config;
        file = "p10k.zsh";
      }
    ];
  };
}
