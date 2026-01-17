{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    settings = {
      font_family = "JetBrainsMono Nerd Font Mono";
      font_size = "12.0";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      background_opacity = "0.95";
      window_padding_width = "10";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
    };
    extraConfig = "include ~/.config/kitty/themes/noctalia.conf";
  };
}
