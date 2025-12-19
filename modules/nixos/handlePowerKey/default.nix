{ lib, ... }:
with lib;
{
  services.logind.settings.Login = mkDefault {
    # logind.conf(5)
    HandlePowerKey = "sleep";
    HandlePowerKeyLongPress = "poweroff";
  };
}
