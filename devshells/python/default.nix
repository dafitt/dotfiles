{ pkgs, ... }:
#$ nix develop .#python
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        tabulate
      ]
    ))
  ];
}
