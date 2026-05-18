{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {
    
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;

      settings = 
        (builtins.fromJSON
          (builtins.readFile ./noctalia.json)).settings;
    };  
  
  };

  flake.nixosModules.noctalia = { config, pkgs, lib, ... }: {
    options.features.noctalia.enable = lib.mkEnableOption "Noctalia";
  
    config = lib.mkIf config.features.noctalia.enable {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
      ];
    };
  };

} 
