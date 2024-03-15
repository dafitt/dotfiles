# My Snowfall🌨️ NixOS❄️ desktop flake

-   [My Snowfall🌨️ NixOS❄️ desktop flake](#my-snowfall️-nixos️-desktop-flake)
    -   [Programs and Features](#programs-and-features)
    -   [Installation](#installation)
        -   [Building](#building)
        -   [Updating](#updating)
    -   [Usage](#usage)
        -   [Keybindings](#keybindings)
        -   [Flatpaks](#flatpaks)
    -   [Inspiration, Credits and Thanks](#inspiration-credits-and-thanks)

## Programs and Features

-   🔄 multiple hosts
-   🏗️ [Snowfall flake structure](https://snowfall.org/reference/lib/#flake-structure)
-   📦 Flatpaks

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

## Installation

### Building

How i use my system:

```shell
nixos-rebuild test --flake .#[host]
nixos-rebuild switch --flake .#[host]
```

How you can test my system:

```shell
nixos-rebuild build-vm --flake .#[host]
```

Build home manager standalone:

```shell
home-manager switch --flake .#[user]@[host]
```

### Updating

```shell
nix flake update --commit-lock-file
# or
nix flake update [input]
```

## Usage

### Keybindings

### Flatpaks

Edit and run the script `modules/home/flatpak/flatpaks.sh` to add the flathub repository and install some specified flatpaks.

## Inspiration, Credits and Thanks

-   [Vimjoyer - Youtube](https://www.youtube.com/@vimjoyer)
-   [IogaMaster - Youtube](https://www.youtube.com/@IogaMaster)
-   [mikeroyal/NixOS-Guide](https://github.com/mikeroyal/NixOS-Guide)
-   [jakehamilton/config](https://github.com/jakehamilton/config)
-   [IogaMaster/dotfiles](https://github.com/IogaMaster/dotfiles)
-   [IogaMaster/snowfall-starter](https://github.com/IogaMaster/snowfall-starter)
-   [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
