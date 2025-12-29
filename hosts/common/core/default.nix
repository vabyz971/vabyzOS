{
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (import ../../../global/variables.nix) i18nLocalLanguage consoleKeyMap;
in
{

  # ======= Bootloader =======
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ======= Time Zone =======
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "${i18nLocalLanguage}";

  # Configure console keymap
  console.keyMap = "${consoleKeyMap}";

  # ======= Packages =======
  nixpkgs.config.allowUnfree = true;
  imports = [ ./pkgs.nix ];

  # ======= Firmware =======
  services.fwupd.enable = true;

  # ======= System =======
  # Enable experimental-features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Update system
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "-L" # print build logs
    ];
    dates = "12:00";
    randomizedDelaySec = "45min";
  };

  # auto remove generation
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d"; # Keep generations from the last 7 days
    # Or to keep the last 5 generations:
    # options = [ "+5" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
