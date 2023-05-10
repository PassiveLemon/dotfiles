{ config, pkgs, nixpkgs-f2k, ... }:
#let pkgs = import <nixpkgs> {}; in
#pkgs.callPackage ../../pkgs/lemonwalls.nix
{
  imports = [
    ../../modules/xorg.nix
    ../../modules/gaming.nix
    #../../pkgs/lemonwalls.nix
  ];

  nixpkgs = {
    overlays = [
      (final: prev:
        {
          awesome = nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
        })
    ];
  };

  environment.systemPackages = with pkgs; [
    rofi hilbish vscodium github-desktop firefox betterdiscordctl (discord.override { withOpenASAR = true; })
    vlc mpv feh gimp obs-studio authy xarchiver filezilla easytag easyeffects qpwgraph
    pamixer playerctl stress appimage-run htop neofetch ventoy-bin
    libsForQt5.kruler tauon haruna
    i3lock-fancy-rapid
  ];

  # Fonts
  fonts = {
    fonts = with pkgs; [
      material-design-icons fira (nerdfonts.override { fonts = [ "FiraCode" ]; }) cozette
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      allowBitmaps = true;
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
        defaultSession = "none+awesome";
        lightdm = {
          enable = true;      
        };
      };
      windowManager.awesome = {
        enable = true;
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
    flatpak.enable = true;
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
}