{ pkgs, inputs, ... }:

#$ nix develop .#python
pkgs.mkShell {
  packages =
    with pkgs;
    with inputs;
    [
      (pkgs.python3.withPackages (
        python-pkgs: with python-pkgs; [
          tabulate
        ]
      ))
    ];
}
