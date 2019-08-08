# Chocolatey Package: Airtame

[![Build Status](https://img.shields.io/travis/itigoag/chocolatey.airtame?style=flat-square)](https://travis-ci.org/itigoag/chocolatey.airtame) [![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=popout-square)](licence) [![Chocolatey](https://img.shields.io/chocolatey/v/airtame?label=package%20version)](https://chocolatey.org/packages/airtame) [![Chocolatey](https://img.shields.io/chocolatey/dt/airtame?label=package%20downloads&style=flat-square)](https://chocolatey.org/packages/airtame)

## Description

[Airtame](https://airtame.com/) is a wireless device that plugs into the HDMI port of any screen or projector and streams your content to the screen from a computer or mobile device.

## Package Parameters

- `/Autostart` `false` Disables the Airtame in the Autostart.
- `/RemoveDesktopIcons` Removes the desktop icon from Airtame.
- `/CleanStartmenu` Removes frequently used airtame shortcuts from the Startmenu.

## Installation

### choco

installation without parameters.

```ps1
 choco install airtame
```

installation with parameters.

```ps1
 choco install airtame --params="'/Autostart:false /RemoveDesktopIcons /CleanStartmenu'"
```

### [ITIGO Packages](https://github.com/itigoag/ansible.packages)

installation without parameters.

```yml
packages:
  airtame:
    version: latest
```

installation with parameters.

```yml
packages:
  airtame:
    version: latest
    params: "'/Autostart:false /RemoveDesktopIcons /CleanStartmenu'"
```

## Disclaimer

These Chocolatey Packages only contain installation routines. The software itself is downloaded from the official sources of the software developer. ITIGO AG has no affilation with the software developer.

## Author

- [Simon Bärlocher](https://sbaerlocher.ch)
- [ITIGO AG](https://www.itigo.ch)

## License

This project is under the MIT License. See the [LICENSE](LICENSE) file for the full license text.

## Copyright

(c) 2019, ITIGO AG
