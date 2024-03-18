# My Snowfall🌨️🍂 NixOS❄️ desktop flake

-   [My Snowfall🌨️🍂 NixOS❄️ desktop flake](#my-snowfall️-nixos️-desktop-flake)
    -   [Programs and Features](#programs-and-features)
    -   [Installation on a new host](#installation-on-a-new-host)
    -   [Flake usage](#flake-usage)
        -   [locally](#locally)
        -   [remotely](#remotely)
    -   [Environment usage](#environment-usage)
    -   [Structure](#structure)
    -   [Inspiration, Credits and Thanks](#inspiration-credits-and-thanks)

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
|  Session locking 🔒 | swaylock                                                                                               |
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
    1. Add a new system _`/systems/x86_64-linux/[host]/default.nix`_
    2. Copy, import and commit _`hardware-configuration.nix`_!
3. Remove files for home-manager: `rm ~/.config/user-dirs.dirs ~/.config/fish/config.fish ~/.config/hypr/hyprland.conf`
4. `sudo nixos-rebuild boot --flake .#[host]`
    - _NOTE: First install: Flatpaks need very long: A Timeout is normal!_
    1. Check home-manager: `systemctl status home-manager-david.service`
5. `reboot`
6. Personal setup:
    1. [Syncthing](https://localhost:8384/) setup
    2. Firefox Sync Login
        1. NoScript
        2. SimpleTabsGroup
        3. 1Password

## Flake usage

### locally

Enter development shell:

```shell
nix-shell # to activate experimental nix commands & git

nix develop .#default
# or
#nix shell github:snowfallorg/flake
flake dev default
```

Building:

```shell
nixos-rebuild switch --flake .#[host]
# or
flake switch
```

Build home standalone:

```shell
home-manager switch --flake .#[user]@[host]
```

Updating:

```shell
nix flake update --commit-lock-file
# or
flake update
```

Rollback:

```shell
nixos-rebuild switch --rollback
```

### remotely

```shell
nix shell github:snowfallorg/flake

flake dev github:dafitt/dotfiles#default
flake switch github:dafitt/dotfiles#DavidDESKTOP
```

Show flake outputs:

```shell
flake show github:dafitt/dotfiles
```

Explore flake options:

```shell
flake option github:dafitt/dotfiles --pick
```

Further commands: [snowfallorg/flake](https://github.com/snowfallorg/flake?tab=readme-ov-file#usage)

## Environment usage

TODO: Hyprland keybindings

## Structure

I use [snowfall-lib](https://github.com/snowfallorg/lib), so every _`default.nix`_ is automatically imported.

My systems and homes are assembled using custom modules. Any custom module has at least one option which name matches the folder: `config.custom.myModule.enable`. Keep in mind some modules are enabled by default some are not. Suites are disabled by default.

Modules in _`/modules/nixos`_ are built with the standard `nixos-rebuild` command; _`/modules/home`_ with `home-manager` (standalone) **or** in addition to `nixos-rebuild` if the system your building on matches (david@DavidDESKTOP) with the systemd-service _home-manager-david.service_ (this is done by [snowfall-lib](https://github.com/snowfallorg/lib)).

Some _`/modules/home`_ are automatically activated, if the sister module in _`/modules/nixos`_ is enabled e.g. `options.custom.gaming.enableSuite = mkBoolOpt (osCfg.enableSuite or false) "...`.

To keep it simple i had put some very specific configuration directly into the systems themselves.

## Inspiration, Credits and Thanks

-   [Vimjoyer - Youtube](https://www.youtube.com/@vimjoyer)
-   [IogaMaster - Youtube](https://www.youtube.com/@IogaMaster)
-   [mikeroyal/NixOS-Guide](https://github.com/mikeroyal/NixOS-Guide)
-   [jakehamilton/config](https://github.com/jakehamilton/config)
-   [IogaMaster/dotfiles](https://github.com/IogaMaster/dotfiles)
-   [IogaMaster/snowfall-starter](https://github.com/IogaMaster/snowfall-starter)
-   [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
