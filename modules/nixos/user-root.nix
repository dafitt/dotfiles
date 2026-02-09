{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Configures the user 'root' on your system.";

  users.users.root = {
    packages = with pkgs; [
      micro
    ];
  };
}
