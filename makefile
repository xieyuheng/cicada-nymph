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
	echo -e " \e[33;1m	 linux32					     \e[0m "
	echo -e " \e[33;1m     clean						     \e[0m "
	echo -e " \e[33;1m							     \e[0m "
	echo -e " \e[33;1m							     \e[0m "
	echo -e " \e[33;1m   please read the makefile for more informations	     \e[0m "
	echo -e " \e[33;1m							     \e[0m "
	echo -e " \e[33;1m   I wish you happy making ^-^			     \e[0m "
	echo -e " \e[33;1m							     \e[0m "

all:
	@
	echo -e "\e[33;1m [linux64] \e[0m " &&\
	echo "define platform linux" >	platform-configuration.inc &&\
	echo "define machine  64bit" >> platform-configuration.inc &&\
	fasm -m 256000 cicada-nymph.fasm cn &&\
	echo -e "\e[33;1m [linux32] \e[0m " &&\
	echo "define platform linux" >	platform-configuration.inc &&\
	echo "define machine  32bit" >> platform-configuration.inc &&\
	fasm -m 256000 cicada-nymph.fasm cn32

user-copy-core-file:
	@
	echo -e "\e[33;1m [copy-core-file--user] \e[0m " &&\
	install -D --mode=664 core.cn -t "$(CICADADIR)"

system-copy-core-file:
	@
	echo -e "\e[33;1m [copy-core-file--system] \e[0m " &&\
	install -D --mode=664 core.cn -t "$(SYSTEM_CICADADIR)"

install:
	@
	echo -e "\e[33;1m [install] \e[0m " &&\
	install -D --mode=775 cn -t "$(BINDIR)"
	install -D --mode=775 cn32 -t "$(BINDIR)"

linux64:
	@
	echo -e "\e[33;1m [linux64] \e[0m " &&\
	echo "define platform linux" >	platform-configuration.inc &&\
	echo "define machine  64bit" >> platform-configuration.inc &&\
	fasm -m 256000 cicada-nymph.fasm cn

linux32:
	@
	echo -e "\e[33;1m [linux32] \e[0m " &&\
	echo "define platform linux" >	platform-configuration.inc &&\
	echo "define machine  32bit" >> platform-configuration.inc &&\
	fasm -m 256000 cicada-nymph.fasm cn32

clean:
	@
	echo -e "\e[33;1m [clean] \e[0m"
	rm -f *~ */*~ */*/*~ */*/*/*~ */*/*/*/*~  */*/*/*/*/*~
	rm cn
	rm cn32
