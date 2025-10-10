# UppTerm

## Introduction
UppTerm is simple terminal application written in U++ framework. It is based on [TerminalCtrl](https://github.com/ismail-yilmaz/Terminal) UppHub package written and maintained by [İsmail Yılmaz](https://github.com/ismail-yilmaz/).

This U++ repository is designed for simplicity. It doesn't require a U++ framework installation on your system. Using the [just](https://github.com/casey/just) command utility  (which you can treat as a replacement for `make`), the entire application, along with all dependencies (including UMK), will be built and downloaded automatically from the internet. This is an excellent example of using the U++ framework without TheIDE.

UppTerm is a supportive component within the U++ Flatpak distribution. It launches the first time a user runs the Flatpak, downloading system-wide dependencies required for compiling framework applications. To learn more, you can visit the U++ Flatpak recipe [repository](https://github.com/flathub/org.ultimatepp.TheIDE).

## Building 
To build this project you do not need to install U++ framework just use following just commands
```bash
just download
just 
```

The first command will download the dependencies from the internet. The second one will build the application.

## Running
To run the application, execute the following command from the repository root directory:
```bash
build/upp-term
```

You can also specify the script to execute by the terminal application
```bash
build/upp-term "/bin/bash /home/klugier/test.sh"
```

## Cleaning
To remove all downloaded dependencies and build files, run the following command:
```bash
just clean
```
