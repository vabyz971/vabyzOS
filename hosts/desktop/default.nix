{ pkgs, config, ... }:
{

  imports = [
    ./hardware.nix
    ../common/core
    ../common/optional/nvidia.nix
    ../common/optional/docker.nix
    ../common/optional/qemu.nix
    ../common/optional/game.nix
    ../common/optional/fonts.nix
    ../common/optional/appimage.nix
    ../common/desktop/gnome
  ];

  boot = {
    # Virtual device
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  };

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # SSD Optimizer
  services.fstrim.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
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
  networking.hostName = "2B-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
