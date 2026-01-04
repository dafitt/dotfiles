# My daily driver's NixOS❄️ desktop flake

![Hyprland-ricing](https://github.com/dafitt/dotfiles/assets/50248238/380705a7-4bd5-4431-81fe-ab04195e19f0)

<p align="center"><a href="#installation">Installation</a> &bull; <a href="#usage">Usage</a> &bull; <a href="#configuration">Configuration</a> &bull; <a href="#troubleshooting">Troubleshooting</a></p>

My dotfiles are not perfekt, but they strive to be:

- highly structured 🧱
- modular 🎛️
- a consistent look'n'feel ✨
- KISS (keep it stupid simple)🥴

## Notes

This flake can and will radically change as I learn, discover new things and have new ideas.

## Most important features and programs

- 🏗 [github:numtide/blueprint](https://github.com/numtide/blueprint) nix flake❄️ structure
- 📦 [github:gmodena/nix-flatpak](https://github.com/gmodena/nix-flatpak) declarative flatpaks
- 🎨 [github:danth/stylix](https://github.com/danth/stylix) theming (modified [catppuccin](https://github.com/catppuccin) 🌿 [Mocha](https://github.com/catppuccin/catppuccin#-palette))
- 🪟 [GNOME](https://www.gnome.org/) with extensions
- 🪟 [Hyprland](https://hypr.land/) with plugins
- 🪟 [Niri](https://github.com/YaLTeR/niri)

## Installation

### New machine - Using the official Installer

1. Install [NixOS](https://nixos.org/download/) and enable the nix feature "[flakes](https://wiki.nixos.org/wiki/Flakes#Enabling_flakes)"

2. **Dotfiles preparation** (mandatory changes to my dotfiles):

   1. `git clone https://github.com/dafitt/dotfiles.git`
   2. `cd dotfiles`
   3. Read and understand my dotfiles' structure and code

   4. Add (**your own**) system-configuration to _`hosts/<host>/configuration.nix`_.

      1. Copy and import _`hardware-configuration.nix`_

      2. Set the correct current `system.stateVersion`

   7. Add (**your own**) home-configuration(s) to _`hosts/<host>/users/<user>.nix`_

   8. Commit all changes:

      ```
      git add . && git commit -m "hosts/<host>: Added new host"
      ```

   9. Uncomment `nixConfig` in [flake.nix](https://github.com/dafitt/dotfiles/blob/main/flake.nix) and enter `nix develop` on your first build for faster build time

3. Build:

   1. Enter (`nix-shell` and then) `nix develop .#default`
   2. `sudo nixos-rebuild --flake .#<host> boot`
   3. Check for home-manager errors with `systemctl status home-manager-<user>.service` and resolve them if necessary

   - _NOTE: First install may take some time; especially with flatpaks enabled._

4. `reboot`

5. Personal imperative setup:

   1. Configure monitor setup with `nwg-displays` on Hyprland
   2. [Syncthing](https://localhost:8384/) setup
   3. firefox: Sync Login
      1. NoScript
      2. 1Password
      3. Sidebery
   4. pavucontrol: Set standard audio output

### New standalone home environment

1. Install [nix](https://nixos.org/download/) and enable the nix feature "[flakes](https://wiki.nixos.org/wiki/Flakes#Other_Distros,_without_Home_Manager)"

2. **Dotfiles preparation** (mandatory changes to my dotfiles):

   1. `git clone https://github.com/dafitt/dotfiles.git`
   2. `cd dotfiles`
   3. Read and understand my dotfiles' structure and code

   4. Set the correct current `home.stateVersion`

   5. Add (**your own**) home-configuration to _`hosts/<host>/users/<user>.nix`_

   6. Commit all changes:

      ```
      git add . && git commit -m "hosts/<host>: Added new home"
      ```

   7. Uncomment `nixConfig` in [flake.nix](https://github.com/dafitt/dotfiles/blob/main/flake.nix) and enter `nix develop` on your first build for faster build time

3. Check your system's requirements when importing the following modules (Installation depending on your distribution):

   - [modules/home/flatpak.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/flatpak.nix): [Flatpak](https://flatpak.org/setup/)
   - [modules/home/hyprland.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/hyprland.nix): [Hyprland](https://wiki.hypr.land/Getting-Started/Installation/), [UWSM](https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#installation-and-basic-configuration)
   - [modules/home/gnome.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/gnome.nix): GNOME

4. Build:

   1. Enter `nix develop .#default` \
      or run: `nix run home-manager -- --flake .#<user>@<host> switch`
   2. `home-manager --flake .#<user>@<host> switch`
   3. Check for home-manager errors with `systemctl status home-manager-<user>.service` and resolve them if necessary

   - _NOTE: First install may take some time; especially with flatpaks enabled._

### New machine - Using the custom ISO

I have configured my own custom installer iso in [hosts/DavidISO](https://github.com/dafitt/dotfiles/blob/main/modules/DavidISO), which can be used to install a new system. It can also be used to repair a broken existing machine.

1. **Dotfiles preparation**:

   1. `git clone https://github.com/dafitt/dotfiles.git`
   2. `cd dotfiles`
   3. Read and understand my dotfiles' structure and code

   4. Add (**your own**) system-configuration to _`hosts/<host>/configuration.nix`_.

      1. Copy and import _`hardware-configuration.nix`_

      2. Set the correct current `system.stateVersion`

   7. Add (**your own**) home-configuration(s) to _`hosts/<host>/users/<user>.nix`_

   8. Commit all changes:

      ```
      git add . && git commit -m "hosts/<host>: Added new host"
      ```

2. Build install-iso with the current dotfiles:

```sh
nix build .#nixosConfigurations.DavidISO.config.formats.install-iso
```

- (optional) Flash the result to a USB-Stick

```sh
dd if=result/<file.iso> of=/dev/<usb>
```

3. Boot from the ISO (or USB-Stick) on the target system

4. Follow the instructions on the command `help-install`

## Usage

### Flake

Some basic flake commands

#### Shell environment

```sh
nix-shell shell.nix # only when on legacy-nix: enables flakes & git (works only locally)

nix develop github:dafitt/dotfiles#default
```

#### Overview

```sh
nix flake show github:dafitt/dotfiles
```

#### Build and switch configuration

NixOS & Home-manager:

```sh
nixos-rebuild --flake .#[<host>] switch
```

Home-manager standalone:

```sh
home-manager --flake .#[<user>@<host>] switch
```

#### Update flake inputs

```sh
nix flake update --commit-lock-file

# specific input
nix flake lock --update-input [input]
```

#### Rollback

- NixOS: `sudo nixos-rebuild switch --rollback`

- Home-manager standalone: [see Home-manager documentation](https://nix-community.github.io/home-manager/index.xhtml#sec-usage-rollbacks)

#### Code formatting

```sh
nix fmt [./folder] [./file.nix]
```

### Repl

```sh
nixos-rebuild --flake .#[<host>] repl

> config # current system configuration
> perSystem.self.homeConfigurations."<user>@<host>".config # current home configuration
```

### [Hyprkeys](https://github.com/hyprland-community/Hyprkeys)

<kbd>Super&Control</kbd> - System and Hyprland control \
<kbd>Super</kbd> - Window control \
<kbd>Super&Alt</kbd> - Applications \
<kbd>Shift</kbd> - reverse, grab, move

<details><summary>keybind table</summary>

| Keybind | Dispatcher | Command  |
| --- | --- | --- |
| <kbd>Super&Alt B</kbd> | exec | pypr toggle bluetooth |
| <kbd>Super&Alt W</kbd> | exec | firefox |
| <kbd>Super&Alt P</kbd> | exec | pypr toggle btop |
| <kbd>Super&Alt E</kbd> | exec | micro |
| <kbd>Super&Alt F</kbd> | exec | nautilus |
| <kbd>XF86Calculator</kbd> | exec | gnome-calculator |
| <kbd>Super&Control Q</kbd> | exit | |
| <kbd>Super&Control R</kbd> | exec | hyprctl reload; forcerendererreload |
| <kbd>Super&Control ADIAERESIS</kbd> | exec | poweroff |
| <kbd>Super&Control ODIAERESIS</kbd> | exec | poweroff --reboot |
| <kbd>Super UDIAERESIS</kbd> | exec | systemctl suspend |
| <kbd>Super DELETE</kbd> | exec | hyprctl kill |
| <kbd>Super X</kbd> | killactive | |
| <kbd>Super&Shift X</kbd> | forcekillactive | |
| <kbd>Super P</kbd> | pseudo | |
| <kbd>Super R</kbd> | togglesplit | |
| <kbd>Super H</kbd> | swapnext | |
| <kbd>Super&Shift H</kbd> | swapnext | prev |
| <kbd>Super F</kbd> | fullscreen | |
| <kbd>Super A</kbd> | fullscreen | 1 |
| <kbd>Super V</kbd> | togglefloating | |
| <kbd>Super Z</kbd> | alterzorder | top |
| <kbd>Super&Shift Z</kbd> | alterzorder | bottom |
| <kbd>Super B</kbd> | pin | |
| <kbd>Super left</kbd> | movefocus | l |
| <kbd>Super right</kbd> | movefocus | r |
| <kbd>Super up</kbd> | movefocus | u |
| <kbd>Super down</kbd> | movefocus | d |
| <kbd>Super Tab</kbd> | cyclenext | |
| <kbd>Super Tab</kbd> | cyclenext | prev |
| <kbd>Super&Shift left</kbd> | swapwindow | l |
| <kbd>Super&Shift right</kbd> | swapwindow | r |
| <kbd>Super&Shift up</kbd> | swapwindow | u |
| <kbd>Super&Shift down</kbd> | swapwindow | d |
| <kbd>Super&Shift Tab</kbd> | swapnext | |
| <kbd>Super&Alt plus</kbd> | resizeactive | 100 0 |
| <kbd>Super&Alt minus</kbd> | resizeactive | -100 0 |
| <kbd>Super&Alt right</kbd> | resizeactive | 100 0 |
| <kbd>Super&Alt left</kbd> | resizeactive | -100 0 |
| <kbd>Super&Alt down</kbd> | resizeactive | 0 100 |
| <kbd>Super&Alt up</kbd> | resizeactive | 0 -100 |
| <kbd>Super&Control G</kbd> | togglegroup | |
| <kbd>Super G</kbd> | changegroupactive | f |
| <kbd>Super&Shift G</kbd> | changegroupactive | f |
| <kbd>Super&Shift&Control left</kbd> | movewindoworgroup | l |
| <kbd>Super&Shift&Control right</kbd> | movewindoworgroup | r |
| <kbd>Super&Shift&Control up</kbd> | movewindoworgroup | u |
| <kbd>Super&Shift&Control down</kbd> | movewindoworgroup | d |
| <kbd>Super 1</kbd> | focusworkspaceoncurrentmonitor | 1 |
| <kbd>Super 2</kbd> | focusworkspaceoncurrentmonitor | 2 |
| <kbd>Super 3</kbd> | focusworkspaceoncurrentmonitor | 3 |
| <kbd>Super 4</kbd> | focusworkspaceoncurrentmonitor | 4 |
| <kbd>Super 5</kbd> | focusworkspaceoncurrentmonitor | 5 |
| <kbd>Super 6</kbd> | focusworkspaceoncurrentmonitor | 6 |
| <kbd>Super 7</kbd> | focusworkspaceoncurrentmonitor | 7 |
| <kbd>Super 8</kbd> | focusworkspaceoncurrentmonitor | 8 |
| <kbd>Super 9</kbd> | focusworkspaceoncurrentmonitor | 9 |
| <kbd>Super 0</kbd> | focusworkspaceoncurrentmonitor | 10 |
| <kbd>Super D</kbd> | focusworkspaceoncurrentmonitor | name:D |
| <kbd>Super code:87</kbd> | focusworkspaceoncurrentmonitor | 1 |
| <kbd>Super code:88</kbd> | focusworkspaceoncurrentmonitor | 2 |
| <kbd>Super code:89</kbd> | focusworkspaceoncurrentmonitor | 3 |
| <kbd>Super code:83</kbd> | focusworkspaceoncurrentmonitor | 4 |
| <kbd>Super code:84</kbd> | focusworkspaceoncurrentmonitor | 5 |
| <kbd>Super code:85</kbd> | focusworkspaceoncurrentmonitor | 6 |
| <kbd>Super code:79</kbd> | focusworkspaceoncurrentmonitor | 7 |
| <kbd>Super code:80</kbd> | focusworkspaceoncurrentmonitor | 8 |
| <kbd>Super code:81</kbd> | focusworkspaceoncurrentmonitor | 9 |
| <kbd>Super code:91</kbd> | focusworkspaceoncurrentmonitor | 10 |
| <kbd>Super code:86</kbd> | focusworkspaceoncurrentmonitor | +1 |
| <kbd>Super code:82</kbd> | focusworkspaceoncurrentmonitor | -1 |
| <kbd>Super backspace</kbd> | focusworkspaceoncurrentmonitor | previous |
| <kbd>Super mouse_down</kbd> | focusworkspaceoncurrentmonitor | -1 |
| <kbd>Super mouse_up</kbd> | focusworkspaceoncurrentmonitor | +1 |
| <kbd>Super&Shift 1</kbd> | movetoworkspacesilent | 1 |
| <kbd>Super&Shift 2</kbd> | movetoworkspacesilent | 2 |
| <kbd>Super&Shift 3</kbd> | movetoworkspacesilent | 3 |
| <kbd>Super&Shift 4</kbd> | movetoworkspacesilent | 4 |
| <kbd>Super&Shift 5</kbd> | movetoworkspacesilent | 5 |
| <kbd>Super&Shift 6</kbd> | movetoworkspacesilent | 6 |
| <kbd>Super&Shift 7</kbd> | movetoworkspacesilent | 7 |
| <kbd>Super&Shift 8</kbd> | movetoworkspacesilent | 8 |
| <kbd>Super&Shift 9</kbd> | movetoworkspacesilent | 9 |
| <kbd>Super&Shift 0</kbd> | movetoworkspacesilent | 10 |
| <kbd>Super&Shift code:87</kbd> | movetoworkspacesilent | 1 |
| <kbd>Super&Shift code:88</kbd> | movetoworkspacesilent | 2 |
| <kbd>Super&Shift code:89</kbd> | movetoworkspacesilent | 3 |
| <kbd>Super&Shift code:83</kbd> | movetoworkspacesilent | 4 |
| <kbd>Super&Shift code:84</kbd> | movetoworkspacesilent | 5 |
| <kbd>Super&Shift code:85</kbd> | movetoworkspacesilent | 6 |
| <kbd>Super&Shift code:79</kbd> | movetoworkspacesilent | 7 |
| <kbd>Super&Shift code:80</kbd> | movetoworkspacesilent | 8 |
| <kbd>Super&Shift code:81</kbd> | movetoworkspacesilent | 9 |
| <kbd>Super&Shift code:91</kbd> | movetoworkspacesilent | 10 |
| <kbd>Super&Shift code:86</kbd> | movetoworkspacesilent | +1 |
| <kbd>Super&Shift code:82</kbd> | movetoworkspacesilent | -1 |
| <kbd>Super&Control left</kbd> | movecurrentworkspacetomonitor | l |
| <kbd>Super&Control right</kbd> | movecurrentworkspacetomonitor | r |
| <kbd>Super&Control up</kbd> | movecurrentworkspacetomonitor | u |
| <kbd>Super&Control down</kbd> | movecurrentworkspacetomonitor | d |
| <kbd>Super&Alt U</kbd> | exec | gnome-characters |
| <kbd>Super&Alt K</kbd> | exec | wl-copy |
| <kbd>XF86AudioMute</kbd> | exec | wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle |
| <kbd>ALT XF86AudioMute</kbd> | exec | wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle |
| <kbd>XF86AudioMicMute</kbd> | exec | wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle |
| <kbd>PRINT</kbd> | exec | grimblast copysave output /home/david/Pictures/Screenshots/$(date +'%F-%T\_%N.png') |
| <kbd>Super PRINT</kbd> | exec | grimblast --notify --freeze copysave area /home/david/Pictures/Screenshots/$(date +'%F-%T\_%N.png') |
| <kbd>ALT PRINT</kbd> | exec | satty --filename - --fullscreen --output-filename /home/david/Pictures/Screenshots/$(date +'%F-%T\_%N.png') |
| <kbd>Super&Alt PRINT</kbd> | exec | satty --filename - --output-filename /home/david/Pictures/Screenshots/$(date +'%F-%T\_%N.png') |
| <kbd>Super&Alt V</kbd> | exec | wl-copy' |
| <kbd>Super L</kbd> | exec | hyprlock |
| <kbd>Super Z</kbd> | exec | pypr zoom |
| <kbd>Super minus</kbd> | exec | pypr zoom --0.5 |
| <kbd>Super plus</kbd> | exec | pypr zoom ++0.5 |
| <kbd>Super&Alt mouse_down</kbd> | exec | pypr zoom ++0.5 |
| <kbd>Super&Alt mouse_up</kbd> | exec | pypr zoom --0.5 |
| <kbd>Super&Alt mouse:274</kbd> | exec | pypr zoom |
| <kbd>Super ODIAERESIS</kbd> | exec | pypr toggle_dpms |
| <kbd>Super Y</kbd> | exec | pypr toggle_special minimized |
| <kbd>Super&Shift Y</kbd> | togglespecialworkspace | minimized |
| <kbd>Super W</kbd> | exec | hyprpanel toggleWindow bar-0 |
| <kbd>Super SPACE</kbd> | exec | fuzzel |
| <kbd>Super&Alt N</kbd> | exec | pypr toggle networkmanager |
| <kbd>Super&Alt PERIOD</kbd> | exec | bitwarden |
| <kbd>Super&Alt A</kbd> | exec | pypr toggle pavucontrol |
| <kbd>XF86AudioPlay</kbd> | exec | playerctl play-pause |
| <kbd>XF86AudioPause</kbd> | exec | playerctl play-pause |
| <kbd>XF86AudioStop</kbd> | exec | playerctl stop |
| <kbd>XF86AudioNext</kbd> | exec | playerctl next |
| <kbd>XF86AudioPrev</kbd> | exec | playerctl previous |
| <kbd>CTRL XF86AudioRaiseVolume</kbd> | exec | playerctl position 1+ |
| <kbd>CTRL XF86AudioLowerVolume</kbd> | exec | playerctl position 1- |
| <kbd>ALT XF86AudioNext</kbd> | exec | playerctld shift |
| <kbd>ALT XF86AudioPrev</kbd> | exec | playerctld unshift |
| <kbd>ALT XF86AudioPlay</kbd> | exec | systemctl --user restart playerctld |
| <kbd>Super&Alt Z</kbd> | exec | xdg-open https://localhost:8384 |
| <kbd>Super RETURN</kbd> | exec | kitty |
| <kbd>Super&Alt T</kbd> | exec | pypr toggle kitty |
| <kbd>Super&Alt G</kbd> | exec | codium |
| <kbd>XF86AudioRaiseVolume</kbd> | exec | wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2.5%+ |
| <kbd>XF86AudioLowerVolume</kbd> | exec | wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2.5%- |
| <kbd>ALT XF86AudioRaiseVolume</kbd> | exec | wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 2.5%+ |
| <kbd>ALT XF86AudioLowerVolume</kbd> | exec | wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 2.5%- |
| <kbd>XF86KbdBrightnessUp</kbd> | exec | light -s sysfs/leds/kbd_backlight -A 10 |
| <kbd>XF86KbdBrightnessDown</kbd> | exec | light -s sysfs/leds/kbd_backlight -U 10 |
| <kbd>XF86MonBrightnessUp</kbd> | exec | light -U 5 |
| <kbd>XF86MonBrightnessDown</kbd> | exec | light -A 5 |
| <kbd>Super mouse:272</kbd> | movewindow | |
| <kbd>Super mouse:273</kbd> | resizewindow | |
| <kbd>Escape</kbd> | exec | pypr hide '\*' |

</details>

## Configuration

### Helpful Nix resources

- [NüschtOS option search](https://search.xn--nschtos-n2a.de/)
- [NixOS packages search](https://search.nixos.org/packages)
- [Nix functions](https://teu5us.github.io/nix-lib.html)
- [Nix functions](https://ryantm.github.io/nixpkgs/functions/library/attrsets/)
- [Noogle](https://noogle.dev/)

### NixOS stable branch

To use [nixpkgs](https://github.com/NixOS/nixpkgs) stable branch, update the following inputs to the latest release (`25.05` as an example) in _[flake.nix](https://github.com/dafitt/dotfiles/blob/main/flake.nix)_ and rebuild the system. \
ATTENTION! When the latest release of [nixpkgs](https://github.com/NixOS/nixpkgs) is some time away, then you will likely need to refactor some breaking changed options. See the backward incompatibilities [in the release notes](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/doc/manual/release-notes/rl-2505.section.md#backward-incompatibilities-sec-release-2505-incompatibilities) for those. Directly after a new release should be the best time to switch.

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-25.05";
  };
}
```

To still let specific packages follow nixpkgs unstable while on the stable branch you can add an overlay:

```nix
{ inputs, ... }:

final: prev:
with inputs.nixpkgs-unstable.legacyPackages.${prev.system}; {
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
  dafitt.url = "github:dafitt/dotfiles";
  dafitt.inputs.nixpkgs.follows = "nixpkgs";
};

outputs = { nixpkgs, ... }@inputs: {
  nixosConfigurations."<host>" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # e.g.
      inputs.dafitt.nixosModules.hyprland
      inputs.dafitt.homeModules.hyprland
      inputs.dafitt.homeModules.browser-firefox
    ];
  };
};
```

But it is certainly better to simply copy them into your dotfiles and adapt them to your needs.

### You want to build from here?

Starting points for customization:

- [ ] [modules/nixos/time.nix](https://github.com/dafitt/dotfiles/blob/main/modules/nixos/time/default.nix): timezone
- [ ] [modules/nixos/locale.nix](https://github.com/dafitt/dotfiles/blob/main/modules/nixos/locale/default.nix): locale
- [ ] [modules/home/browser-firefox.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/browser-firefox.nix#L183):
  - the default searx search engine is my own local instance/server, use a official one or setup your own
  - custom firefox plugins
- [ ] [hosts/](https://github.com/dafitt/dotfiles/blob/main/hosts): your own hosts configuration
  - [ ] `configuration.nix`
  - [ ] `hardware-configuration.nix`
  - [ ] users
- [ ] [modules/home/hyprland/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/hyprland/default.nix): familiar keybindings
- [ ] [modules/home/stylix/default.nix](https://github.com/dafitt/dotfiles/blob/main/modules/home/stylix/default.nix): custom base16 theme / icon theme
- [ ] Packages and programs you need

## Troubleshooting

### Unable to see fonts

Manually reload the fontconfig cache using

```shell
fc-cache -r [-f]
```

### Bluetooth does not power on

Error messages:

```
Failed to set power on: org.bluez.Error.Failed
bluetoothd: Failed to set mode: Failed (0x03)
```

Check and unblock bluetooth software side with:

```shell
rfkill list
sudo rfkill unblock bluetooth
```

### Application won't open with Home-manager standalone

- ["Using Nix on non-NixOS distros, it's common to see GL application errors"](https://github.com/nix-community/nixGL?tab=readme-ov-file#motivation) - [NixGL](https://github.com/nix-community/nixGL):

  ```shell
  nix run --impure github:nix-community/nixGL -- <PROGRAM>
  ```

- Try to also install the program with the underlining distro. E.g. Debian:

  ```shell
  sudo apt install <PROGRAM>
  ```

### Corrupted /nix/var/nix/db/db.sqlite

You need to reinstall NixOS.

Create a new subvolume (i.e. `@nix.new`) and mount it under `/mnt/nix` (i.e. mount <btrfs> -o subvol=nix2 /tmp/foo/nix --mkdir). Next bind-mount your `/boot` and/or efi in the same place relative to `/mnt/` as they are in the real system (i.e. `/mnt/boot`).
Then you `nixos-install --flake .#<hostname>`.

Now you’ve got a working Nix store with your current closure in the `nix.new` subvolume and a bootloader set up to boot from it. All that is left to do is swap the `@nix.new` subvol with your regular `@nix` subvol (that’s where your fstab is set up to find it) and reboot. If you’ve done everything correctly, you should boot into your current generation with a brand new Nix store.

Commands to help:

```sh
mount /dev/nvme0n1p2 /mnt
btrfs subvolume create /mnt/@nix.new
umount /mnt
mkdir /mnt/nix /mnt/boot
mount /dev/nvme0n1p1 /mnt/nix
mount -o subvol=@nix2 /dev/nvme0n1p2 /mnt/nix
nixos-install --flake .#<hostname>
umount /mnt/nix /mnt/boot
mount /dev/nvme0n1p2 /mnt
mv /mnt/@nix /mnt/@nix.old
mv /mnt/@nix.new /mnt/@nix
reboot
mount /dev/nvme0n1p2 /mnt
btrfs subvolume delete /mnt/@nix.old
```

## 👀, 🏆 and ❤️

- [Vimjoyer - Youtube](https://www.youtube.com/@vimjoyer)
- [IogaMaster - Youtube](https://www.youtube.com/@IogaMaster)
- [github:mikeroyal/NixOS-Guide](https://github.com/mikeroyal/NixOS-Guide)
- [github:jakehamilton/config](https://github.com/jakehamilton/config)
- [github:IogaMaster/dotfiles](https://github.com/IogaMaster/dotfiles)
- [github:IogaMaster/snowfall-starter](https://github.com/IogaMaster/snowfall-starter)
- [github:Misterio77/nix-config](https://github.com/Misterio77/nix-config)
- [github:Aylur/dotfiles](https://github.com/Aylur/dotfiles)
