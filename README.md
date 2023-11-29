# UppTerm

## Introduction
UppTerm is simple terminal application written in U++ framework. It is basing on [Terminal](https://github.com/ismail-yilmaz/Terminal) written and maintained by Ismail Yilmaz

The main feature of this repository is that it doesn't require U++ framework installation. You can use make command and whole application will be build automaticaly. All dependencies including UMK will be downloaded from the internet. So, if you are looking for the example of using U++ framework without TheIDE it is a good repository to study the code and build architecture.

## Building 
To build this project you do not need to install U++ framework just use following make commands
```bash
make download
make 
```

The first command will download a;; dependnencies from the internet. The second one will build the application.

## Running
To run the application execute following command from the repository root directory:
```
build/UppTerm
```

You can also specify the script to execute by the terminal application
```
build/UppTerm "/bin/bash /home/klugier/test.sh"
```
