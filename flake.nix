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
      k8 = {
        path = ./k8plus;
        description = "K8 NixOS desktop";
      };
    };
    defaultTemplate = self.templates.server;
    };
}
