{
  meta.doc = "Adds and configures the user 'david' on your system.";

  users.users."david" = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$pcK3/kPwWdp1n1umkef4U.$Zagv3CQLD.KPSh125WoOr0NPxWGkc2xyZaMRjpnxmb9";
    extraGroups = [ "wheel" ];
  };
}
