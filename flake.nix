{
  description = "A collection of project templates";

  outputs = { self }: {
    templates = {
      vagrant = {
        path = ./vagrant;
        description = "Vagrant NixOS server";
      };
      bootstrap-vm = {
        path = ./bootstrap-vm;
        description = "Bootstrap a NixOS server";
      };
      iso-standard = {
        path = ./iso-standard;
        description = "Bootstrap a NixOS server";
      };
    };
    defaultTemplate = self.templates.server;
    };
}
