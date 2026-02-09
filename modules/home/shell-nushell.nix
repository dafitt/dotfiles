{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures a new type of shell.
  #  <https://www.nushell.sh/>
  #  <https://github.com/nushell/nushell>
  #'';

  programs.nushell = {
    enable = true;
  };
}
