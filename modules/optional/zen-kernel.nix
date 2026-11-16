# Kernel Zen : performances desktop, mais gros modules.
# Optionnel et explicite par host (défaut NixOS : linuxPackages).
# Pris sur unstable : les modules qui en dépendent (driver NVIDIA, v4l2loopback)
# suivent alors aussi unstable et restent à jour.
{ pkgs-unstable, ... }:
{
  boot.kernelPackages = pkgs-unstable.linuxPackages_zen;
}
