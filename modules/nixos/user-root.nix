{ pkgs, ... }:
{
  meta.doc = "Configures the user 'root' on your system.";

  users.users.root = {
    packages = with pkgs; [
      micro
    ];
  };
}
