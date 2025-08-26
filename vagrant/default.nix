{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./hardware-builder.nix
      ./bootloader.nix
      ./custom-configuration.nix
      #../commons/users/user
      ./users.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # remove the fsck that runs at startup. It will always fail to run, stopping
  # your boot until you press *.
  boot.initrd.checkJournalingFS = false;

  networking.hostName = "vagrant";
  # Services to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.extraConfig =
    ''
      PubkeyAcceptedKeyTypes +ssh-rsa
    '';

  # Enable DBus
  services.dbus.enable    = true;

  # Replace ntpd by timesyncd
  services.timesyncd.enable = true;
  
  ## Minimal setup to make it works with Vagrant next to this build
  # Minimal configuration for NFS support with Vagrant.
  #services.nfs.server.enable = true;
  
  ## Add firewall exception for VirtualBox provider 
  #networking.firewall.extraCommands = ''
  #  ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
  #'';

  ## Add firewall exception for libvirt provider when using NFSv4 
  #networking.firewall.interfaces."virbr1" = {                                   
  #  allowedTCPPorts = [ 2049 ];                                               
  #  allowedUDPPorts = [ 2049 ];                                               
  #};  

  environment.systemPackages = with pkgs; [
    findutils
    git
    gnumake
    htop
    iputils
    jq
    netcat
    nettools
    nfs-utils
    rsync
    tmux
    vim
    zsh
  ];

   nixpkgs.overlays = [
    (self: super: {
      glances = super.glances.overridePythonAttrs (old: rec {
        version = "4.3.2";
        src = super.fetchFromGitHub {
          owner = "nicolargo";
          repo = "glances";
          rev = "v${version}";
          hash = "sha256-pI0zPK7lfybln4garGtK1Sv7PxIaLUugQV5yJWOBudY=";
        };
        
        # Ajouter les dépendances manquantes
        propagatedBuildInputs = old.propagatedBuildInputs or [] ++ [
          super.python3Packages.shtab
        ];
      });
    })
  ];

  programs.zsh.enable = true;
  #users.mutableUsers = false;
  #users.users.vagrant.shell = pkgs.zsh;

  security.sudo.extraConfig =
    ''
      Defaults:root,%wheel env_keep+=LOCALE_ARCHIVE
      Defaults:root,%wheel env_keep+=NIX_PATH
      Defaults:root,%wheel env_keep+=TERMINFO_DIRS
      Defaults env_keep+=SSH_AUTH_SOCK
      Defaults lecture = never
      root   ALL=(ALL) SETENV: ALL
      %wheel ALL=(ALL) NOPASSWD: ALL, SETENV: ALL
    '';

}

