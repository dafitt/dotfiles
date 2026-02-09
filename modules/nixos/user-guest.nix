{
  #meta.doc = builtins.toFile "doc.md" "Adds and configures the user 'guest' on your system.";

  users.users."guest" = {
    isNormalUser = true;
    description = "Guest Account";
    password = "guest";
  };
}
