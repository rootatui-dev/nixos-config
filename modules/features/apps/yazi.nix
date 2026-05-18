{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {
    
    packages.myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
    }; 

  };

  flake.nixosModules.yazi = { config, pkgs, lib, ... }: {
    options.features.yazi.enable = lib.mkEnableOption "Yazi";

    config = lib.mkIf config.features.yazi.enable {
      environment.systemPackages = [
        (inputs.wrapper-modules.wrappers.yazi.wrap {
          inherit pkgs;

          plugins = {
            smart-enter = pkgs.yaziPlugins.smart-enter;
          };

          settings = {
            yazi = {
              manager = {
                show_hidden = true;
                sort_by = "name";
                sort_sensitive = false;
                sort_revers = false;
                sort_dir_first = true;
              };

              opener = {
                edit = [
                  { run = "nvim \"$@\""; block = true; for = "unix"; }
                ];
              };
    
              keymap = {
                manager.prepend_keymap = [
                  { on = [ "l" ]; run = "plugin smart-enter"; desc = "Enter a directory or open a file"; }
                  { on = [ "Enter" ]; run = "plugin smart-enter"; desc = "Enter a directory or open a file"; }
                ];
              };
            };
          }; 
        })
    
      ];
    };
  };
  
}
