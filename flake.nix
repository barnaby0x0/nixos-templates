{
  description = "A collection of project templates";

  outputs = { self }: {
    templates = {
      server = {
        path = ./server;
        description = "Manage NixOS server remotely";
      };
    };
    defaultTemplate = self.templates.server;
    };
}
