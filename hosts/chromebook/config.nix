{ pkgs, ... }:
let
  inherit (import ../../global/variables.nix) hostname;
in
{

  boot = {
    # Prise en charge du stockage eMMC et du clavier Chromebook
    initrd.availableKernelModules = [
      "mmc_block"
      "sdhci_pci"
      "i8042"
    ];
    plymouth = {
      enable = true;
      theme = "cuts";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "cuts" ];
        })
      ];
    };
  };

  # Gestion de l'énergie (crucial pour l'autonomie du Chromebook)
  services.tlp.enable = true;
  powerManagement.powertop.enable = true;

  # Bluetooth Support
  hardware.bluetooth.enable = true;

  # SSD Optimizer
  services.fstrim.enable = true;

  # Enable sound with pipewire.
  hardware.firmware = [ pkgs.sof-firmware ];
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # HostName
  networking.hostName = "${hostname}"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
