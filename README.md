# My Snowfall🌨️🍂 NixOS❄️ desktop flake

-   [My Snowfall🌨️🍂 NixOS❄️ desktop flake](#my-snowfall️-nixos️-desktop-flake)
    -   [Programs and Features](#programs-and-features)
    -   [Installation on a new host](#installation-on-a-new-host)
    -   [Flake usage](#flake-usage)
        -   [remotely](#remotely)
        -   [locally](#locally)
    -   [Environment usage](#environment-usage)
    -   [Structure](#structure)
        -   [Hyprland keybindings modifiers](#hyprland-keybindings-modifiers)
        -   [You want to build from here?](#you-want-to-build-from-here)
    -   [Inspiration, Credits and Thanks](#inspiration-credits-and-thanks)

My dotfiles are not perfekt and never will be (unfortunately), but they strive to be:

-   fully declarative 📝
-   highly structured 🧱
-   stable 🛡️
-   suitable for everyday use 📅
-   a consistent environment that doesn't sacrifice its looks ✨

## Programs and Features

-   👥 Multiple hosts
-   🧍 Standalone home
-   ❄️🏗️ [Snowfall-lib structure](https://snowfall.org/reference/lib/#flake-structure)
-   ❄️💲 [Snowfall-flake commands](https://github.com/snowfallorg/flake?tab=readme-ov-file#usage)
-   📦 [Declarative flatpaks](https://github.com/gmodena/nix-flatpak)

| Operating System 💻 | [NixOS](https://nixos.org/)                                                                            |
| ------------------: | :----------------------------------------------------------------------------------------------------- |
|   Window manager 🪟 | [Hyprland](https://hyprland.org/), [Gnome](https://www.gnome.org/)                                     |
|    Login manager 🔒 | gdm, tty                                                                                               |
|  Session locking 🔒 | hyprlock                                                                                               |
|         Terminal ⌨️ | [kitty](https://sw.kovidgoyal.net/kitty/)                                                              |
|            Shell 🐚 | [fish](https://fishshell.com/)                                                                         |
|           Prompt ➡️ | [starship](https://starship.rs/)                                                                       |
|     File manager 📁 | nautilus, pcmanfm                                                                                      |
|           Editor ✏️ | [vscode](https://code.visualstudio.com/)                                                               |
|              Web 🌍 | [librewolf](https://librewolf.net/), [epiphany](https://apps.gnome.org/Epiphany/)                      |
|          Theming 🎨 | [Stylix](https://github.com/danth/stylix) - modified [Catppuccin](https://github.com/catppuccin) Mocha |
|       Networking 🌐 | networkmanager, connman                                                                                |
|   Virtualization 🪟 | virt-manager, bottles                                                                                  |

## Installation on a new host

1. Install [NixOS](https://nixos.org/download/)
2. `git clone https://github.com/dafitt/dotfiles.git`
    1. Add a new system _`/systems/x86_64-linux/<host>/default.nix`_
    2. Copy, import and commit _`hardware-configuration.nix`_!
    3. Set the correct `system.stateVersion`
3. Remove files for home-manager: `rm ~/.config/user-dirs.dirs ~/.config/fish/config.fish ~/.config/hypr/hyprland.conf`
4. `sudo nixos-rebuild boot --flake .#<host>`
    - _NOTE First install: Flatpaks need very long: A Timeout is normal!_
    1. Check home-manager: `systemctl status home-manager-david.service`
5. `reboot`
6. Personal setup:
    1. [Syncthing](https://localhost:8384/) setup
    2. Firefox Sync Login
        1. NoScript
        2. SimpleTabsGroup
        3. 1Password
    3. Volume Control: Set standard audio output

## Flake usage

### remotely

```shell
nix shell github:snowfallorg/flake

flake dev github:dafitt/dotfiles#default
```

Show flake outputs:

```shell
flake show github:dafitt/dotfiles
nix flake show github:dafitt/dotfiles
```

Explore flake options:

```shell
flake option github:dafitt/dotfiles --pick
```

### locally

Enter development shell:

```shell
nix-shell # to activate experimental nix commands & git

nix develop .#default
# or
#nix shell github:snowfallorg/flake
flake dev default
nix develop .#default
```

Build and switch to configuration:

```shell
nixos-rebuild switch --flake .#<host>
# or
flake switch
```

Build and switch home standalone:

```shell
home-manager switch --flake .#<user>@<host>
```

Updating flake:

```shell
nix flake update --commit-lock-file
# or
flake update
# specific input
nix flake lock --update-input [input]
```

Rollback nixos confituration:

```shell
nixos-rebuild switch --rollback
```

Further commands: [snowfallorg/flake](https://github.com/snowfallorg/flake?tab=readme-ov-file#usage)

## Environment usage

## Structure

I use [snowfall-lib](https://github.com/snowfallorg/lib), so every _`default.nix`_ is automatically imported.

My systems and homes are assembled using custom modules. Any custom module has at least one option which name matches the folder: `config.custom.myModule.enable`. Keep in mind some modules are enabled by default some are not. Special modules:

-   Desktops
    -   desktops/common - configuration for all desktops
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

Modules in _`modules/nixos`_ are built with the standard `nixos-rebuild` command; _`modules/home`_ with `home-manager` (standalone) **or** in addition to `nixos-rebuild` if the homes-hostname "\<user>[@\<host>]" matches with the host your building on (this is done by [snowfall-lib](https://github.com/snowfallorg/lib) with the systemd-service _home-manager-<user>.service_).

Some _`modules/home`_ are automatically activated, if the sister module in _`modules/nixos`_ is enabled e.g. `options.custom.gaming.enableSuite = mkBoolOpt (osConfig.custom.gaming.enableSuite or false) "...`. The special attribute set `osConfig` is only present when building with `nixos-rebuild`.

Last but no least, to keep things simple I put some very specific configuration directly into the systems themselves.

### Hyprland keybindings modifiers

<kbd>SUPER_CONTROL</kbd> - Hyprland control  
<kbd>SUPER</kbd> - Window control  
<kbd>SUPER_ALT</kbd> - Applications  
<kbd>SHIFT</kbd> - reverse, grab, move  

### You want to build from here?

What you have to customize:

-   [ ] _`modules/nixos/time/default.nix`_: timezone
-   [ ] _`modules/nixos/locale/default.nix`_: locale
-   [ ] _`modules/nixos/users/main/default.nix`_: username
-   [ ] _`modules/home/office/thunderbird/default.nix`_
-   [ ] _`systems/<architecure>/<host>/default.nix`_: obviously your own host
    -   [ ] `hardware-configuration.nix`
    -   [ ] maybe some specific `configuration.nix`
-   [ ] _`homes/<architecure>/<user>[@<host>]/default.nix`_

Optionally:

-   [ ] _`modules/home/desktops/hyprland/default.nix`_: familiar keybindings
-   [ ] _`modules/home/stylix/default.nix`_: custom base16 theme / icon theme
-   [ ] Packages and programs you need

## Inspiration, Credits and Thanks

-   [Vimjoyer - Youtube](https://www.youtube.com/@vimjoyer)
-   [IogaMaster - Youtube](https://www.youtube.com/@IogaMaster)
-   [mikeroyal/NixOS-Guide](https://github.com/mikeroyal/NixOS-Guide)
-   [jakehamilton/config](https://github.com/jakehamilton/config)
-   [IogaMaster/dotfiles](https://github.com/IogaMaster/dotfiles)
-   [IogaMaster/snowfall-starter](https://github.com/IogaMaster/snowfall-starter)
-   [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
