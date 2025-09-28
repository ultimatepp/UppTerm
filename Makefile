.PHONY: build

NPROCS := $(shell nproc)
MAKEFLAGS += -j$(NPROCS)

build:
	mkdir -p build
	3p/umk/umk.out app/,3p/uppsrc UppTerm 3p/umk/CLANG.bm -brvh +GUI,SHARED build/UppTerm
	mv build/UppTerm build/upp-term
	
download:
	mkdir -p 3p/download
	wget https://github.com/ultimatepp/ultimatepp/releases/download/v2025.1.1/uppsrc-17810.tar.gz -P 3p/download
	wget https://github.com/ultimatepp/ultimatepp/releases/download/v2025.1.1/umk-posix-17810.tar.gz -P 3p/download
	tar -xf 3p/download/uppsrc-17810.tar.gz -C 3p
	tar -xf 3p/download/umk-posix-17810.tar.gz -C 3p
	make -C 3p/umk

run:
	build/upp-term

clean:
	rm -rf build
	rm -rf 3p

