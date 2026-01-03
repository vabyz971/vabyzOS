{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
let
  unstable = import inputs.nixpkgs-unstable;
in
{
  # install package
  environment.systemPackages =
    (with pkgs; [
      gpu-screen-recorder
      nwg-look
      brightnessctl
      ddcutil
      cava
      evolution-data-server
      cliphist
    ])
    ++ (with pkgs-unstable; [
      quickshell
      matugen
    ]);

  imports = [
    inputs.noctalia.nixosModules.default
  ];
  # enable the systemd service
  services.noctalia-shell.enable = false;
}
