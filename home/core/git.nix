{ settings, ... }:
{
  programs.git = {
    enable = true;
    settings.user.name = settings.gitUsername;
    settings.user.email = settings.gitEmail;
  };
}
