{ inputs, pkgs, perSystem, ... }:
#> legacyPackages.x86_64-linux.homeConfigurations."sdc2tt@TT-WCN00760".config
#$ home-manager --flake .#sdc2tt@TT-WCN00760 switch
{
  home.stateVersion = "26.05";

  imports = with inputs.self.homeModules; [
    imports
    user-sdc2tt
  ];

  targets.genericLinux = {
    enable = true;

    # https://home-manager.dev/manual/unstable/usage/gpu-non-nixos.html
    gpu = {
      enable = true;
      nvidia = {
        enable = true;
        version = "595.99.02"; #$ nvidia-smi
        sha256 = "sha256-6HR3lYv3YwcFSTJL1a1slI66btIQ5EAFs+/4SUD24ew=";
        #$ nix store prefetch-file https://download.nvidia.com/XFree86/Linux-x86_64/595.99.02/NVIDIA-Linux-x86_64-595.99.02.run
      };
    };
    # nixGL = {
    #   packages = inputs.nixGL.packages;
    #   vulkan.enable = true;
    # };
  };
  # programs.zed-editor.package = mkForce (config.lib.nixGL.wrap pkgs.zed-editor);
  # programs.kitty.package = mkForce (config.lib.nixGL.wrap pkgs.kitty);

  home.packages = with pkgs; [
    # https://github.com/nix-community/nixGL/blob/main/flake.nix
    perSystem.nixGL.nixGLIntel
    perSystem.nixGL.nixVulkanIntel
  ];

  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (inputs.nixpkgs.lib.getName pkg) [
      "nvidia-x11"
    ];
}
