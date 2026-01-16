{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Burak Şen";
        email = "burak.sen@tum.de";
      };
      init.defaultBranch = "main";
    };
  };
}
