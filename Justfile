#!/usr/bin/env -S just --justfile

upp_version := "2025.1.1"
upp_revision := "17810"

umk_exe := if os_family() == "unix" { "3p/umk/umk.out" } else { "3p/umk/umk" }
upp_hub_dir := "3p/hub"
build_flags := if os_family() == "unix" { ",SHARED" } else if os_family() == "windows" { ",WIN10" } else { "" }

default: build

download:
    #!/usr/bin/env sh
    if [ "{{os_family()}}" = "unix" ]; then
        just download-posix
    elif [ "{{os_family()}}" = "windows" ]; then
        just download-windows
    fi

    printf "\nDownloading dependencies from UppHub...\n"
    {{umk_exe}} ./,3p/uppsrc UppTerm 3p/umk/CLANG.bm --hub-dir {{upp_hub_dir}} --hub-only -U

[private]
download-posix:
    mkdir -p 3p/downloads

    printf "Downloading uppsrc-{{upp_revision}}.tar.gz\n"
    curl -L --progress-bar -o 3p/downloads/uppsrc-{{upp_revision}}.tar.gz \
        'https://github.com/ultimatepp/ultimatepp/releases/download/v{{upp_version}}/uppsrc-{{upp_revision}}.tar.gz'
    printf "Downloading umk-posix-{{upp_revision}}.tar.gz\n"
    curl -L --progress-bar -o 3p/downloads/umk-posix-{{upp_revision}}.tar.gz \
        'https://github.com/ultimatepp/ultimatepp/releases/download/v{{upp_version}}/umk-posix-{{upp_revision}}.tar.gz'

    printf "\nExtracting uppsrc and umk...\n"
    tar -xf 3p/downloads/uppsrc-{{upp_revision}}.tar.gz -C 3p
    tar -xf 3p/downloads/umk-posix-{{upp_revision}}.tar.gz -C 3p

    printf "\nBuilding umk...\n"
    make -j {{num_cpus()}} -C 3p/umk

[private]
download-windows:
    mkdir -p 3p/downloads

    printf "Downloading uppsrc-{{upp_revision}}.tar.gz\n"
    curl -L --progress-bar -o 3p/downloads/uppsrc-{{upp_revision}}.tar.gz \
        'https://github.com/ultimatepp/ultimatepp/releases/download/v{{upp_version}}/uppsrc-{{upp_revision}}.tar.gz'
    printf "Downloading umk-win-{{upp_revision}}.7z\n"
    curl -L --progress-bar -o 3p/downloads/umk-win-{{upp_revision}}.7z \
        'https://github.com/ultimatepp/ultimatepp/releases/download/v{{upp_version}}/umk-win-{{upp_revision}}.7z'

    printf "\nExtracting uppsrc and umk...\n"
    tar -xf 3p/downloads/uppsrc-{{upp_revision}}.tar.gz -C 3p
    7z x 3p/downloads/umk-win-{{upp_revision}}.7z -o3p

build:
    #!/usr/bin/env sh
    if [ ! -f "{{umk_exe}}" ]; then
        printf "umk not found, please run 'just download' to download all necessary dependencies.\n"
        exit 1
    fi

    mkdir -p build
    {{umk_exe}} ./,3p/uppsrc UppTerm 3p/umk/CLANG.bm --hub-dir {{upp_hub_dir}} -brv +GUI{{build_flags}} build/UppTerm
    mv build/UppTerm build/upp-term

run:
    build/upp-term

clean:
    rm -rf 3p
    rm -rf build
