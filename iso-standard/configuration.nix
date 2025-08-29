{ config, pkgs, ... }:

{
  system.stateVersion = "25.05";
  # Définir le mot de passe pour l'utilisateur nixos
  users.users.nixos = {
    hashedPassword = "$6$X9Nl4WYPme3seZR.$kJP0Vph04KYU1BkSr.I4wBUklUIAJLTs5yhZqqwNkYxpazYweRmEFvyKkseBFdI2stzG6PrzLR/8kxyeb6yfO1";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # Important if you plan to use with a dedicated builder vm.
  users.users.nixos.openssh.authorizedKeys.keys = ["# CHANGEME"];

  security.sudo.extraRules = [
  {
    users = ["nixos"];
    commands = [
    {
      command = "ALL";
      options = ["NOPASSWD"];
    }
    ];
  }
  ];

  # Autres configurations nécessaires pour l'ISO
  networking.hostName = "nixos-live";
  
  # Activer SSH si nécessaire pour nixos-anywhere
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  
  # Inclure les outils nécessaires
  environment.systemPackages = with pkgs; [
    nixos-anywhere
    curl
    wget
    git
  ];
}
