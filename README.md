# My daily driver's Snowfall🌨️🍂 NixOS❄️ desktop flake

![Hyprland-ricing](https://github.com/dafitt/dotfiles/assets/50248238/380705a7-4bd5-4431-81fe-ab04195e19f0)

-   [My daily driver's Snowfall🌨️🍂 NixOS❄️ desktop flake](#my-daily-drivers-snowfall️-nixos️-desktop-flake)
    -   [Programs and Features](#programs-and-features)
    -   [Installation](#installation)
    -   [Usage](#usage)
        -   [Flake](#flake)
            -   [Shell environment](#shell-environment)
            -   [Overview](#overview)
            -   [Build and switching](#build-and-switching)
            -   [Updating](#updating)
            -   [Rollback](#rollback)
            -   [Code formatting](#code-formatting)
        -   [Hyprkeys](#hyprkeys)
            -   [NixOS stable](#nixos-stable)
    -   [Structure](#structure)
        -   [You want to build from here?](#you-want-to-build-from-here)
    -   [Troubleshooting](#troubleshooting)
        -   [Some options in homes/ and modules/home/ are not being applied with nixos-rebuild](#some-options-in-homes-and-moduleshome-are-not-being-applied-with-nixos-rebuild)
    -   [👀, 🏆 and ❤️](#--and-️)

My dotfiles are not perfekt and never will be (unfortunately), but they strive to be:

-   fully declarative 📝
-   highly structured 🧱
-   suitable for everyday use 📅
-   a consistent environment that doesn't sacrifice its looks ✨

## Programs and Features

-   👥 Multiple hosts
-   🧍 Standalone home
-   ❄️🏗️ [Snowfall-lib structure](https://snowfall.org/reference/lib/#flake-structure)
-   ❄️💲 [Snowfall-flake commands](https://github.com/snowfallorg/flake?tab=readme-ov-file#usage)
-   📦 [Declarative flatpaks](https://github.com/gmodena/nix-flatpak)
-   📦 Appimage support

| Operating System 💻 | [NixOS](https://nixos.org/)                                                                                                              |
| ------------------: | :--------------------------------------------------------------------------------------------------------------------------------------- |
|   Window manager 🪟 | [Hyprland](https://hyprland.org/), [Gnome](https://www.gnome.org/)                                                                       |
|    Login manager 🔒 | greetd, gdm, tty                                                                                                                         |
|  Session locking 🔒 | [hyprlock](https://github.com/hyprwm/hyprlock)                                                                                           |
|         Terminal ⌨️ | [kitty](https://sw.kovidgoyal.net/kitty/)                                                                                                |
|            Shell 🐚 | [fish](https://fishshell.com/)                                                                                                           |
|           Prompt ➡️ | [starship](https://starship.rs/)                                                                                                         |
|     File manager 📁 | nautilus, pcmanfm, yazi                                                                                                                  |
|           Editor ✏️ | [vscode](https://code.visualstudio.com/)                                                                                                 |
|              Web 🌍 | [firefox](https://www.mozilla.org/en-US/firefox/new/), [librewolf](https://librewolf.net/), [epiphany](https://apps.gnome.org/Epiphany/) |
|          Theming 🎨 | [Stylix](https://github.com/danth/stylix) - modified [Catppuccin](https://github.com/catppuccin) Mocha                                   |
|       Networking 🌐 | networkmanager, connman                                                                                                                  |
|   Virtualization 🪟 | virt-manager, bottles                                                                                                                    |

## Installation

On a new host machine:

1. Install [NixOS](https://nixos.org/download/)
2. `git clone https://github.com/dafitt/dotfiles.git`
    1. Add a new system-configuration to _`/systems/<architecture>/<host>/default.nix`_ _(available `dafitt-nixos` options can be found at [/templates/system/default.nix](https://github.com/dafitt/dotfiles/blob/main/templates/system/default.nix))_
    2. Copy, import and commit _`hardware-configuration.nix`_!
    3. Set the correct `system.stateVersion`
    4. Add a new home-configuration to _`homes/<architecture>/<user>[@<host>]/default.nix`_ _(available `dafitt-home` options can be found at [/templates/home/default.nix](https://github.com/dafitt/dotfiles/blob/main/templates/home/default.nix))_
3. Remove some files for home-manager (or back them up): `rm ~/.config/user-dirs.dirs ~/.config/fish/config.fish ~/.config/hypr/hyprland.conf`
4. `sudo nixos-rebuild boot --flake .#<host>`
    - _NOTE First install: may take some time; especially flatpaks_
    1. Check for home-manager errors `systemctl status home-manager-<user>.service` and resolve them if necessary
5. `reboot`
6. Personal imperative setup:
    1. Configure monitor setup with `nwg-displays`
    2. [Syncthing](https://localhost:8384/) setup
    3. firefox: Sync Login
        1. NoScript
        2. 1Password
        3. Sidebery
    4. pavucontrol: Set standard audio output
    5. vscode: codeium plugin

## Usage

### Flake

Some basic flake commands

#### Shell environment

```shell
nix-shell shell.nix # only when on legacy-nix: enables flakes & git (works only locally)

nix shell github:snowfallorg/flake # optional: for the shorter `flake` commands

flake dev github:dafitt/dotfiles#default
# or
nix develop github:dafitt/dotfiles#default
```

#### Overview

Show flake outputs:

```shell
flake show github:dafitt/dotfiles
# or
nix flake show github:dafitt/dotfiles
```

Explore flake options:

```shell
flake option github:dafitt/dotfiles --pick
```

#### Build and switching

NixOS & Home-manager:

```shell
flake switch
# or
nixos-rebuild switch --flake .#<host>
```

Home-manager standalone:

```shell
home-manager switch --flake .#<user>@<host>
```

#### Updating

Flake inputs:

```shell
nix flake update --commit-lock-file
# or
flake update

# specific input
nix flake lock --update-input [input]
```

#### Rollback

NixOS confituration:

```shell
sudo nixos-rebuild switch --rollback
```

Home-manager standalone: see [Home-manager documentation](https://nix-community.github.io/home-manager/index.xhtml#sec-usage-rollbacks)

#### Code formatting

```shell
nix fmt [./folder] [./file.nix]
```

Further commands: [snowfallorg/flake](https://github.com/snowfallorg/flake?tab=readme-ov-file#usage)

### Hyprkeys

<kbd>SUPER_CONTROL</kbd> - System and Hyprland control \
<kbd>SUPER</kbd> - Window control \
<kbd>SUPER_ALT</kbd> - Applications \
<kbd>SHIFT</kbd> - reverse, grab, move

| Keybind                              | Dispatcher                    | Command                                                                                         |
| ------------------------------------ | ----------------------------- | ----------------------------------------------------------------------------------------------- |
| <kbd>SUPER_CONTROL Q</kbd>           | exit                          |                                                                                                 |
| <kbd>SUPER_CONTROL R</kbd>           | exec                          | hyprctl reload && forcerendererreload                                                           |
| <kbd>SUPER_CONTROL ADIAERESIS</kbd>  | exec                          | poweroff                                                                                        |
| <kbd>SUPER_CONTROL ODIAERESIS</kbd>  | exec                          | poweroff --reboot                                                                               |
| <kbd>SUPER ODIAERESIS</kbd>          | dpms                          | off                                                                                             |
| <kbd>SUPER UDIAERESIS</kbd>          | exec                          | systemctl suspend                                                                               |
| <kbd>SUPER DELETE</kbd>              | exec                          | hyprctl kill                                                                                    |
| <kbd>SUPER X</kbd>                   | killactive                    |                                                                                                 |
| <kbd>SUPER P</kbd>                   | pseudo                        |                                                                                                 |
| <kbd>SUPER S</kbd>                   | togglesplit                   |                                                                                                 |
| <kbd>SUPER H</kbd>                   | swapnext                      |                                                                                                 |
| <kbd>SUPER_SHIFT H</kbd>             | swapnext                      | prev                                                                                            |
| <kbd>SUPER F</kbd>                   | fullscreen                    |                                                                                                 |
| <kbd>SUPER A</kbd>                   | fullscreen                    | 1                                                                                               |
| <kbd>SUPER V</kbd>                   | togglefloating                |                                                                                                 |
| <kbd>SUPER B</kbd>                   | pin                           |                                                                                                 |
| <kbd>SUPER left</kbd>                | movefocus                     | l                                                                                               |
| <kbd>SUPER right</kbd>               | movefocus                     | r                                                                                               |
| <kbd>SUPER up</kbd>                  | movefocus                     | u                                                                                               |
| <kbd>SUPER down</kbd>                | movefocus                     | d                                                                                               |
| <kbd>SUPER Tab</kbd>                 | cyclenext                     |                                                                                                 |
| <kbd>SUPER_SHIFT left</kbd>          | movewindow                    | l                                                                                               |
| <kbd>SUPER_SHIFT right</kbd>         | movewindow                    | r                                                                                               |
| <kbd>SUPER_SHIFT up</kbd>            | movewindow                    | u                                                                                               |
| <kbd>SUPER_SHIFT down</kbd>          | movewindow                    | d                                                                                               |
| <kbd>SUPER_SHIFT Tab</kbd>           | swapnext                      |                                                                                                 |
| <kbd>SUPER_ALT left</kbd>            | resizeactive                  | -100 0                                                                                          |
| <kbd>SUPER_ALT right</kbd>           | resizeactive                  | 100 0                                                                                           |
| <kbd>SUPER_ALT up</kbd>              | resizeactive                  | 0 -100                                                                                          |
| <kbd>SUPER_ALT down</kbd>            | resizeactive                  | 0 100                                                                                           |
| <kbd>SUPER 1</kbd>                   | workspace                     | 1                                                                                               |
| <kbd>SUPER 2</kbd>                   | workspace                     | 2                                                                                               |
| <kbd>SUPER 3</kbd>                   | workspace                     | 3                                                                                               |
| <kbd>SUPER 4</kbd>                   | workspace                     | 4                                                                                               |
| <kbd>SUPER 5</kbd>                   | workspace                     | 5                                                                                               |
| <kbd>SUPER 6</kbd>                   | workspace                     | 6                                                                                               |
| <kbd>SUPER 7</kbd>                   | workspace                     | 7                                                                                               |
| <kbd>SUPER 8</kbd>                   | workspace                     | 8                                                                                               |
| <kbd>SUPER 9</kbd>                   | workspace                     | 9                                                                                               |
| <kbd>SUPER 0</kbd>                   | workspace                     | 10                                                                                              |
| <kbd>SUPER D</kbd>                   | workspace                     | name:D                                                                                          |
| <kbd>SUPER code:87</kbd>             | workspace                     | 1                                                                                               |
| <kbd>SUPER code:88</kbd>             | workspace                     | 2                                                                                               |
| <kbd>SUPER code:89</kbd>             | workspace                     | 3                                                                                               |
| <kbd>SUPER code:83</kbd>             | workspace                     | 4                                                                                               |
| <kbd>SUPER code:84</kbd>             | workspace                     | 5                                                                                               |
| <kbd>SUPER code:85</kbd>             | workspace                     | 6                                                                                               |
| <kbd>SUPER code:79</kbd>             | workspace                     | 7                                                                                               |
| <kbd>SUPER code:80</kbd>             | workspace                     | 8                                                                                               |
| <kbd>SUPER code:81</kbd>             | workspace                     | 9                                                                                               |
| <kbd>SUPER code:91</kbd>             | workspace                     | 10                                                                                              |
| <kbd>SUPER code:86</kbd>             | workspace                     | +1                                                                                              |
| <kbd>SUPER code:82</kbd>             | workspace                     | -1                                                                                              |
| <kbd>SUPER backspace</kbd>           | workspace                     | previous                                                                                        |
| <kbd>SUPER_SHIFT 1</kbd>             | movetoworkspacesilent         | 1                                                                                               |
| <kbd>SUPER_SHIFT 2</kbd>             | movetoworkspacesilent         | 2                                                                                               |
| <kbd>SUPER_SHIFT 3</kbd>             | movetoworkspacesilent         | 3                                                                                               |
| <kbd>SUPER_SHIFT 4</kbd>             | movetoworkspacesilent         | 4                                                                                               |
| <kbd>SUPER_SHIFT 5</kbd>             | movetoworkspacesilent         | 5                                                                                               |
| <kbd>SUPER_SHIFT 6</kbd>             | movetoworkspacesilent         | 6                                                                                               |
| <kbd>SUPER_SHIFT 7</kbd>             | movetoworkspacesilent         | 7                                                                                               |
| <kbd>SUPER_SHIFT 8</kbd>             | movetoworkspacesilent         | 8                                                                                               |
| <kbd>SUPER_SHIFT 9</kbd>             | movetoworkspacesilent         | 9                                                                                               |
| <kbd>SUPER_SHIFT 0</kbd>             | movetoworkspacesilent         | 10                                                                                              |
| <kbd>SUPER_SHIFT code:87</kbd>       | movetoworkspacesilent         | 1                                                                                               |
| <kbd>SUPER_SHIFT code:88</kbd>       | movetoworkspacesilent         | 2                                                                                               |
| <kbd>SUPER_SHIFT code:89</kbd>       | movetoworkspacesilent         | 3                                                                                               |
| <kbd>SUPER_SHIFT code:83</kbd>       | movetoworkspacesilent         | 4                                                                                               |
| <kbd>SUPER_SHIFT code:84</kbd>       | movetoworkspacesilent         | 5                                                                                               |
| <kbd>SUPER_SHIFT code:85</kbd>       | movetoworkspacesilent         | 6                                                                                               |
| <kbd>SUPER_SHIFT code:79</kbd>       | movetoworkspacesilent         | 7                                                                                               |
| <kbd>SUPER_SHIFT code:80</kbd>       | movetoworkspacesilent         | 8                                                                                               |
| <kbd>SUPER_SHIFT code:81</kbd>       | movetoworkspacesilent         | 9                                                                                               |
| <kbd>SUPER_SHIFT code:91</kbd>       | movetoworkspacesilent         | 10                                                                                              |
| <kbd>SUPER_SHIFT code:86</kbd>       | movetoworkspacesilent         | +1                                                                                              |
| <kbd>SUPER_SHIFT code:82</kbd>       | movetoworkspacesilent         | -1                                                                                              |
| <kbd>SUPER mouse_down</kbd>          | workspace                     | -1                                                                                              |
| <kbd>SUPER mouse_up</kbd>            | workspace                     | +1                                                                                              |
| <kbd>SUPER_CTRL left</kbd>           | movecurrentworkspacetomonitor | l                                                                                               |
| <kbd>SUPER_CTRL right</kbd>          | movecurrentworkspacetomonitor | r                                                                                               |
| <kbd>SUPER_CTRL up</kbd>             | movecurrentworkspacetomonitor | u                                                                                               |
| <kbd>SUPER_CTRL down</kbd>           | movecurrentworkspacetomonitor | d                                                                                               |
| <kbd>PRINT</kbd>                     | exec                          | grimblast copysave output /home/david/Pictures/$(date +'%F-%T\_%N.png')                         |
| <kbd>CONTROL PRINT</kbd>             | exec                          | grimblast --notify --freeze copysave area /home/david/Pictures/$(date +'%F-%T\_%N.png')         |
| <kbd>ALT PRINT</kbd>                 | exec                          | satty --filename - --fullscreen --output-filename /home/david/Pictures/$(date +'%F-%T\_%N.png') |
| <kbd>ALT_CONTROL PRINT</kbd>         | exec                          | satty --filename - --output-filename /home/david/Pictures/$(date +'%F-%T\_%N.png')              |
| <kbd>SUPER_ALT U</kbd>               | exec                          | gnome-characters                                                                                |
| <kbd>SUPER_ALT K</kbd>               | exec                          | wl-copy                                                                                         |
| <kbd>XF86Calculator</kbd>            | exec                          | gnome-calculator                                                                                |
| <kbd>SUPER_ALT V</kbd>               | exec                          | wl-copy'                                                                                        |
| <kbd>SUPER L</kbd>                   | exec                          | hyprlock                                                                                        |
| <kbd>SUPER_ALT A</kbd>               | exec                          | pavucontrol                                                                                     |
| <kbd>XF86AudioPlay</kbd>             | exec                          | playerctl play-pause                                                                            |
| <kbd>XF86AudioPause</kbd>            | exec                          | playerctl play-pause                                                                            |
| <kbd>XF86AudioStop</kbd>             | exec                          | playerctl stop                                                                                  |
| <kbd>XF86AudioNext</kbd>             | exec                          | playerctl next                                                                                  |
| <kbd>XF86AudioPrev</kbd>             | exec                          | playerctl previous                                                                              |
| <kbd>CTRL XF86AudioRaiseVolume</kbd> | exec                          | playerctl position 1+                                                                           |
| <kbd>CTRL XF86AudioLowerVolume</kbd> | exec                          | playerctl position 1-                                                                           |
| <kbd>ALT XF86AudioNext</kbd>         | exec                          | playerctld shift                                                                                |
| <kbd>ALT XF86AudioPrev</kbd>         | exec                          | playerctld unshift                                                                              |
| <kbd>ALT XF86AudioPlay</kbd>         | exec                          | systemctl --user restart playerctld                                                             |
| <kbd>SUPER Z</kbd>                   | exec                          | pypr zoom                                                                                       |
| <kbd>SUPER minus</kbd>               | exec                          | pypr zoom --0.5                                                                                 |
| <kbd>SUPER plus</kbd>                | exec                          | pypr zoom ++0.5                                                                                 |
| <kbd>SUPER_ALT mouse_down</kbd>      | exec                          | pypr zoom ++0.5                                                                                 |
| <kbd>SUPER_ALT mouse_up</kbd>        | exec                          | pypr zoom --0.5                                                                                 |
| <kbd>XF86AudioMute</kbd>             | exec                          | swayosd-client --output-volume mute-toggle                                                      |
| <kbd>ALT XF86AudioMute</kbd>         | exec                          | swayosd-client --input-volume mute-toggle                                                       |
| <kbd>XF86AudioMicMute</kbd>          | exec                          | swayosd-client --input-volume mute-toggle                                                       |
| <kbd>Caps_Lock</kbd>                 | exec                          | swayosd-client --caps-lock                                                                      |
| <kbd>SUPER_ALT P</kbd>               | exec                          | btop                                                                                            |
| <kbd>SUPER W</kbd>                   | exec                          | killall -SIGUSR1 .waybar-wrapped                                                                |
| <kbd>SUPER_ALT G</kbd>               | exec                          | codium                                                                                          |
| <kbd>SUPER_ALT PERIOD</kbd>          | exec                          | 1password                                                                                       |
| <kbd>SUPER_ALT E</kbd>               | exec                          | micro                                                                                           |
| <kbd>SUPER_ALT F</kbd>               | exec                          | nautilus                                                                                        |
| <kbd>SUPER SPACE</kbd>               | exec                          | fuzzel                                                                                          |
| <kbd>SUPER_ALT Z</kbd>               | exec                          | xdg-open https://localhost:8384                                                                 |
| <kbd>SUPER RETURN</kbd>              | exec                          | kitty                                                                                           |
| <kbd>SUPER_ALT T</kbd>               | exec                          | kitty                                                                                           |
| <kbd>SUPER_ALT M</kbd>               | exec                          | thunderbird                                                                                     |
| <kbd>SUPER_ALT B</kbd>               | exec                          | firefox                                                                                         |
| <kbd>XF86KbdBrightnessUp</kbd>       | exec                          | light -s sysfs/leds/kbd_backlight -A 10                                                         |
| <kbd>XF86KbdBrightnessDown</kbd>     | exec                          | light -s sysfs/leds/kbd_backlight -U 10                                                         |
| <kbd>XF86AudioRaiseVolume</kbd>      | execr                         | swayosd-client --output-volume raise                                                            |
| <kbd>XF86AudioLowerVolume</kbd>      | execr                         | swayosd-client --output-volume lower                                                            |
| <kbd>ALT XF86AudioRaiseVolume</kbd>  | exec                          | swayosd-client --input-volume raise                                                             |
| <kbd>ALT XF86AudioLowerVolume</kbd>  | exec                          | swayosd-client --input-volume lower                                                             |
| <kbd>XF86MonBrightnessUp</kbd>       | exec                          | swayosd-client --brightness raise                                                               |
| <kbd>XF86MonBrightnessDown</kbd>     | exec                          | swayosd-client --brightness lower                                                               |
| <kbd>SUPER mouse:272</kbd>           | movewindow                    |                                                                                                 |
| <kbd>SUPER mouse:273</kbd>           | resizewindow                  |                                                                                                 |

#### NixOS stable

If you want to use the [nixpkgs](https://github.com/NixOS/nixpkgs) stable branch, update the following inputs to `23.11` (as an example) in _[flake.nix](https://github.com/dafitt/dotfiles/blob/main/flake.nix)_ and rebuild the system. \
ATTENTION! When the last release of [nixpkgs](https://github.com/NixOS/nixpkgs) is some time away, then you will likely need to refactor some changed options. So directly after a new release is the best time to switch.

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager/release-23.11"; inputs.nixpkgs.follows = "nixpkgs"; };
    stylix.url = "github:danth/stylix/release-23.11";
  };
}
```

To still let specific packages follow nixos-unstable you can add a _`overlays/unstable/default.nix`_:

```shell
{ channels, ... }:

final: prev:
with channels.unstable; {
  # packages to get from inputs.unstable
  inherit
    gamescope
    lutris
    vscodium
    ;
}
```

## Structure

I use [snowfall-lib](https://github.com/snowfallorg/lib), so every _`default.nix`_ is automatically imported.

My systems and homes are assembled using custom modules. Any custom module has at least one option which name matches the folder: `config.custom.myModule.enable`. Keep in mind some modules are enabled by default some are not. Special modules:

-   Desktops
    -   desktops/gnome
    -   desktops/hyprland
-   Suites (disabled by default)
    -   development
    -   editing
    -   gaming
    -   music
    -   office
    -   ricing
    -   social
    -   virtualization
    -   web
-   Firmly integrated, non-disableable
    -   stylix

Modules in [modules/nixos/](https://github.com/dafitt/dotfiles/blob/main/modules/nixos) are built with the standard `nixos-rebuild` command; [modules/home/](https://github.com/dafitt/dotfiles/blob/main/modules/home) with `home-manager` (standalone) **or** in addition to `nixos-rebuild` if the homes-hostname "\<user>[@\<host>]" matches with the host your building on (this is done by [snowfall-lib](https://github.com/snowfallorg/lib) with the systemd-service _home-manager-<user>.service_).

Some [modules/home/](https://github.com/dafitt/dotfiles/blob/main/modules/home) are automatically activated, if the sister module in [modules/nixos/](https://github.com/dafitt/dotfiles/blob/main/modules/nixos) is enabled e.g. `options.custom.gaming.enableSuite = mkBoolOpt (osConfig.custom.gaming.enableSuite or false) "...`. The special attribute set `osConfig` is only present when building with `nixos-rebuild`.

Last but no least, to keep things simple I put some very specific configuration directly into the systems themselves.

### You want to build from here?

What you have to customize:

-   [ ] [modules/nixos/time/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/nixos/time/default.nix): timezone
-   [ ] [modules/nixos/locale/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/nixos/locale/default.nix): locale
-   [ ] [modules/nixos/users/main/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/nixos/users/main/default.nix): username
-   [ ] [modules/home/office/thunderbird/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/office/thunderbird/default.nix)
-   [ ] [modules/home/web/firefox/default.nix](https://github.com/dafitt/dotfiles/blob/37693f1b9fd4e4d8429506a882e9f9d14da31446/modules/home/web/firefox/default.nix#L168): searx search engine is a local instance/server, use a official one or setup your own
-   [ ] [systems/\<architecure\>/\<host\>/default.nix](https://github.com/dafitt/dotfiles/blob/main/templates/system/default.nix): obviously your own host-configuration
    -   [ ] `hardware-configuration.nix`
    -   [ ] maybe some host-specific `configuration.nix`: make sure to import it: `imports = [ ./configuration.nix ];`
-   [ ] [homes/\<architecure\>/\<user\>[@\<host\>]/default.nix](https://github.com/dafitt/dotfiles/blob/main/templates/home/default.nix): obviously your own home-configuration

Optionally:

-   [ ] [modules/home/desktops/hyprland/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/desktops/hyprland/default.nix): familiar keybindings
-   [ ] [modules/home/stylix/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/stylix/default.nix): custom base16 theme / icon theme
-   [ ] Packages and programs you need

## Troubleshooting

### Some options in [homes/](https://github.com/dafitt/dotfiles/blob/main/homes) and [modules/home/](https://github.com/dafitt/dotfiles/blob/main/modules/home) are not being applied with nixos-rebuild

Check if your option is being set through `osCfg`. Like this:

```nix
enable = mkBoolOpt (osCfg.enable or config.dafitt.gaming.enableSuite) "Enable steam";
```

If that is the case and `osCfg.enable` is not `null` then the `osCfg`-option will be preferred. Even if it is `false`.

To solve this set your option to `true` in [systems/](https://github.com/dafitt/dotfiles/blob/main/systems) and [modules/nixos/](https://github.com/dafitt/dotfiles/blob/main/modules/nixos).

## 👀, 🏆 and ❤️

-   [Vimjoyer - Youtube](https://www.youtube.com/@vimjoyer)
-   [IogaMaster - Youtube](https://www.youtube.com/@IogaMaster)
-   [mikeroyal/NixOS-Guide](https://github.com/mikeroyal/NixOS-Guide)
-   [jakehamilton/config](https://github.com/jakehamilton/config)
-   [IogaMaster/dotfiles](https://github.com/IogaMaster/dotfiles)
-   [IogaMaster/snowfall-starter](https://github.com/IogaMaster/snowfall-starter)
-   [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
-   [Aylur/dotfiles](https://github.com/Aylur/dotfiles)
