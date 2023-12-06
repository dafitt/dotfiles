{
  # Distributed version control system
  # https://git-scm.com/
  programs.git = {
    enable = true;
    userName = "DigitalRobot";
    userEmail = "digitalrobot@outlook.de";

    # Signing commits
    signing = {
      key = "6C2B9ED4545C6B55F7A06BABC86333D048643464"; # fingerprint
      #signByDefault = true; # FIXME: breaks git
    };
  };
}
