{ ... }: let
  inherit (import ../../global/variables.nix) printEnable;
in {
  services = {
    printing = {
      enable = printEnable;
    };
    avahi = {
      enable = printEnable;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = printEnable;
  };
}
