{
  # I don't like the default but my hand just types it
  cat = "bat";
  top = "$TOP";
  df = "duf";

  # Navigation;
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  # Colors
  grep = "grep --color=auto";

  # rsync
  rsync-copy = "rsync --archive --progress -zvh";
  rsync-move = "rsync --archive --progress -zvh --remove-source-files";
  rsync-sync = "rsync --archive --update --delete --progress -zvh";
  rsync-update = "rsync --archive --update --progress -zvh";

  # flatpak
  "flatpak install" = "flatpak install --user --or-update --assumeyes";
}