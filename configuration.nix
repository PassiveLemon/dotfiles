{ config, lib, nixpkgs, home-manager, ... }: {
  imports = [
    ./hardware-configuration.nix
    /home/lemon/.nix/modules
#    /home/lemon/.nix/pkgs
    home-manager.nixosModule
  ];

  # Hard Drive
  fileSystems."/home/lemon/HDD2TB" = {
    device = "/dev/disk/by-uuid/F05212295211F4D6";
    fsType = "ntfs";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "22.11";
}