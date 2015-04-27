.ONESHELL:

ROOT ?=
SYSTEM_CICADADIR ?= $(ROOT)/etc/cicada

PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin

CICADADIR ?= $(HOME)/.cicada

help:
	@
	echo -e "\e[33;1m"
	echo ""
	echo "* dependencies"
	echo "  * fasm"
	echo "    to compile source code"
	echo "* makefile operations"
	echo "  * build"
	echo "    * build-linux64"
	echo "    * build-linux32"
	echo "  * tangle"
	echo "    * tangle-cicada-nymph.org"
	echo "    * tangle-core.org"
	echo "  * copy-core-file"
	echo "    * copy-core-file-user"
	echo "    * copy-core-file-system"
	echo "  * remove-core-file"
	echo "    * remove-core-file-user"
	echo "    * remove-core-file-system"
	echo "  * install"
	echo "  * uninstall"
	echo "  * clean"
	echo ""
	echo "* I wish you happy making ^-^"
	echo "  please read the makefile for more informations"
	echo ""
	echo -e "\e[0m"

build: build-linux64 build-linux32
build-linux64:
	@
	echo -e "\e[33;1m"
	echo "* build-linux64"
	echo -e "\e[0m"
	echo "define platform linux" >  platform-configuration.inc &&\
	echo "define machine  64bit" >> platform-configuration.inc &&\
	fasm -m 256000 cicada-nymph.fasm cn
build-linux32:
	@
	echo -e "\e[33;1m"
	echo "* build-linux32"
	echo -e "\e[0m"
	echo "define platform linux" >  platform-configuration.inc &&\
	echo "define machine  32bit" >> platform-configuration.inc &&\
	fasm -m 256000 cicada-nymph.fasm cn32

tangle: tangle-cicada-nymph.org tangle-core.org
tangle-cicada-nymph.org:
	@
	echo -e "\e[33;1m"
	echo "* tangle-cicada-nymph.org"
	echo -e "\e[0m"
	./tangle.el
tangle-core.org:
	@
	cd core &&\
	echo -e "\e[33;1m" &&\
	echo "* tangle-core.org" &&\
	echo -e "\e[0m" &&\
	./tangle.el

copy-core-file: copy-core-file-user copy-core-file-system
copy-core-file-user:
	@
	echo -e "\e[33;1m"
	echo "* copy-core-file--user"
	echo -e "\e[0m"
	install -D --mode=664 core/core.cn -t "$(CICADADIR)"
copy-core-file-system:
	@
	echo -e "\e[33;1m"
	echo "* copy-core-file--system"
	echo -e "\e[0m"
	install -D --mode=664 core/core.cn -t "$(SYSTEM_CICADADIR)"

remove-core-file: remove-core-file-user remove-core-file-system
remove-core-file-user:
	@
	echo -e "\e[33;1m"
	echo "* remove-core-file--user"
	echo -e "\e[0m"
	rm $(CICADADIR)/core.cn
remove-core-file-system:
	@
	echo -e "\e[33;1m"
	echo "* remove-core-file--system"
	echo -e "\e[0m"
	rm $(SYSTEM_CICADADIR)/core.cn

install:
	@
	echo -e "\e[33;1m"
	echo "* install"
	echo -e "\e[0m"
	install -D --mode=775 cn -t "$(BINDIR)"
	install -D --mode=775 cn32 -t "$(BINDIR)"

uninstall:
	@
	echo -e "\e[33;1m"
	echo "* uninstall"
	echo -e "\e[0m"
	rm $(BINDIR)/cn
	rm $(BINDIR)/cn32

clean:
	@
	echo -e "\e[33;1m"
	echo "* clean"
	echo -e "\e[0m"
	rm -f *~ */*~ */*/*~ */*/*/*~ */*/*/*/*~  */*/*/*/*/*~
	rm cn
	rm cn32
