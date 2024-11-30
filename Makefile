.PHONY: build

build:
	mkdir -p build
	3p/umk/umk app/,3p/uppsrc UppTerm 3p/umk/CLANG.bm -brvh +GUI,SHARED build/UppTerm
	mv build/UppTerm build/upp-term
	
download:
	mkdir -p 3p/download
	wget https://github.com/ultimatepp/ultimatepp/releases/download/2024.1/uppsrc-17458.tar.gz -P 3p/download
	wget https://github.com/ultimatepp/ultimatepp/releases/download/2024.1/umk-17458-linux-x86-64.tar.gz -P 3p/download
	tar -xf 3p/download/uppsrc-17458.tar.gz -C 3p
	tar -xf 3p/download/umk-17458-linux-x86-64.tar.gz -C 3p

run:
	build/upp-term

clean:
	rm -rf build
	rm -rf 3p
