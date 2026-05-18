{ self, inputs, ... }: { 

  perSystem = { pkgs, lib, self', ... }: {
    
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        xwayland-satellite.path =
          lib.getExe pkgs.xwayland-satellite;

        input.keyboard = {
          xkb.layout = "us,ru";
        };
  
        layout.gaps = 5;
 
        binds = {
          "Mod+S".spawn-sh =
            "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+T".spawn-sh = lib.getExe self'.packages.myKitty;
          "Mod+Q".close-window = null;
        };
      }; 
 
    };
  
  };

  flake.nixosModules.niri = { config, pkgs, lib, ... }: {
    options.features.niri.enable = lib.mkEnableOption "Niri";

    config = lib.mkIf config.features.niri.enable {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };
  };
 
}
