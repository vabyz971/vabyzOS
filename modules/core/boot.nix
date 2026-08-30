{
  pkgs,
  variables,
  ...
}:
{

  # ======= Bootloader =======
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # ======= Time Zone =======
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "${variables.i18nLocalLanguage}";

  services = {

    # ======= Firmware =======
    fwupd.enable = true;

    # ======= SSD Optimizer =======
    fstrim.enable = true;

    xserver.xkb = {
      layout = "fr,us";
      options = "grp:alt_shift_toggle";
    };
  };

  # Forcez la console TTY à réutiliser configuration XKB
  console.useXkbConfig = true;

  # Enable experimental-features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Update system
  system.autoUpgrade = {
    enable = true;
    flake = "github:vabyz971/vabyzOS#${variables.profile}";
    flags = [
      "-L"
      "--update-input"
      "nixpkgs"
      "--update-input"
      "home-manager"
    ];
    dates = "12:00";
    randomizedDelaySec = "45min";
  };


  # Modern helper utility
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
  };

  # auto remove generation
  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 7d"; # Keep generations from the last 7 days
  #   # Or to keep the last 5 generations:
  #   # options = [ "+5" ];
  # };
  nix.settings.auto-optimise-store = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
