{ config, pkgs, ... }: {
  imports = [
    ../../modules/home-manager.nix
  ];

  # Packages
  environment.systemPackages = with pkgs; [ 
    # Desktop functionality
    xorg.xrandr xorg.xhost libsecret gnome.seahorse gnome.gnome-keyring
    pcmanfm gparted pavucontrol feh polybar rofi lxappearance
    matcha-gtk-theme kora-icon-theme

    # Apps and programs
    lutris grapejuice
    firefox jellyfin-media-player vlc armcord
    appimage-run distrobox filezilla r2mod_cli gamemode protonup-ng dxvk
    gimp flameshot obs-studio github-desktop vscode megasync
    wine winetricks htop neofetch authy easyeffects qpwgraph
  ];

  # Fonts
  fonts.fonts = with pkgs; [
    material-design-icons fira (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # Configs
  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      displayManager = {
        defaultSession = "none+bspwm";
        lightdm.enable = true;
      };
      windowManager.bspwm = {
        enable = true;
        configFile = "/home/lemon/.config/bspwm/bspwmrc";
      };
      videoDrivers = [ "nvidia" ];
      libinput = {
        enable = true;
        mouse = {
          middleEmulation = false;
          accelProfile = "flat";
          accelSpeed = "-0.5";
        };
        touchpad = {
          middleEmulation = false;
          accelProfile = "flat";
          accelSpeed = "-0.5";
        };
      };
    };
    gnome.gnome-keyring.enable = true;
  };
  programs = {
    dconf.enable = true;
    steam.enable = true;
    seahorse.enable = true;
  };
  qt5 = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
  security.pam.services.lemon.enableGnomeKeyring = true;

  # Home Manager
  home-manager = {
    useGlobalPkgs = true;
    users.lemon = { config, pkgs, ... }: {
      imports = [
        ./config
        ../../modules/spicetify.nix
      ];
      programs = {
        bash.enable = true;
        #eww = {
        #  enable = true;
        #  configDir = ../../../.config/eww;
        #};
      };
      home.stateVersion = "22.11";
    };
  };

  # Overlays
  nixpkgs.overlays =
  let
    myOverlay = self: super: {
      discord = super.discord.override { withOpenASAR = true; };
    };
  in
  [ myOverlay ];
}
