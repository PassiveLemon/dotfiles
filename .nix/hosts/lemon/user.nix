{ config, pkgs, ... }: {
  imports = [
    ../../modules/home-manager.nix
    ../../modules/xorg.nix
    ../../modules/gaming.nix
  ];

  environment.systemPackages = with pkgs; [
    unstable.hilbish networkmanagerapplet
    unstable.firefox (unstable.discord.override { withOpenASAR = true; })
    vlc gimp unstable.obs-studio authy htop neofetch xarchiver
    unstable.jellyfin-media-player appimage-run filezilla easytag
    unstable.github-desktop qbittorrent unstable.qpwgraph ventoy-bin
    pamixer playerctl pulseaudioFull
  ];

  # Fonts
  fonts = {
    fonts = with pkgs; [
      material-design-icons fira (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };
      subpixel.lcdfilter = "default";
    };
  };

  # Configs
  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      videoDrivers = [ "nvidia" ];
      displayManager = {
        #defaultSession = "none+bspwm";
        defaultSession = "none+awesome";
        lightdm = {
          enable = true;           
        };
      };
      #windowManager.bspwm = {
      #  enable = true;
      #};
      windowManager.awesome = {
        enable = true;
        package = (builtins.getFlake "github:fortuneteller2k/nixpkgs-f2k").packages.x86_64-linux.awesome-git;
        luaModules = with pkgs.luaPackages; [
          luarocks
        ];
      };
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
    pipewire = {
      enable = true;
      jack.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
    printing.enable = true;
    avahi = {
      enable = true;
      openFirewall = true;
    };
    gnome.gnome-keyring.enable = true;
  };
  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    nm-applet.enable = true;
  };
  qt5 = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
  security.pam.services.lemon.enableGnomeKeyring = true;
  security.rtkit.enable = true;
  xdg = {
    portal.enable = true;
    mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "pcmanfm.desktop";
      };
    };
  };

  # Home Manager
  home-manager = {
    useGlobalPkgs = true;
    users.lemon = { config, pkgs, ... }: {
      imports = [
        ./config/desktop.nix
        ./config/polybar.nix
        ../../modules/bspwm.nix
        ../../modules/dunst.nix
        ../../modules/gtk.nix
        ../../modules/kitty.nix
        ../../modules/picom.nix     
        ../../modules/spicetify.nix
        ../../modules/sxhkd.nix
        ../../modules/vscode.nix
      ];
      services = {
        easyeffects = {
          enable = true;
          package = pkgs.unstable.easyeffects;
          preset = "Lemon";
        };
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
      programs = {
        fish.enable = true;
        #eww = {
        #  enable = true;
        #  configDir = ../../modules/eww;
        #};
      };
      home = {
        file = {
          ".config/awesome/" = {
            source = ../../modules/awesome;
            recursive = true;
          };
          ".config/htop/htoprc".source = ../../modules/htop/htoprc;
          ".config/hilbish/init.lua".source = ../../modules/hilbish/init.lua;
          ".config/neofetch/config.conf".source = ../../modules/neofetch/config.conf;
          ".config/rofi/" = {
            source = ../../modules/rofi;
            recursive = true;
          };
        };
        stateVersion = "22.11";
      };
    };
  };

  # Unstable
  nixpkgs = {
    config = {
      packageOverrides = pkgs: {
        unstable = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz) {
          config = config.nixpkgs.config;
        };
      };
    };
  };
}
