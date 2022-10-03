# To use pushd and popd, make should use bash instead of sh.
SHELL := /bin/bash

.PHONY: all

all:
	berks package cookbooks.tar.gz
	tar zcvf out/assimilation.tar.gz cookbooks.tar.gz run.sh solo.rb
	pushd out && sha512sum assimilation.tar.gz > assimilation.tar.gz.sha512 && popd
	rm cookbooks.tar.gz
