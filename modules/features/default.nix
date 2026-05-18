{ self, ... }: {
 
  flake.nixosModules.allFeatures = { ... }: {
    imports = with self.nixosModules; [
      styling
      niri
      noctalia
      kitty
      yazi
    ];
  };

}  
