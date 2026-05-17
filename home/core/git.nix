{ variables, ... }:
{
  programs.git = {
    enable = true;
    settings.user.name = variables.gitUsername;
    settings.user.email = variables.gitEmail;
  };
}
