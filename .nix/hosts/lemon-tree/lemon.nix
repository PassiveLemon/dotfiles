{ config, pkgs, ... }: {
  imports = [
    ../../modules/home-manager.nix
    ./configs
    #../../modules/real-vnc-viewer
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    # Desktop
    xorg.xrandr xorg.xhost libsecret gnome.seahorse gnome.gnome-keyring
    lightdm bspwm sxhkd picom feh polybar
    kora-icon-theme

    # Apps & Programs
    kitty rofi firefox gparted pavucontrol pulseeffects-legacy appimage-run distrobox lutris spotify
    gimp obs-studio github-desktop discord steam vscode jellyfin-media-player vlc qbittorrent megasync
    wine winetricks lxappearance htop neofetch
  ];

  # Fonts
  fonts.fonts = with pkgs; [
    material-design-icons fira (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
  ];

  # Configs
  services = {
    xserver = {
      enable = true;
      displayManager = {
        defaultSession = "xfce+bspwm";
        lightdm.enable = true;
        };
      desktopManager = {
        xfce = {
          enable = true;
          noDesktop = true;
        };
      };
      windowManager.bspwm = {
        enable = true;
        configFile = "/home/lemon/.config/bspwm/bspwmrc";
        sxhkd.configFile = "/home/lemon/.config/sxhkd/sxhkdrc";
      };
      videoDrivers = [ "nvidia" ];
      libinput.mouse.middleEmulation = false;
      libinput.touchpad.middleEmulation = false;
    };
    picom.enable = true;
    gnome.gnome-keyring.enable = true;
    openssh.enable = true;
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

    # Home-Manager
  home-manager.users.lemon = { pkgs, ... }: {
    home.stateVersion = "22.11";
    imports = [];
    programs.bash.enable = true;
  };
}