# My daily driver's Snowfall🌨️🍂 NixOS❄️ desktop flake

![Hyprland-ricing](https://github.com/dafitt/dotfiles/assets/50248238/380705a7-4bd5-4431-81fe-ab04195e19f0)

-   [My daily driver's Snowfall🌨️🍂 NixOS❄️ desktop flake](#my-daily-drivers-snowfall️-nixos️-desktop-flake)
    -   [Notes](#notes)
    -   [Programs and Features](#programs-and-features)
    -   [Installation](#installation)
        -   [On a new host machine](#on-a-new-host-machine)
    -   [Configuration](#configuration)
        -   [NixOS stable branch](#nixos-stable-branch)
        -   [Importing my modules](#importing-my-modules)
        -   [You want to build from here?](#you-want-to-build-from-here)
    -   [Usage](#usage)
        -   [Flake](#flake)
            -   [Shell environment](#shell-environment)
            -   [Overview](#overview)
            -   [Build and switch configuration](#build-and-switch-configuration)
            -   [Update flake inputs](#update-flake-inputs)
            -   [Rollback](#rollback)
            -   [Code formatting](#code-formatting)
        -   [Hyprkeys](#hyprkeys)
    -   [Structure](#structure)
        -   [Modules](#modules)
    -   [Troubleshooting](#troubleshooting)
        -   [Some options in modules/home/ or homes/ are not being applied with nixos-rebuild](#some-options-in-moduleshome-or-homes-are-not-being-applied-with-nixos-rebuild)
        -   [Unable to see fonts](#unable-to-see-fonts)
        -   [bluetoothd: Failed to set mode: Failed (0x03)](#bluetoothd-failed-to-set-mode-failed-0x03)
    -   [👀, 🏆 and ❤️](#--and-️)

My dotfiles are not perfekt, but they strive to be:

-   fully declarative 📝
-   highly structured 🧱
-   modular 🎛️
-   a consistent look'n'feel ✨
-   KISS (keep it stupid simple)🥴

## Notes

This flake can and will radically change as I learn, discover new things and have new ideas.

## Programs and Features

-   👥 Multiple hosts
-   🧍 Standalone home
-   ❄️🏗️ [Snowfall-lib structure](https://snowfall.org/reference/lib/#flake-structure)
-   ❄️ almost every module can be disabled
-   ❄️💲 [Snowfall-flake commands](https://github.com/snowfallorg/flake?tab=readme-ov-file#usage)
-   📦 [Declarative flatpaks](https://github.com/gmodena/nix-flatpak)

| Operating System 💻 | [NixOS](https://nixos.org/)                                                                                                                                    |
| ------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   Window manager 🪟 | [GNOME](https://www.gnome.org/) with extensions, [Hyprland](https://hyprland.org/) with plugins                                                                |
|    Login manager 🔒 | gdm, greetd, tty                                                                                                                                               |
|  Session locking 🔒 | [hyprlock](https://github.com/hyprwm/hyprlock)                                                                                                                 |
|         Terminal ⌨️ | [kitty](https://sw.kovidgoyal.net/kitty/)                                                                                                                      |
|            Shell 🐚 | [fish](https://fishshell.com/)                                                                                                                                 |
|           Prompt ➡️ | [starship](https://starship.rs/)                                                                                                                               |
|     File manager 📁 | nautilus, pcmanfm, yazi                                                                                                                                        |
|           Editor ✏️ | [VSCodium](https://vscodium.com/)                                                                                                                              |
|              Web 🌍 | [Firefox](https://www.mozilla.org/en-US/firefox/new/), [Librewolf](https://librewolf.net/), [Epiphany](https://apps.gnome.org/Epiphany/)                       |
|          Theming 🎨 | [Stylix](https://github.com/danth/stylix) - modified [catppuccin](https://github.com/catppuccin) 🌿 [Mocha](https://github.com/catppuccin/catppuccin#-palette) |
|       Networking 🌐 | networkmanager, connman                                                                                                                                        |
|   Virtualization 🪟 | virt-manager, bottles                                                                                                                                          |

## Installation

### On a new host machine

1. Install [NixOS](https://nixos.org/download/) and enable the (experimental) nix feature [flakes](https://wiki.nixos.org/wiki/Flakes#Enabling_flakes).

2. **Dotfiles preparation** (mandatory changes to my dotfiles):

    1. `git clone https://github.com/dafitt/dotfiles.git`.
    2. `cd dotfiles`.
    3. Read and understand my dotfiles' structure and code.

    4. Add a (**your**) new system-configuration to _`/systems/<architecture>/<host>/default.nix`_.  
       _Available `dafitt-nixos` options can be found at [templates/system/default.nix](https://github.com/dafitt/dotfiles/blob/main/templates/system/default.nix)._

    5. Copy and import _`hardware-configuration.nix`_.

    6. Set the correct current `system.stateVersion`.

    7. Add a (**your**) new home-configuration to _`homes/<architecture>/<user>[@<host>]/default.nix`_  
       _Available `dafitt-home` options can be found at [templates/home/default.nix](https://github.com/dafitt/dotfiles/blob/main/templates/home/default.nix)._

    8. Commit all changes:
        ```
        git add . && git commit -m "systems: added <host>"
        ```

    9. Uncomment `nixConfig` in [flake.nix](https://github.com/dafitt/dotfiles/blob/main/flake.nix) and enter `nix develop` on your first build for faster build time.

3. Build:

    1. Enter `nix-shell` and then `nix develop .#default`
    2. `sudo nixos-rebuild boot --flake .#<host>`
    3. Check for home-manager errors with `systemctl status home-manager-<user>.service` and resolve them if necessary
    - _NOTE: First install may take some time; especially with flatpaks enabled._

4. `reboot`.

5. Personal imperative setup:

    1. Configure monitor setup with `nwg-displays`
    2. [Syncthing](https://localhost:8384/) setup
    3. firefox: Sync Login
        1. NoScript
        2. 1Password
        3. Sidebery
    4. pavucontrol: Set standard audio output
    5. vscode: codeium plugin

### Only in a new home environment

1. Install [nix](https://nixos.org/download/) and enable the (experimental) nix feature [flakes](https://wiki.nixos.org/wiki/Flakes#Other_Distros,_without_Home_Manager).

2. **Dotfiles preparation** (mandatory changes to my dotfiles):

    1. `git clone https://github.com/dafitt/dotfiles.git`.
    2. `cd dotfiles`.
    3. Read and understand my dotfiles' structure and code.

    4. Set the correct current `system.stateVersion`.

    5. Add a (**your**) new home-configuration to _`homes/<architecture>/<user>[@<host>]/default.nix`_  
       _Available `dafitt-home` options can be found at [templates/home/default.nix](https://github.com/dafitt/dotfiles/blob/main/templates/home/default.nix)._

    6. Commit all changes:
        ```
        git add . && git commit -m "homes: added <user>[@<host>]"
        ```

    7. Uncomment `nixConfig` in [flake.nix](https://github.com/dafitt/dotfiles/blob/main/flake.nix) and enter `nix develop` on your first build for faster build time.
    
3. Build:

    1. Enter `nix develop .#default`'s shell.  
       Alternative: `nix run home-manager -- --flake .#<user>[@<host>] switch`.
    2. `home-manager --flake .#<user>[@<host>] switch`.
    3. Check for home-manager errors with `systemctl status home-manager-<user>.service` and resolve them if necessary.
    - _NOTE: First install may take some time; especially with flatpaks enabled._

## Configuration

### NixOS stable branch

To use [nixpkgs](https://github.com/NixOS/nixpkgs) stable branch, update the following inputs to the latest release (`25.05` as an example) in _[flake.nix](https://github.com/dafitt/dotfiles/blob/main/flake.nix)_ and rebuild the system. \
ATTENTION! When the latest release of [nixpkgs](https://github.com/NixOS/nixpkgs) is some time away, then you will likely need to refactor some breaking changed options. See the backward incompatibilities [in the release notes](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/doc/manual/release-notes/rl-2505.section.md#backward-incompatibilities-sec-release-2505-incompatibilities) for those. Directly after a new release should be the best time to switch.

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager/release-25.05"; inputs.nixpkgs.follows = "nixpkgs"; };
    stylix.url = "github:danth/stylix/release-25.05";
  };
}
```

To still let specific packages follow nixpkgs unstable while on the stable branch you can add a _`overlays/unstable/default.nix`_:

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

### Importing my modules

You can try using my modules through importing them:

```nix
# flake.nix
inputs = {
  dafitt = { url = "github:dafitt/dotfiles"; inputs.nixpkgs.follows = "nixpkgs"; };
};

outputs = { nixpkgs, ... }@inputs: {
  nixosConfigurations."<host>" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # e.g.
      inputs.dafitt.nixosModules."gnome"
      inputs.dafitt.nixosModules."bootloader/systemd"
      inputs.dafitt.homeManagerModules."stylix"
      inputs.dafitt.homeManagerModules."browsers/firefox"
    ];
  };
};
```

But it is certainly better to simply copy them into your dotfiles and adapt them to your needs.

### You want to build from here?

What you have to customize:

-   [ ] [modules/nixos/time/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/nixos/time/default.nix): timezone
-   [ ] [modules/nixos/locale/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/nixos/locale/default.nix): locale
-   [ ] [modules/home/browsers/firefox/default.nix](https://github.com/dafitt/dotfiles/blob/d60f8b464f1713ccb022d3d24558d5f4631ad123/modules/home/browsers/firefox/default.nix#L183):
    -   the default searx search engine is my own local instance/server, use a official one or setup your own
    -   custom firefox plugins
-   [ ] [systems/\<architecure\>/\<host\>/default.nix](https://github.com/dafitt/dotfiles/blob/main/templates/system/default.nix): your own host-configuration
    -   [ ] `hardware-configuration.nix`
    -   [ ] maybe some host-specific `configuration.nix`: make sure to import it: `imports = [ ./configuration.nix ];`
-   [ ] [homes/\<architecure\>/\<user\>[@\<host\>]/default.nix](https://github.com/dafitt/dotfiles/blob/main/templates/home/default.nix): your own user with your home-configuration

Optionally:

-   [ ] [modules/home/desktops/hyprland/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/desktops/hyprland/default.nix): familiar keybindings
-   [ ] [modules/home/stylix/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/stylix/default.nix): custom base16 theme / icon theme
-   [ ] Packages and programs you need

## Usage

### Flake

Some basic flake commands

#### Shell environment

```shell
nix-shell shell.nix # only when on legacy-nix: enables flakes & git (works only locally)

nix develop github:dafitt/dotfiles#default
```

#### Overview

```shell
nix flake show github:dafitt/dotfiles
```

#### Build and switch configuration

NixOS & Home-manager:

```shell
nixos-rebuild switch --flake .#[<host>]
```

Home-manager standalone:

```shell
home-manager switch --flake .#[<user>@<host>]
```

#### Update flake inputs

```shell
nix flake update --commit-lock-file

# specific input
nix flake lock --update-input [input]
```

#### Rollback

NixOS: `sudo nixos-rebuild switch --rollback`

Home-manager standalone: [see Home-manager documentation](https://nix-community.github.io/home-manager/index.xhtml#sec-usage-rollbacks)

#### Code formatting

```shell
nix fmt [./folder] [./file.nix]
```

### [Hyprkeys](https://github.com/hyprland-community/Hyprkeys)

<kbd>SUPER_CONTROL</kbd> - System and Hyprland control \
<kbd>SUPER</kbd> - Window control \
<kbd>SUPER_ALT</kbd> - Applications \
<kbd>SHIFT</kbd> - reverse, grab, move

<details><summary>keybind table</summary>

| Keybind                              | Dispatcher                     | Command                                                                                                     |
| ------------------------------------ | ------------------------------ | ----------------------------------------------------------------------------------------------------------- |
| <kbd>SUPER_ALT B</kbd>               | exec                           | pypr toggle bluetooth                                                                                       |
| <kbd>SUPER_ALT W</kbd>               | exec                           | firefox                                                                                                     |
| <kbd>SUPER_ALT P</kbd>               | exec                           | pypr toggle btop                                                                                            |
| <kbd>SUPER_ALT E</kbd>               | exec                           | micro                                                                                                       |
| <kbd>SUPER_ALT F</kbd>               | exec                           | nautilus                                                                                                    |
| <kbd>XF86Calculator</kbd>            | exec                           | gnome-calculator                                                                                            |
| <kbd>SUPER_CONTROL Q</kbd>           | exit                           |                                                                                                             |
| <kbd>SUPER_CONTROL R</kbd>           | exec                           | hyprctl reload; forcerendererreload                                                                         |
| <kbd>SUPER_CONTROL ADIAERESIS</kbd>  | exec                           | poweroff                                                                                                    |
| <kbd>SUPER_CONTROL ODIAERESIS</kbd>  | exec                           | poweroff --reboot                                                                                           |
| <kbd>SUPER UDIAERESIS</kbd>          | exec                           | systemctl suspend                                                                                           |
| <kbd>SUPER DELETE</kbd>              | exec                           | hyprctl kill                                                                                                |
| <kbd>SUPER X</kbd>                   | killactive                     |                                                                                                             |
| <kbd>SUPER_SHIFT X</kbd>             | forcekillactive                |                                                                                                             |
| <kbd>SUPER P</kbd>                   | pseudo                         |                                                                                                             |
| <kbd>SUPER R</kbd>                   | togglesplit                    |                                                                                                             |
| <kbd>SUPER H</kbd>                   | swapnext                       |                                                                                                             |
| <kbd>SUPER_SHIFT H</kbd>             | swapnext                       | prev                                                                                                        |
| <kbd>SUPER F</kbd>                   | fullscreen                     |                                                                                                             |
| <kbd>SUPER A</kbd>                   | fullscreen                     | 1                                                                                                           |
| <kbd>SUPER V</kbd>                   | togglefloating                 |                                                                                                             |
| <kbd>SUPER Z</kbd>                   | alterzorder                    | top                                                                                                         |
| <kbd>SUPER_SHIFT Z</kbd>             | alterzorder                    | bottom                                                                                                      |
| <kbd>SUPER B</kbd>                   | pin                            |                                                                                                             |
| <kbd>SUPER left</kbd>                | movefocus                      | l                                                                                                           |
| <kbd>SUPER right</kbd>               | movefocus                      | r                                                                                                           |
| <kbd>SUPER up</kbd>                  | movefocus                      | u                                                                                                           |
| <kbd>SUPER down</kbd>                | movefocus                      | d                                                                                                           |
| <kbd>SUPER Tab</kbd>                 | cyclenext                      |                                                                                                             |
| <kbd>SUPER Tab</kbd>                 | cyclenext                      | prev                                                                                                        |
| <kbd>SUPER_SHIFT left</kbd>          | swapwindow                     | l                                                                                                           |
| <kbd>SUPER_SHIFT right</kbd>         | swapwindow                     | r                                                                                                           |
| <kbd>SUPER_SHIFT up</kbd>            | swapwindow                     | u                                                                                                           |
| <kbd>SUPER_SHIFT down</kbd>          | swapwindow                     | d                                                                                                           |
| <kbd>SUPER_SHIFT Tab</kbd>           | swapnext                       |                                                                                                             |
| <kbd>SUPER_ALT plus</kbd>            | resizeactive                   | 100 0                                                                                                       |
| <kbd>SUPER_ALT minus</kbd>           | resizeactive                   | -100 0                                                                                                      |
| <kbd>SUPER_ALT right</kbd>           | resizeactive                   | 100 0                                                                                                       |
| <kbd>SUPER_ALT left</kbd>            | resizeactive                   | -100 0                                                                                                      |
| <kbd>SUPER_ALT down</kbd>            | resizeactive                   | 0 100                                                                                                       |
| <kbd>SUPER_ALT up</kbd>              | resizeactive                   | 0 -100                                                                                                      |
| <kbd>SUPER_CONTROL G</kbd>           | togglegroup                    |                                                                                                             |
| <kbd>SUPER G</kbd>                   | changegroupactive              | f                                                                                                           |
| <kbd>SUPER_SHIFT G</kbd>             | changegroupactive              | f                                                                                                           |
| <kbd>SUPER_SHIFT_CONTROL left</kbd>  | movewindoworgroup              | l                                                                                                           |
| <kbd>SUPER_SHIFT_CONTROL right</kbd> | movewindoworgroup              | r                                                                                                           |
| <kbd>SUPER_SHIFT_CONTROL up</kbd>    | movewindoworgroup              | u                                                                                                           |
| <kbd>SUPER_SHIFT_CONTROL down</kbd>  | movewindoworgroup              | d                                                                                                           |
| <kbd>SUPER 1</kbd>                   | focusworkspaceoncurrentmonitor | 1                                                                                                           |
| <kbd>SUPER 2</kbd>                   | focusworkspaceoncurrentmonitor | 2                                                                                                           |
| <kbd>SUPER 3</kbd>                   | focusworkspaceoncurrentmonitor | 3                                                                                                           |
| <kbd>SUPER 4</kbd>                   | focusworkspaceoncurrentmonitor | 4                                                                                                           |
| <kbd>SUPER 5</kbd>                   | focusworkspaceoncurrentmonitor | 5                                                                                                           |
| <kbd>SUPER 6</kbd>                   | focusworkspaceoncurrentmonitor | 6                                                                                                           |
| <kbd>SUPER 7</kbd>                   | focusworkspaceoncurrentmonitor | 7                                                                                                           |
| <kbd>SUPER 8</kbd>                   | focusworkspaceoncurrentmonitor | 8                                                                                                           |
| <kbd>SUPER 9</kbd>                   | focusworkspaceoncurrentmonitor | 9                                                                                                           |
| <kbd>SUPER 0</kbd>                   | focusworkspaceoncurrentmonitor | 10                                                                                                          |
| <kbd>SUPER D</kbd>                   | focusworkspaceoncurrentmonitor | name:D                                                                                                      |
| <kbd>SUPER code:87</kbd>             | focusworkspaceoncurrentmonitor | 1                                                                                                           |
| <kbd>SUPER code:88</kbd>             | focusworkspaceoncurrentmonitor | 2                                                                                                           |
| <kbd>SUPER code:89</kbd>             | focusworkspaceoncurrentmonitor | 3                                                                                                           |
| <kbd>SUPER code:83</kbd>             | focusworkspaceoncurrentmonitor | 4                                                                                                           |
| <kbd>SUPER code:84</kbd>             | focusworkspaceoncurrentmonitor | 5                                                                                                           |
| <kbd>SUPER code:85</kbd>             | focusworkspaceoncurrentmonitor | 6                                                                                                           |
| <kbd>SUPER code:79</kbd>             | focusworkspaceoncurrentmonitor | 7                                                                                                           |
| <kbd>SUPER code:80</kbd>             | focusworkspaceoncurrentmonitor | 8                                                                                                           |
| <kbd>SUPER code:81</kbd>             | focusworkspaceoncurrentmonitor | 9                                                                                                           |
| <kbd>SUPER code:91</kbd>             | focusworkspaceoncurrentmonitor | 10                                                                                                          |
| <kbd>SUPER code:86</kbd>             | focusworkspaceoncurrentmonitor | +1                                                                                                          |
| <kbd>SUPER code:82</kbd>             | focusworkspaceoncurrentmonitor | -1                                                                                                          |
| <kbd>SUPER backspace</kbd>           | focusworkspaceoncurrentmonitor | previous                                                                                                    |
| <kbd>SUPER mouse_down</kbd>          | focusworkspaceoncurrentmonitor | -1                                                                                                          |
| <kbd>SUPER mouse_up</kbd>            | focusworkspaceoncurrentmonitor | +1                                                                                                          |
| <kbd>SUPER_SHIFT 1</kbd>             | movetoworkspacesilent          | 1                                                                                                           |
| <kbd>SUPER_SHIFT 2</kbd>             | movetoworkspacesilent          | 2                                                                                                           |
| <kbd>SUPER_SHIFT 3</kbd>             | movetoworkspacesilent          | 3                                                                                                           |
| <kbd>SUPER_SHIFT 4</kbd>             | movetoworkspacesilent          | 4                                                                                                           |
| <kbd>SUPER_SHIFT 5</kbd>             | movetoworkspacesilent          | 5                                                                                                           |
| <kbd>SUPER_SHIFT 6</kbd>             | movetoworkspacesilent          | 6                                                                                                           |
| <kbd>SUPER_SHIFT 7</kbd>             | movetoworkspacesilent          | 7                                                                                                           |
| <kbd>SUPER_SHIFT 8</kbd>             | movetoworkspacesilent          | 8                                                                                                           |
| <kbd>SUPER_SHIFT 9</kbd>             | movetoworkspacesilent          | 9                                                                                                           |
| <kbd>SUPER_SHIFT 0</kbd>             | movetoworkspacesilent          | 10                                                                                                          |
| <kbd>SUPER_SHIFT code:87</kbd>       | movetoworkspacesilent          | 1                                                                                                           |
| <kbd>SUPER_SHIFT code:88</kbd>       | movetoworkspacesilent          | 2                                                                                                           |
| <kbd>SUPER_SHIFT code:89</kbd>       | movetoworkspacesilent          | 3                                                                                                           |
| <kbd>SUPER_SHIFT code:83</kbd>       | movetoworkspacesilent          | 4                                                                                                           |
| <kbd>SUPER_SHIFT code:84</kbd>       | movetoworkspacesilent          | 5                                                                                                           |
| <kbd>SUPER_SHIFT code:85</kbd>       | movetoworkspacesilent          | 6                                                                                                           |
| <kbd>SUPER_SHIFT code:79</kbd>       | movetoworkspacesilent          | 7                                                                                                           |
| <kbd>SUPER_SHIFT code:80</kbd>       | movetoworkspacesilent          | 8                                                                                                           |
| <kbd>SUPER_SHIFT code:81</kbd>       | movetoworkspacesilent          | 9                                                                                                           |
| <kbd>SUPER_SHIFT code:91</kbd>       | movetoworkspacesilent          | 10                                                                                                          |
| <kbd>SUPER_SHIFT code:86</kbd>       | movetoworkspacesilent          | +1                                                                                                          |
| <kbd>SUPER_SHIFT code:82</kbd>       | movetoworkspacesilent          | -1                                                                                                          |
| <kbd>SUPER_CTRL left</kbd>           | movecurrentworkspacetomonitor  | l                                                                                                           |
| <kbd>SUPER_CTRL right</kbd>          | movecurrentworkspacetomonitor  | r                                                                                                           |
| <kbd>SUPER_CTRL up</kbd>             | movecurrentworkspacetomonitor  | u                                                                                                           |
| <kbd>SUPER_CTRL down</kbd>           | movecurrentworkspacetomonitor  | d                                                                                                           |
| <kbd>SUPER_ALT U</kbd>               | exec                           | gnome-characters                                                                                            |
| <kbd>SUPER_ALT K</kbd>               | exec                           | wl-copy                                                                                                     |
| <kbd>XF86AudioMute</kbd>             | exec                           | wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle                                                                  |
| <kbd>ALT XF86AudioMute</kbd>         | exec                           | wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle                                                                |
| <kbd>XF86AudioMicMute</kbd>          | exec                           | wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle                                                                |
| <kbd>PRINT</kbd>                     | exec                           | grimblast copysave output /home/david/Pictures/Screenshots/$(date +'%F-%T\_%N.png')                         |
| <kbd>SUPER PRINT</kbd>               | exec                           | grimblast --notify --freeze copysave area /home/david/Pictures/Screenshots/$(date +'%F-%T\_%N.png')         |
| <kbd>ALT PRINT</kbd>                 | exec                           | satty --filename - --fullscreen --output-filename /home/david/Pictures/Screenshots/$(date +'%F-%T\_%N.png') |
| <kbd>SUPER_ALT PRINT</kbd>           | exec                           | satty --filename - --output-filename /home/david/Pictures/Screenshots/$(date +'%F-%T\_%N.png')              |
| <kbd>SUPER_ALT V</kbd>               | exec                           | wl-copy'                                                                                                    |
| <kbd>SUPER L</kbd>                   | exec                           | hyprlock                                                                                                    |
| <kbd>SUPER Z</kbd>                   | exec                           | pypr zoom                                                                                                   |
| <kbd>SUPER minus</kbd>               | exec                           | pypr zoom --0.5                                                                                             |
| <kbd>SUPER plus</kbd>                | exec                           | pypr zoom ++0.5                                                                                             |
| <kbd>SUPER_ALT mouse_down</kbd>      | exec                           | pypr zoom ++0.5                                                                                             |
| <kbd>SUPER_ALT mouse_up</kbd>        | exec                           | pypr zoom --0.5                                                                                             |
| <kbd>SUPER_ALT mouse:274</kbd>       | exec                           | pypr zoom                                                                                                   |
| <kbd>SUPER ODIAERESIS</kbd>          | exec                           | pypr toggle_dpms                                                                                            |
| <kbd>SUPER Y</kbd>                   | exec                           | pypr toggle_special minimized                                                                               |
| <kbd>SUPER_SHIFT Y</kbd>             | togglespecialworkspace         | minimized                                                                                                   |
| <kbd>SUPER W</kbd>                   | exec                           | hyprpanel toggleWindow bar-0                                                                                |
| <kbd>SUPER SPACE</kbd>               | exec                           | fuzzel                                                                                                      |
| <kbd>SUPER_ALT N</kbd>               | exec                           | pypr toggle networkmanager                                                                                  |
| <kbd>SUPER_ALT PERIOD</kbd>          | exec                           | bitwarden                                                                                                   |
| <kbd>SUPER_ALT A</kbd>               | exec                           | pypr toggle pavucontrol                                                                                     |
| <kbd>XF86AudioPlay</kbd>             | exec                           | playerctl play-pause                                                                                        |
| <kbd>XF86AudioPause</kbd>            | exec                           | playerctl play-pause                                                                                        |
| <kbd>XF86AudioStop</kbd>             | exec                           | playerctl stop                                                                                              |
| <kbd>XF86AudioNext</kbd>             | exec                           | playerctl next                                                                                              |
| <kbd>XF86AudioPrev</kbd>             | exec                           | playerctl previous                                                                                          |
| <kbd>CTRL XF86AudioRaiseVolume</kbd> | exec                           | playerctl position 1+                                                                                       |
| <kbd>CTRL XF86AudioLowerVolume</kbd> | exec                           | playerctl position 1-                                                                                       |
| <kbd>ALT XF86AudioNext</kbd>         | exec                           | playerctld shift                                                                                            |
| <kbd>ALT XF86AudioPrev</kbd>         | exec                           | playerctld unshift                                                                                          |
| <kbd>ALT XF86AudioPlay</kbd>         | exec                           | systemctl --user restart playerctld                                                                         |
| <kbd>SUPER_ALT Z</kbd>               | exec                           | xdg-open https://localhost:8384                                                                             |
| <kbd>SUPER RETURN</kbd>              | exec                           | kitty                                                                                                       |
| <kbd>SUPER_ALT T</kbd>               | exec                           | pypr toggle kitty                                                                                           |
| <kbd>SUPER_ALT G</kbd>               | exec                           | codium                                                                                                      |
| <kbd>XF86AudioRaiseVolume</kbd>      | exec                           | wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2.5%+                                                        |
| <kbd>XF86AudioLowerVolume</kbd>      | exec                           | wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2.5%-                                                        |
| <kbd>ALT XF86AudioRaiseVolume</kbd>  | exec                           | wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 2.5%+                                                      |
| <kbd>ALT XF86AudioLowerVolume</kbd>  | exec                           | wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 2.5%-                                                      |
| <kbd>XF86KbdBrightnessUp</kbd>       | exec                           | light -s sysfs/leds/kbd_backlight -A 10                                                                     |
| <kbd>XF86KbdBrightnessDown</kbd>     | exec                           | light -s sysfs/leds/kbd_backlight -U 10                                                                     |
| <kbd>XF86MonBrightnessUp</kbd>       | exec                           | light -U 5                                                                                                  |
| <kbd>XF86MonBrightnessDown</kbd>     | exec                           | light -A 5                                                                                                  |
| <kbd>SUPER mouse:272</kbd>           | movewindow                     |                                                                                                             |
| <kbd>SUPER mouse:273</kbd>           | resizewindow                   |                                                                                                             |
| <kbd>Escape</kbd>                    | exec                           | pypr hide '\*'                                                                                              |

</details>

## Structure

### Modules

I use [snowfall-lib](https://github.com/snowfallorg/lib), so every _`default.nix`_ is automatically imported.

My systems and homes are assembled using custom modules `config.dafitt.<myModule>`. Any custom module has at least one enable option `config.dafitt.<myModule>.enable` which name matches the folder _`modules/<nixos|home>/<myModule>/`_.

Modules in [modules/nixos/](https://github.com/dafitt/dotfiles/blob/main/modules/nixos) are built with the standard `nixos-rebuild` command.

Modules in [modules/home/](https://github.com/dafitt/dotfiles/blob/main/modules/home) are built with `home-manager` (standalone) **and** in addition to `nixos-rebuild` if the homes-hostname "\<user>[@\<host>]" matches with the host your building on. This is done by [snowfall-lib](https://github.com/snowfallorg/lib) with the systemd-service _`home-manager-<user>.service`_. [snowfall-lib](https://github.com/snowfallorg/lib) will create the user if it doesn't exist yet.

Some [home-modules](https://github.com/dafitt/dotfiles/blob/main/modules/home) in my dotfiles are automatically activated, if the twin module in [nixos-modules](https://github.com/dafitt/dotfiles/blob/main/modules/nixos) is enabled. See this line in [modules/home/suiteGaming/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/suiteGaming/default.nix#L11) for example:

```nix
options.dafitt.suiteGaming.enable = mkBoolOpt (osConfig.dafitt.suiteGaming.enable or false) "...
```

The special attribute set `osConfig` which contains all the nixos-configuration is only present when building with `nixos-rebuild`.

## Troubleshooting

### Some options in [modules/home/](https://github.com/dafitt/dotfiles/blob/main/modules/home) or [homes/](https://github.com/dafitt/dotfiles/blob/main/homes) are not being applied with nixos-rebuild

Check if your option is being set through `osCfg`. Like this:

```nix
enable = mkBoolOpt (osCfg.enable or config.dafitt.suiteGaming.enable) "Whether to enable steam.";
```

If that is the case and `osCfg.enable` is not `null` then the `osCfg`-option will be preferred. Even if it is `false`.

To solve this set your option to `true` in [modules/nixos/](https://github.com/dafitt/dotfiles/blob/main/modules/nixos) or [systems/](https://github.com/dafitt/dotfiles/blob/main/systems).

### Unable to see fonts

Manually reload the fontconfig cache using

```shell
fc-cache -r [-f]
```

### bluetoothd: Failed to set mode: Failed (0x03)

```shell
rfkill list
sudo rfkill unblock bluetooth
```

## 👀, 🏆 and ❤️

-   [Vimjoyer - Youtube](https://www.youtube.com/@vimjoyer)
-   [IogaMaster - Youtube](https://www.youtube.com/@IogaMaster)
-   [mikeroyal/NixOS-Guide](https://github.com/mikeroyal/NixOS-Guide)
-   [jakehamilton/config](https://github.com/jakehamilton/config)
-   [IogaMaster/dotfiles](https://github.com/IogaMaster/dotfiles)
-   [IogaMaster/snowfall-starter](https://github.com/IogaMaster/snowfall-starter)
-   [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
-   [Aylur/dotfiles](https://github.com/Aylur/dotfiles)
