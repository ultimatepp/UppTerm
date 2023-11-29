.PHONY: build

build:
	mkdir -p build
	3p/umk/umk app/,3p/uppsrc UppTerm 3p/umk/CLANG.bm -brvh +GUI,SHARED build/UppTerm
	
download:
	mkdir -p 3p/download
	wget https://github.com/ultimatepp/ultimatepp/releases/download/2023.2/uppsrc-17045.tar.gz -P 3p/download
	wget https://github.com/ultimatepp/ultimatepp/releases/download/2023.2/umk-17045-linux-x86-64.tar.gz -P 3p/download
	tar -xf 3p/download/uppsrc-17045.tar.gz -C 3p
	tar -xf 3p/download/umk-17045-linux-x86-64.tar.gz -C 3p

run:
	build/UppTerm

clean:
	rm -rf build
	rm -rf 3p
