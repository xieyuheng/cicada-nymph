.ONESHELL:

help:
	@
	echo -e " \E[33;1m                                                           \E[0m "
	echo -e " \E[33;1m   dependencies                                            \E[0m "
	echo -e " \E[33;1m     fasm   to compile                                     \E[0m "
	echo -e " \E[33;1m                                                           \E[0m "
	echo -e " \E[33;1m                                                           \E[0m "
	echo -e " \E[33;1m   Makefile functions                                      \E[0m "
	echo -e " \E[33;1m     all                                                   \E[0m "
	echo -e " \E[33;1m       linux64                                             \E[0m "
	echo -e " \E[33;1m       windows64                                           \E[0m "
	echo -e " \E[33;1m       linux32                                             \E[0m "
	echo -e " \E[33;1m       windows32                                           \E[0m "
	echo -e " \E[33;1m     clean                                                 \E[0m "
	echo -e " \E[33;1m							     \E[0m "
	echo -e " \E[33;1m                                                           \E[0m "
	echo -e " \E[33;1m   please read the Makefile for more informations          \E[0m "
	echo -e " \E[33;1m							     \E[0m "
	echo -e " \E[33;1m   I wish you happy making ^-^                             \E[0m "
	echo -e " \E[33;1m                                                           \E[0m "

all:
	@
	echo -e " "                             &&\
	echo -e "\E[33;1m [linux64] \E[0m "     &&\
	make linux64                            &&\
	echo -e " "                             &&\
	echo -e "\E[33;1m [windows64] \E[0m "   &&\
	make windows64                          &&\
	echo -e " "                             &&\
	echo -e "\E[33;1m [linux32] \E[0m "     &&\
	make linux32                            &&\
	echo -e " "                             &&\
	echo -e "\E[33;1m [windows32] \E[0m "   &&\
	make windows32                          &&\
	echo -e " "


linux64:
	@
	echo "define platform linux" >  platform-configuration.inc
	echo "define machine  64bit" >> platform-configuration.inc
	fasm cicada-nymph.fasm

windows64:
	@
	echo "define platform windows" >  platform-configuration.inc
	echo "define machine  64bit"   >> platform-configuration.inc
	fasm cicada-nymph.fasm 

linux32:
	@
	echo "define platform linux" >  platform-configuration.inc
	echo "define machine  32bit" >> platform-configuration.inc
	fasm cicada-nymph.fasm 

windows32:
	@
	echo "define platform windows" >  platform-configuration.inc
	echo "define machine  32bit"   >> platform-configuration.inc
	fasm cicada-nymph.fasm 

clean*~:
	@
	rm -f *~ */*~ */*/*~ */*/*/*~ */*/*/*/*~  */*/*/*/*/*~  

clean*.bin:
	@
	rm -f *.bin */*.bin */*/*.bin */*/*/*.bin */*/*/*/*.bin  */*/*/*/*/*.bin

clean:
	@
	make clean*~                                  &&\
	make clean*.bin                               &&\
	rm cicada-nymph cicada-nymph.32 cicada-nymph.32.exe cicada-nymph.exe &&\
	echo -e "\E[33;1m [ok] clean directory \E[0m"
