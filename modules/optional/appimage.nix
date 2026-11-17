# desc: Support des AppImage
{ ... }:
{
  # Appimage
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
