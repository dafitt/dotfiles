# ❄️NixOS desktop

My solution to a full [NixOS](https://nixos.org/) / [Hyprland](https://hyprland.org/) desktop. Heavily inspired by [@Misterio77](https://github.com/Misterio77/nix-config) and [Vimjoyer](https://www.youtube.com/@vimjoyer).

I tried to make my configuration as simple as possbile to understand. I also pasted some links to helpful websites into the sourcecode and left some personal comments.

Feel free to copy'n'paste as you like.

## Programs and Features

-   🔄 made for synchronizing between multiple hosts

### System

-   Declare **multiple hosts** but still some **shared configuration** ↔️
-   📦 Flatpak support

### Home

|                 🧍 | standalone                    |
| -----------------: | :---------------------------- |
|  Window manager 🌿 | Hyprland                      |
|        Terminal ⬛ | kitty                         |
|           Shell 🐚 | zsh, _bash(disabled)_         |
|          Prompt 🗣️ | starship                      |
|    File manager 🗃️ | nautilus, _pcmanfm(disabled)_ |
|          Editor 📝 | micro, vscodium               |
|         Browser 🐺 | librewolf                     |
|         Theming 🖌️ | Stylix (colors & fonts)       |
|         Network 🌐 | connman                       |
|             VMs 🪟 | gnomeboxes, virt-manager      |
| Session looking 🔒 | swaylock                      |

## Strucure

- `./home-manager` configuration for home (standalone)
- `./nixos` configuration for different host's system's
    - ``

## Installation

### Base System

`etc/nixos/`

1. Install [NixOS](https://nixos.org/) on a machine.
    - NOTE: You can use any environment you want, it doesn't matter because we are changing the configuration anyway.
2. Download this repository and put it somewhere to _`~/Desktop`_ for example
3. Enable Flakes through `nix-shell` or `nix-develop`
4. Create your own `nixos/hosts/HOSTNAME/`.
    - NOTE: You can use my _`hosts/Generic`_ and your _`/etc/nixos/configruation.nix`_ from your installation for help. See my existing devices what should be in this folder.
    1. change locale, username, hostname, etc.
    2. include my `./nixos/hosts/common-desktop.nix`
    3. add more packages you would like to use for every user and root
    4. dont forget to copy `/etc/nixos/hardware-configuration.nix`
5. Run `sudo nixos-rebuild test --flake .#HOSTNAME`
    - NOTE: First test/switch can take a while.
    - Nice2know: `sudo nixos-rebuild build-vm-with-bootloader` to create a virtual machine. See the `--help` page
6. _If everything works,_ make the configruation the default boot with `sudo nixos-rebuild switch --flake .`

Now you have your base NixOS system. Delete my hosts and adjust my shared-desktop to your needs.

### Home-manager standalone

I prefered the standalone installation because i don't want to use sudo and rebuild my enire system to only apply some home changes. Plus I **could** theoretically install Home-manager to any linux distribution and apply my config. But i haven't tested this yet.

Requirements for home-manager-only:

```nix
hardware.opengl.enable = true;
programs.dconf.enable = true;
```

1. Download this repository and put it somewhere to _`~/Desktop`_ for example
2. Make some changes to my sourcecode in _`./home-manager/`_
    - the USERNAME should be your own
    - your monitor configuration per HOSTNAME
    - your own programs or services you want
3. Enable Flakes through `nix-shell` or `nix-develop`
4. Run `home-manager switch --flake .#USERNAME@HOSTNAME`
    - NOTE: First switch can take a while.

### Bugs'n'Fixes

#### eww

Yea, i know my eww configuration isn't finished and still lacking. I will work on it from time to time.

##### symlink eww config directory

You have to manually make a symlink from your eww config folder to _`~/.config/eww`_ in order for eww to work. Adjust it to your path:

```shell
ln -s ~/Desktop/NixOS/home-manager/david/modules/eww ~/.config/
```

#### Flatpak

Run the script `/home-manager/programs/flatpaks.sh` to add the flathub repository and install some specified flatpaks.

If you also want to manage your Flatpaks declarively look at [this](https://github.com/GermanBread/declarative-flatpak) project. I might switch to it in the future.

##### Theming

See [Flatpak applications can't find system fonts](https://nixos.wiki/wiki/Fonts#Flatpak_applications_can.27t_find_system_fonts)

```shell
flatpak --user override --filesystem=~/.local/share/fonts:ro
flatpak --user override --filesystem=~/.icons:ro
flatpak --user override --filesystem=~/.themes:rof

# GTK
flatpak --user intall org.gtk.Gtk3theme.adw-gtk3-dark

# QT
flatpak --user remote-add kdeapps https://distribute.kde.org/kdeapps.flatpakrepo
flatpak --user install kdeapps org.kde.KStyle.Adwaita//5.9
flatpak --user install kdeapps org.kde.PlatformTheme.QGnomePlatform//5.9
```

## Usage

> [A helpful NixOS Guide](https://github.com/mikeroyal/NixOS-Guide#table-of-contents)

`nix-shell` or `nix-develop` to enter a custom shell with enable nix and some tools

`nix build` (or shell or run) To build and use packages

### Applying changes

```
nixos-rebuild test --flake .
home-manager switch --flake .
```

### Updating / -grading

...

### Network

`connman-gtk` or `ALT SUPER + N`

### Syncronisation

Manually configure syncthing on <http://localhost:8384>

### Nix in general

Rollback:

-   NixOS: `nix profile rollback {--to <n>}`
-   Home-manager: See <https://nix-community.github.io/home-manager/index.html#sec-usage-rollbacks>

Cleanup:

-   `nix-store --gc` or `nix-collect-garbage` deletes unreachable packages
-   `nix-collect-garbage --delete-old` also deletes previous generations (rollbacks), be careful with that!

Build without internet:

-   `nixos-rebuild switch --option substitute false`
-   `nixos-rebuild switch --option binary-caches ""`
