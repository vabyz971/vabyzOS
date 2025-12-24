{ config, ... }:
let 
    inherit (import ../../global/variables.nix) i18nLocalLanguage consoleKeyMap;
in
{

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "${i18nLocalLanguage}";

  # Configure console keymap
  console.keyMap = "${consoleKeyMap}";
}