{ inputs, config, pkgs, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkMerge;
  cfg = config.lemonix.modeling;
in
{
  options = {
    lemonix.modeling = {
      enable = mkEnableOption "modeling modules";
      cad.enable = mkEnableOption "cad utilities";
      printing.enable = mkEnableOption "printing utilities";
      avatar.enable = mkEnableOption "avatar utilities";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.cad.enable {
      home.packages = with pkgs; [
        freecad openscad
        ## https://github.com/NixOS/nixpkgs/issues/353961
        #blender
      ];
    })
    (mkIf cfg.printing.enable {
      home.packages = with pkgs; [
        prusa-slicer
      ];

      xdg.mimeApps.defaultApplications = {
        "text/x-gcode" = "PrusaGcodeviewer.desktop";
      };
    })
    (mkIf cfg.avatar.enable {
      home.packages = with pkgs; [
        #blender
        unityhub
        inputs.lemonake.packages.${pkgs.system}.alcom
      ];
    })
  ]);
}

