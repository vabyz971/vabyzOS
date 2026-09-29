# Kernel Zen : performances desktop, mais gros modules.
# Optionnel et explicite par host (défaut NixOS : linuxPackages).
{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
