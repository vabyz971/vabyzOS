{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (import ../../../../global/variables.nix) host;
in
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
      sudo nixos-rebuild switch --flake ~/vabyzOS/#${host.flakeProfile}";
      update = "sudo nixos-rebuild switch --flake ~/vabyzOS/#${host.flakeProfile}";
    };

    plugins = [
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./config;
        file = "p10k.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
    ];
  };
}
