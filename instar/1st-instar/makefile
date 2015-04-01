.ONESHELL:

windows32:
	fasm -m 500000 cicada-nymph.fasm cicada-nymph-32.exe

clean*~:
	rm -f *~ */*~ */*/*~ */*/*/*~ */*/*/*/*~  */*/*/*/*/*~  

clean*.bin:
	rm -f *.bin */*.bin */*/*.bin */*/*/*.bin */*/*/*/*.bin  */*/*/*/*/*.bin

clean:
	make clean*~                                  &&\
	make clean*.bin                               &&\
	echo -e "\E[33;1m [ok] clean directory \E[0m"
