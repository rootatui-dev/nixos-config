{ self, inputs, ... }: {

  flake.nixosModules.msiCrosshairHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/652e7b34-63f7-498b-b1c3-8f613c170c2f"; 
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/652e7b34-63f7-498b-b1c3-8f613c170c2f";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3426-8495";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ]; 
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/0359db09-e953-42d1-9732-919a14d98e9a"; }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

}
 
