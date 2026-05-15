{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {
    
    packages.myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;

      settings = {
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
      };

    }; 

  };

}
