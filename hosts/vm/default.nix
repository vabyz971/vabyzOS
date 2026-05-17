{ variables, pkgs, ... }:
{
  imports = [
    ./hardware.nix

    # Core
    (variables.basePath "modules/core")

    # Pkgs
    (variables.basePath "modules/optional/appimage.nix")
    (variables.basePath "modules/optional/pkgs-store.nix")
    (variables.basePath "modules/optional/browsers.nix")
    (variables.basePath "modules/optional/fonts.nix")
    (variables.basePath "modules/optional/gnome-app.nix")
    (variables.basePath "modules/optional/nautilus.nix")
    (variables.basePath "modules/optional/gdm.nix")
    (variables.basePath "modules/optional/noctalia.nix")
    (variables.basePath "modules/optional/niri.nix")

  ];

  networking.hostName = "vm-vabyz";

  # VM guest additions to improve host-guest interaction
   services.spice-vdagentd.enable = true;
   services.qemuGuest.enable = true;
   virtualisation.vmware.guest.enable = pkgs.stdenv.hostPlatform.isx86;
   # https://github.com/torvalds/linux/blob/00b827f0cffa50abb6773ad4c34f4cd909dae1c8/drivers/hv/Kconfig#L7-L8
   virtualisation.hypervGuest.enable =
    pkgs.stdenv.hostPlatform.isx86 || pkgs.stdenv.hostPlatform.isAarch64;
   services.xe-guest-utilities.enable = pkgs.stdenv.hostPlatform.isx86;
   # The VirtualBox guest additions rely on an out-of-tree kernel module
   # which lags behind kernel releases, potentially causing broken builds.
   virtualisation.virtualbox.guest.enable = false;
}
