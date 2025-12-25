{ pkgs, ... }:
{
  users.users.root = {
    packages = with pkgs; [
      micro
    ];
  };
}
