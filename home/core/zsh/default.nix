{
  pkgs,
  lib,
  config,
  hostname,
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
      plugins = [ "git" ];
    };

    shellAliases = {
      ll = "eza -la --icons --git";
      lt = "eza --tree --level=2";
      c = "clear";
      vupgrade = "
      cd ~/vabyzOS/
      nix flake update
      nh os switch .#${hostname}";
      vupdate = "nh os switch ~/vabyzOS#${hostname}";
      vgens = "nh os info";
      vcheck = "nix flake check";
      vboot = "nh os boot ~/vabyzOS#${hostname}";
      vtest = "nh os test ~/vabyzOS#${hostname}";
      vgc = "nix store gc";
      vhelp = "
      echo '## Liste les commandes disponibles ##'
      echo '# vupdate : Applique les changements'
      echo '# vupgrade : Met à jour le système'
      echo '# vhelp : Affiche cette liste'
      echo '# vgc : Garbage collect du store Nix'
      echo '# vcheck : Valide le flake'
      echo '# vboot : Applique au prochain démarrage'
      echo '# vgens : Liste les générations du système'
      echo '# vtest : Applique sans créer de génération'
      ";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./config;
        file = ".p10k.zsh";
      }
    ];
  };
}
