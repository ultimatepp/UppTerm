#!/usr/bin/env -S just --justfile

upp_version := "2025.1.1"
upp_revision := "17810"

default: build

download:
    mkdir -p 3p/download

    printf "Downloading uppsrc-{{upp_revision}}.tar.gz\n"
    curl -L --progress-bar -o 3p/download/uppsrc-{{upp_revision}}.tar.gz \
        'https://github.com/ultimatepp/ultimatepp/releases/download/v{{upp_version}}/uppsrc-{{upp_revision}}.tar.gz'
    printf "Downloading umk-posix-{{upp_revision}}.tar.gz\n"
    curl -L --progress-bar -o 3p/download/umk-posix-{{upp_revision}}.tar.gz \
        'https://github.com/ultimatepp/ultimatepp/releases/download/v{{upp_version}}/umk-posix-{{upp_revision}}.tar.gz'

    printf "\nExtracting uppsrc and umk...\n"
    tar -xf 3p/download/uppsrc-{{upp_revision}}.tar.gz -C 3p
    tar -xf 3p/download/umk-posix-{{upp_revision}}.tar.gz -C 3p

    printf "\nBuilding umk...\n"
    make -j {{num_cpus()}} -C 3p/umk

build:
    mkdir -p build
    3p/umk/umk.out app/,3p/uppsrc UppTerm 3p/umk/CLANG.bm -brvh +GUI,SHARED build/UppTerm
    mv build/UppTerm build/upp-term

run:
    build/upp-term

clean:
    rm -rf 3p
    rm -rf build
