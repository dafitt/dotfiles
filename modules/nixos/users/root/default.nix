{
  config,
  lib,
  pkgs,
  ...
}:

{
  users.users.root = {
    packages = with pkgs; [
      micro # easy to use texteditor
    ];
  };
}
