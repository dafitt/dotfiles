{ inputs, ... }:

#> perSystem.self.homeConfigurations."<user>@<host>"
{
  home.stateVersion = "25.11";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      SHARED
    ];
}
