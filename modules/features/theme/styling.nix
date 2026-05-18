{ self, ... }: {

  flake.nixosModules.styling = { config, lib, pkgs, ... }: {
   
    options.styling = {
      font = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "JetBrainsMono Nerd Font";
          description = "Global font";
        };
        size = lib.mkOption {
          type = lib.types.int;
          default = 11;
          description = "Global font size";
        };
      };        
    };

  };

}    
