{ pkgs, ... }: {

  home.packages = with pkgs; [
    borgbackup # deduplicating backup program
    nvme-cli # tool for nvme interface
  ];
}
