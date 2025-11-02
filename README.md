# UppTerm

[![U++ Discord](https://img.shields.io/discord/1046445457951424612)](https://discord.gg/8XzqQzXZzb)
[![License](https://img.shields.io/badge/License-BSD_2--Clause-orange.svg)](https://opensource.org/licenses/BSD-2-Clause)

## Introduction
UppTerm is simple terminal application written in U++ framework. It is based on [TerminalCtrl](https://github.com/ismail-yilmaz/Terminal) UppHub package written and maintained by [İsmail Yılmaz](https://github.com/ismail-yilmaz/).

This U++ repository is designed for simplicity. It doesn't require a U++ framework installation on your system. Using the [just](https://github.com/casey/just) command utility  (which you can treat as a replacement for `make`), the entire application, along with all dependencies (including UMK), will be built and downloaded automatically from the internet. This is an excellent example of using the U++ framework without TheIDE.

UppTerm is a supportive component within the U++ Flatpak distribution. It launches the first time a user runs the Flatpak, downloading system-wide dependencies required for compiling framework applications. To learn more, you can visit the U++ Flatpak recipe [repository](https://github.com/flathub/org.ultimatepp.TheIDE).

## Developing using command line

### Requirements

#### Windows

For a smooth development experience on Windows, you'll need to install the following essential software:
- 7-Zip: For file compression and decompression.
- Git for Windows: This package is crucial for version control and includes Git Bash, which is the required terminal environment for all build commands.

All build and compilation commands must be executed within the included Git Bash terminal. Do not use Command Prompt or PowerShell.

For convenient installation of third part software, we highly recommend using a package manager like Winget or Chocolatey.

#### POSIX

The first step in command-line building is to install all prerequisites and dependencies required to compile TheIDE.

### Building 
To build this project you do not need to install U++ framework just use following just commands
```bash
just download
just build
```

The first command will download the dependencies from the internet. The second one will build the application.

### Running
To run the application, execute the following command from the repository root directory:
```bash
build/upp-term
```

You can also specify the script to execute by the terminal application
```bash
build/upp-term "/bin/bash /home/klugier/test.sh"
```

### Cleaning
To remove all downloaded dependencies and build files, run the following command:
```bash
just clean
```

## Developing using TheIDE

If you want to develop this repository using TheIDE, our project's integrated development environment, that's still possible.

Simply add the repository directory as a new assembly within TheIDE and launch the UppTerm package.

Please note that you must also specify the link to uppsrc. To avoid potential conflicts, we recommend not using the uppsrc located in the `3p` directory and downloaded through `just download` command. Ideally, the `3p` directory should be removed when you are working from TheIDE.

## Alternatives

If you're looking for a fully functional alternative to this simple terminal application, we recommend [Bobcat](https://github.com/ismail-yilmaz/Bobcat). It's a complete feature-rich terminal application written entirely in U++.

Both Bobcat and this simpler UppTerm utilize the same brilliant terminal packages developed by İsmail Yılmaz. 
