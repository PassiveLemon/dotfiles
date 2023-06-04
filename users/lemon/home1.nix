{ config, pkgs, ... }: {
  imports = [
    ./config/desktop.nix
    ../../modules/gtk.nix
    ../../modules/kitty.nix
    ../../modules/picom.nix
    ../../modules/vscode.nix
    ../../modules/spicetify.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  home = {
    username = "lemon";
    homeDirectory = "/home/lemon";
    stateVersion = "22.11";
    file = {
      ".config/" = {
        source = ../../dots/.config;
        recursive = true;
      };
      ".local/" = {
        source = ../../dots/.local;
        recursive = true;
      };
      ".vscode-oss/" = {
        source = ../../dots/.vscode-oss;
        recursive = true;
      };
      ".xinitrc" = {
        source = ../../dots/.xinitrc;
      };
    };
  };

  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
        };
      };
    };
    megasync.enable = true;
  };
  programs.home-manager.enable = true;
}
