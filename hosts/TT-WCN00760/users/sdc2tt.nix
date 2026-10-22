{
  inputs,
  pkgs,
  perSystem,
  ...
}:
#> legacyPackages.x86_64-linux.homeConfigurations."sdc2tt@TT-WCN00760".config
#$ home-manager --flake .#sdc2tt@TT-WCN00760 switch
{
  home.stateVersion = "26.05";

  imports = with inputs.self.homeModules; [
    imports
    user-sdc2tt

    wluma
  ];

  targets.genericLinux = {
    enable = true;
    # https://home-manager.dev/manual/unstable/usage/gpu-non-nixos.html
    gpu = {
      enable = true;
      nvidia = {
        enable = true;
        version = "595.99.02"; # $ nvidia-smi
        sha256 = "sha256-6HR3lYv3YwcFSTJL1a1slI66btIQ5EAFs+/4SUD24ew=";
        #$ nix store prefetch-file https://download.nvidia.com/XFree86/Linux-x86_64/595.99.02/NVIDIA-Linux-x86_64-595.99.02.run
      };
    };
    nixGL.prime.installScript = "nvidia"; # $ prime-offload
  };

  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (inputs.nixpkgs.lib.getName pkg) [
      "nvidia-x11"
    ];

  programs.umbriel.settings = {
    general.autostart = [
      "/opt/microsoft/msedge/microsoft-edge --profile-directory=Default --app-id=pkooggnaalmfkidjmlhoelhdllpphaga --app-url=https://outlook.office365.com/mail/"
      "/opt/microsoft/msedge/microsoft-edge --profile-directory=Default --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo '--app-url=https://teams.microsoft.com/v2/?clientType=pwa'"
    ];
  };
}
