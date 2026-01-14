{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    xdg-utils # Contient xdg-open
  ];

  services.dbus.enable = true;

  xdg.autostart.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];
    config = {
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.impl.portal.OpenURI" = [ "gtk" ];
      };
      common = {
        defautl = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [
          "gnome-keyring"
        ];
      };
    };
  };
}
