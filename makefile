.ONESHELL:

help:
	@
	echo -e " \E[33;1m                                                           \E[0m "
	echo -e " \E[33;1m   dependencies                                            \E[0m "
	echo -e " \E[33;1m     fasm   to compile                                     \E[0m "
	echo -e " \E[33;1m                                                           \E[0m "
	echo -e " \E[33;1m                                                           \E[0m "
	echo -e " \E[33;1m   Makefile functions                                      \E[0m "
	echo -e " \E[33;1m     build                                                 \E[0m "
	echo -e " \E[33;1m     clean                                                 \E[0m "
	echo -e " \E[33;1m							     \E[0m "
	echo -e " \E[33;1m                                                           \E[0m "
	echo -e " \E[33;1m   please read the Makefile for more informations          \E[0m "
	echo -e " \E[33;1m							     \E[0m "
	echo -e " \E[33;1m   I wish you happy making ^_^                             \E[0m "
	echo -e " \E[33;1m                                                           \E[0m "

build:
	fasm -m 500000 cicada-nymph.fasm 

clean*~:
	rm -f *~ */*~ */*/*~ */*/*/*~ */*/*/*/*~  */*/*/*/*/*~  

clean*.bin:
	rm -f *.bin */*.bin */*/*.bin */*/*/*.bin */*/*/*/*.bin  */*/*/*/*/*.bin

clean:
	make clean*~                                  &&\
	make clean*.bin                               &&\
	echo -e "\E[33;1m [ok] clean directory \E[0m"
