{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    superfile
  ];
}
