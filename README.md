# Chocolatey: Airtame

## Description

Installs and configures the [Airtame](https://airtame.com/) software.

## Package Parameters

| Parameter            | Default     | Comments                                   |
| :---                 | :---        | :---                                       |
| /AUTOSTART | false | Disables the Airtame in the Autostart. |

## Installation

The package is created as follows.

```ps1
choco pack airtame.nuspec --outputdirectory build
```

installation without parameters.

```ps1
 choco install airtame -s="<path to folder>\build"
```

installation with parameters.

```ps1
 choco install airtame --params="'/AUTOSTART:true'" -s="<path to folder>\build"
```

## Changelog

### 3.2.2

* inital commit
* add new version from Airtame

## Author

* [Simon Bärlocher](https://sbaerlocher.ch)
* [ITIGO AG](https://www.itigo.ch)

## License

This project is under the MIT License. See the [LICENSE](https://sbaerlo.ch/licence) file for the full license text.

## Copyright

(c) 2018, Simon Bärlocher
(c) 2018, ITIGO AG