{
  description = "A collection of project templates";

  outputs = { self }: {
    templates = {
      server = {
        path = ./server;
        description = "Manage NixOS server remotely";
      };
      vagrant = {
        path = ./vagrant;
        description = "Vagrant NixOS server";
      };
    };
    defaultTemplate = self.templates.server;
    };
}
