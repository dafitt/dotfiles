# My daily driver's NixOS❄️ desktop flake

![Hyprland-ricing](https://github.com/dafitt/dotfiles/assets/50248238/380705a7-4bd5-4431-81fe-ab04195e19f0)

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
- 🪟 [Hyprland](https://hypr.land/) with plugins, [GNOME](https://www.gnome.org/) with extensions

## Installation

### New host machine

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

### New home standalone environment

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

## Troubleshooting

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
