{
  description = "A collection of project templates";

  outputs = { self }: {
    templates = {
      vagrant = {
        path = ./vagrant;
        description = "Vagrant NixOS server";
      };
      bootstrap = {
        path = ./bootstrap;
        description = "Bootstrap a NixOS server";
      };
    };
    defaultTemplate = self.templates.server;
    };
}
