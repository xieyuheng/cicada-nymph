.ONESHELL:

ROOT ?=
SYSTEM_CICADADIR ?= $(ROOT)/etc/cicada

PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin

CICADADIR ?= $(HOME)/.cicada

help:
	@
	echo -e " \e[33;1m							     \e[0m "
	echo -e " \e[33;1m   dependencies					     \e[0m "
	echo -e " \e[33;1m     fasm   to compile				     \e[0m "
	echo -e " \e[33;1m							     \e[0m "
	echo -e " \e[33;1m							     \e[0m "
	echo -e " \e[33;1m   makefile functions					     \e[0m "
	echo -e " \e[33;1m     all						     \e[0m "
	echo -e " \e[33;1m	 linux64					     \e[0m "
	echo -e " \e[33;1m	 windows64					     \e[0m "
	echo -e " \e[33;1m	 linux32					     \e[0m "
	echo -e " \e[33;1m	 windows32					     \e[0m "
	echo -e " \e[33;1m     clean						     \e[0m "
	echo -e " \e[33;1m							     \e[0m "
	echo -e " \e[33;1m							     \e[0m "
	echo -e " \e[33;1m   please read the makefile for more informations	     \e[0m "
	echo -e " \e[33;1m							     \e[0m "
	echo -e " \e[33;1m   I wish you happy making ^-^			     \e[0m "
	echo -e " \e[33;1m							     \e[0m "

all:
	@
	echo -e " "				     &&\
	echo -e "\e[33;1m [linux64] \e[0m "	     &&\
	make linux64				     &&\
	echo -e " "				     &&\
	echo -e "\e[33;1m [windows64] \e[0m "	     &&\
	make windows64				     &&\
	echo -e " "				     &&\
	echo -e "\e[33;1m [linux32] \e[0m "	     &&\
	make linux32				     &&\
	echo -e " "				     &&\
	echo -e "\e[33;1m [windows32] \e[0m "	     &&\
	make windows32				     &&\
	echo -e " "

copy-core-file--user:
	install -D --mode=664 core.cn -t "$(CICADADIR)"

copy-core-file--system:
	install -D --mode=664 core.cn -t "$(SYSTEM_CICADADIR)"

install:
	install -D --mode=775 cn -t "$(BINDIR)"
	install -D --mode=775 cn32 -t "$(BINDIR)"

linux64:
	@
	echo "define platform linux" >	platform-configuration.inc
	echo "define machine  64bit" >> platform-configuration.inc
	fasm -m 256000 cicada-nymph.fasm cn

windows64:
	@
	echo "define platform windows" >  platform-configuration.inc
	echo "define machine  64bit"   >> platform-configuration.inc
	fasm -m 256000 cicada-nymph.fasm cn.exe

linux32:
	@
	echo "define platform linux" >	platform-configuration.inc
	echo "define machine  32bit" >> platform-configuration.inc
	fasm -m 256000 cicada-nymph.fasm cn32

windows32:
	@
	echo "define platform windows" >  platform-configuration.inc
	echo "define machine  32bit"   >> platform-configuration.inc
	fasm -m 256000 cicada-nymph.fasm cn32.exe

clean*~:
	@
	rm -f *~ */*~ */*/*~ */*/*/*~ */*/*/*/*~  */*/*/*/*/*~

clean*.bin:
	@
	rm -f *.bin */*.bin */*/*.bin */*/*/*.bin */*/*/*/*.bin	 */*/*/*/*/*.bin

clean:
	@
	make clean*~
	make clean*.bin
	rm cn
	rm cn32
	rm cn.exe
	rm cn32.exe
	echo -e "\e[33;1m [ok] clean directory \e[0m"
