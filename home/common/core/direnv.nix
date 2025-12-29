{pkgs, ...}:{
  programs.direnv = {
    enable = true;
    package = pkgs.unstable.direnv;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true; # better than native direnv nix functionality - https://github.com/nix-community/nix-direnv
      package = pkgs.unstable.nix-direnv;
    };
  }
}