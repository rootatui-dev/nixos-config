{ self, inputs, ... }: {

  perSystem = { pkgs, ...}: {

    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
    };
  
  };

  flake.nixosModules.kitty = { config, pkgs, lib, ... }: {
    options.features.kitty.enable = lib.mkEnableOption "Kitty";

    config = lib.mkIf config.features.kitty.enable {
      environment.systemPackages = [
        (inputs.wrapper-modules.wrappers.kitty.wrap {
          inherit pkgs;

          settings = {
            font_family = config.styling.font.name;
            font_size = config.styling.font.size;
            background_opacity = "0.9";
          };
        })
      ];
    };

  };

}
