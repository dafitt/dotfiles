{ pkgs, ... }: {

  users.users.root = {

    packages = with pkgs; [
      bashmount # easy mounting
      gparted # graphical disk partitioning tool
      gptfdisk
      hdparm
      micro # easy to use texteditor
    ];
  };
}
