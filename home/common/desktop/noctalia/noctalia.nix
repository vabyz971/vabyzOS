{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  noctaliaPath = inputs.noctalia.packages.${system}.default;
  configDir = "${noctaliaPath}/share/noctalia-shell";
in
{
  # Install the Noctalia package for this user (CLI, assets, etc.)
  home.packages = [
    noctaliaPath
  ];

  # Seed the Noctalia QuickShell shell code into ~/.config/quickshell/noctalia-shell
  # once, then leave it writable so the GUI and the user can tweak it.
  home.activation.seedNoctaliaShellCode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    set -eu
    DEST="$HOME/.config/quickshell/noctalia-shell"
    SRC="${configDir}"

    if [ ! -d "$DEST" ]; then
      mkdir -p "$HOME/.config/quickshell"
      cp -R "$SRC" "$DEST"
      chmod -R u+rwX "$DEST"
    fi
  '';

  # Enable the noctalia-shell systemd user service
  systemd.user.services.noctalia-shell = {
    Unit = {
      Description = "Noctalia Shell - Wayland desktop shell";
      Documentation = "https://docs.noctalia.dev/docs";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
      Wants = [ "graphical-session-target" ];
    };
    Service = {
      ExecStart = "${pkgs.quickshell}/bin/quickshell --path %h/.config/quickshell/noctalia-shell";
      Restart = "always";
      RestartSec = 5;
      Environment = [
        "QT_QPA_PLATFORMTHEME=gtk3"
        "QML_IMPORT_PATH=${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml"
        "QML2_IMPORT_PATH=${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml"
      ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
