# Chocolatey Package: Airtame

## Description

[Airtame](https://airtame.com/) is a wireless device that plugs into the HDMI port of any screen or projector and streams your content to the screen from a computer or mobile device.

## Package Parameters

* `/Autostart` `false` Disables the Airtame in the Autostart.
* `/RemoveDesktopIcons` Removes the desktop icon from Airtame.
* `/CleanStartmenu` Removes frequently used airtame shortcuts from the Startmenu.

## Installation

installation without parameters.

```ps1
 choco install airtame
```

installation with parameters.

```ps1
 choco install airtame --params="'/Autostart:false /RemoveDesktopIcons /CleanStartmenu'"
```

## Disclaimer

These Chocolatey Packages only contain installation routines. The software itself is downloaded from the official sources of the software developer. ITIGO AG has no affilation with the software developer.

## Author

* [Simon Bärlocher](https://sbaerlocher.ch)
* [ITIGO AG](https://www.itigo.ch)

## License

This project is under the MIT License. See the [LICENSE](LICENSE) file for the full license text.

## Copyright

(c) 2018, Simon Bärlocher
(c) 2018, ITIGO AG
