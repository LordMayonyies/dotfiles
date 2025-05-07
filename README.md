# dotfiles
Dotfiles for ArchLinux ws

## Programs needed
* i3
* i3status
* i3lock
* dmenu
* brigthnessctl
* xss-lock
* kitty
* flameshot
* [SourceCodePro-NerdFont](https://github.com/ryanoasis/nerd-fonts/releases)

## Nice to have
| Name | Description |
| ---- | ----------- |
| bluetui  | For managing the bluetooth devices with a TUI |
| ncdu | du but through TUI |
| autorandr | Save screen configurations and autoapply it |
| arandr | GUI to configure the screens configuration |

## Install steps

### [Fonts](https://wiki.archlinux.org/title/Fonts#Manual_installation)

For system-wide fonts installation, place the the fonts under `/usr/local/share/fonts`

It is highly recommended to create a subdirectory structure for clarity.

Example structure:

```text
/usr/local/share/fonts/
├── otf
│   └── SourceCodeVariable
│       ├── SourceCodeVariable-Italic.otf
│       └── SourceCodeVariable-Roman.otf
└── ttf
    ├── AnonymousPro
    │   ├── Anonymous-Pro-B.ttf
    │   ├── Anonymous-Pro-I.ttf
    │   └── Anonymous-Pro.ttf
    └── CascadiaCode
        ├── CascadiaCode-Bold.ttf
        ├── CascadiaCode-Light.ttf
        └── CascadiaCode-Regular.ttf
```
