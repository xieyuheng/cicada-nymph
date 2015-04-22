.ONESHELL:

windows32:
	fasm -m 100000 cicada-nymph.fasm

clean*~:
	rm -f *~ */*~ */*/*~ */*/*/*~ */*/*/*/*~  */*/*/*/*/*~  

clean*.exe:
	rm -f *.exe */*.exe */*/*.exe */*/*/*.exe */*/*/*/*.exe  */*/*/*/*/*.exe

clean:
	make clean*~                                  &&\
	make clean*.exe                               &&\
	echo -e "\e[33;1m [ok] clean directory \e[0m"
