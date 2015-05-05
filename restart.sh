#!/usr/bin/sh

make tangle build copy-core-file-user &&\
sudo make install copy-core-file-system &&\
cn
