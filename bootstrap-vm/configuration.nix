{
  modulesPath,
  lib,
  pkgs,
  ...
} @ args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;
  services.qemuGuest.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.groups.user = {
      name = "user";
      members = [ "user" ];
    };

  users.users.user = {
      createHome = true;
      description = "Main User";
      extraGroups     = [ "networkmanager" "users" "wheel" ];
      group = "user";
      home = "/home/user";
      hashedPassword = "$6$FdYq/J2XbivlPLEG$Jx7ppF65H0vj/.6/118K/d1LUFa4dyucTSk9KTSxlDhIHGH/puUDIIGNx5fcn5H7XgTHPPa.TyyaIugiLw6GF/";
      isNormalUser = true;
      shell = pkgs.bash;
      packages = with pkgs; [
        home-manager
      ];
    };

  users.users.user.openssh.authorizedKeys.keys = ["# CHANGE"] ++ (args.extraPublicKeys or []);
  # users.users.root.openssh.authorizedKeys.keys = ["# CHANGE"] ++ (args.extraPublicKeys or []);

  security.sudo.extraRules = [
  {
    users = ["user"];
    commands = [
    {
      command = "ALL";
      options = ["NOPASSWD"];
    }
    ];
  }
];

  system.stateVersion = "25.05";
}
