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
    initContent = ''
      fastfetch
    '';
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
      vupgrade = "
      cd ~/vabyzOS/
      sudo nix flake update
      nh os switch";
      vupdate = "nh os switch ~/vabyzOS#${variables.profile}";
      vgens = "nh os info";
      vcheck = "nix flake check";
      vboot = "nh os boot";
      vtest = "nh os test";
      vgc = "nix store gc";
      vhelp = "
      echo '## Liste les commandes disponibles ##'
      echo '# vupdate : Applique les changements'
      echo '# vupgrade : Met à jour le système'
      echo '# vhelp : Affiche cette liste'
      echo '# vgc : Garbage collect du store Nix'
      echo '# vcheck : Valide le flake'
      echo '# vboot : Reboot le système'
      echo '# vgens : Liste les générations du système'
      echo '# vtest : Applique sans créer de génération'
      ";
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
