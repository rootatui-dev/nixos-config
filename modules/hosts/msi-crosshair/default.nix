{ self, inputs, ... }: {

  flake.nixosConfigurations.msiCrosshair = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.msiCrosshairConfiguration
    ];
  };

}
