{ config, pkgs, ... }:

{
  # Définir stateVersion pour éviter l'avertissement
  system.stateVersion = "25.05"; # Utilisez la version appropriée

  # Configuration de l'utilisateur nixos avec tous les attributs requis
  users.users.nixos = {
    isNormalUser = true;
    group = "nixos";
    extraGroups = [ "wheel" ]; # Pour les privilèges sudo
    # Create password with openssl passwd -6 yourpassword
    hashedPassword = "$6$2u4jbxPZh.SjV5z5$9axyOyNKHNVRRJHdrSrEQzlxZiV.zbmUWRknMGfm9sGFJ6CnmzkmQd7xXzWFPXoAvnFLEox1Xe39pzl08xuj70";
  };

  # Créer le groupe nixos
  users.groups.nixos = {};

  # Configuration réseau
  networking.hostName = "nixos-live";
  networking.networkmanager.enable = true;

  # Activer SSH
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = true;
  };

  # Autoriser les utilisateurs wheel à utiliser sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Inclure les outils nécessaires
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    vim
  ];

  # Configuration spécifique à l'environnement live
  isoImage = {
    isoName = "nixos-custom.iso";
    contents = [
      {
        source = "${pkgs.nixos-artwork.wallpapers.simple-dark-gray}/share/artwork/nixos";
        target = "/background.png";
      }
    ];
  };
}