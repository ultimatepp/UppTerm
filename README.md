# UppTerm

## Introduction
UppTerm is simple terminal application written in U++ framework. It is based on [TerminalCtrl](https://github.com/ismail-yilmaz/Terminal) written and maintained by [İsmail Yılmaz](https://github.com/ismail-yilmaz/)

The main feature of this repository is that it doesn't require U++ framework installation. You can use the make command and the whole application will be built automaticaly. All dependencies, including UMK, will be downloaded from the internet. So, if you are looking for the example of using U++ framework without TheIDE it is a good repository to study the code and build architecture.

## Building 
To build this project you do not need to install U++ framework just use following make commands
```bash
make download
make 
```

The first command will download the dependencies from the internet. The second one will build the application.

## Running
To run the application, execute the following command from the repository' root directory:
```
build/upp-term
```

You can also specify the script to execute by the terminal application
```
build/upp-term "/bin/bash /home/klugier/test.sh"
```
