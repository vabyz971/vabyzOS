# https://github.com/mkellyxp/nixbook/blob/main/chromebook.nix

{
  inputs,
  pkgs,
  lib,
  settings,
  ...
}:
let
  # Dossiers personnels stockés sur la carte SD (le reste du home reste sur l'eMMC, plus rapide)
  home = "/home/${settings.username}";
  sdHome = "/mnt/sd/${settings.username}";
  sdDirs = [
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Videos"
  ];

  # Version corrigée du package alsa-ucm-conf pour fonctionner également sur de nombreux Chromebooks
  # L'inclusion de cela dans tous les ordinateurs ne devrait pas interrompre l'audio des non-Chromebooks
  chromebook-ucm-conf =
    with pkgs;
    alsa-ucm-conf.overrideAttrs {
      crosSrc = fetchFromGitHub {
        owner = "WeirdTreeThing";
        repo = "alsa-ucm-conf-cros";
        rev = "a4e92135fd49e669b5ce096439289e05e25ae90c";
        hash = "sha256-3TpzjmWuOn8+eIdj0BUQk2TeAU7BzPBi3FxAmZ3zkN8=";
      };
      postInstall = ''
        cp -R $crosSrc/ucm2/* $out/share/alsa/ucm2
        cp -R $crosSrc/overrides/* $out/share/alsa/ucm2/conf.d
      '';
    };
in
{
  imports = [ inputs.disko.nixosModules.disko ];

  # Allègement 64 Go : pas de nautilus (yazi), pas de fwupd.
  programs.niri.useNautilus = lib.mkForce false;
  services.fwupd.enable = lib.mkForce false;

  # Carte SD 512 Go (label SD512, ext4) : stockage bulk, boot OK même absente.
  # Les dossiers de sdDirs sont montés (bind) depuis /mnt/sd/<user>/ vers le home :
  # mêmes chemins pour les applis, contenu sur la carte. Sans carte, ils restent vides.
  fileSystems = {
    "/mnt/sd" = {
      device = "/dev/disk/by-label/SD512";
      fsType = "ext4";
      options = [
        "nofail"
        "noatime" # moins d'écritures, préserve la carte
        "x-systemd.device-timeout=10"
      ];
    };
  }
  // lib.listToAttrs (
    map (
      dir:
      lib.nameValuePair "${home}/${dir}" {
        device = "${sdHome}/${dir}";
        fsType = "none";
        options = [
          "bind"
          "nofail"
        ];
        depends = [ "/mnt/sd" ];
      }
    ) sdDirs
  );

  # Crée les dossiers sur la carte avec les bons droits
  systemd.tmpfiles.settings."10-sd-home" = {
    ${sdHome}.d = {
      user = settings.username;
      group = "users";
      mode = "0700";
    };
  }
  // lib.genAttrs (map (dir: "${sdHome}/${dir}") sdDirs) (_: {
    d = {
      user = settings.username;
      group = "users";
      mode = "0755";
    };
  });

  boot = {
    # Pour flasher le firmware sur les Chromebooks
    kernelParams = [ "iomem=relaxed" ];
    # Prise en charge du stockage eMMC et du clavier Chromebook
    initrd.availableKernelModules = [
      "mmc_block"
      "usb_storage"
      "sdhci_pci"
      "i8042"
      "uas"
    ];
  };

  # Paramètre spécifique a l'hosts

  hardware.firmware = [ pkgs.sof-firmware ];
  networking.networkmanager.wifi.powersave = true;

  # Pour exécuter le script utilitaire du micrologiciel MrChromebox
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libusb1
    ];
  };

  disko.devices.disk.main = {
    device = "/dev/mmcblk1";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "500M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };

  # Pour l'audio SOF sur Chromebooks, adapté de https://github.com/WeirdTreeThing/chromebook-linux-audio
  # Expose les profils UCM du Chromebook à ALSA/PipeWire (cf. nixbook upstream).
  environment.sessionVariables.ALSA_CONFIG_UCM2 = "${chromebook-ucm-conf}/share/alsa/ucm2";
  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-increase-headroom.conf" ''
      monitor.alsa.rules = [
        {
          matches = [
            {
              node.name = "~alsa_output.*"
            }
          ]
          actions = {
            update-props = {
              api.alsa.headroom = 2048
            }
          }
        }
      ]
    '')
  ];
}
