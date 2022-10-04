#!/bin/bash

set -e
set -x

curl -s -L -o assimilation.tar.gz        https://github.com/batzilo/workstation-assimilation/raw/master/out/assimilation.tar.gz
curl -s -L -o assimilation.tar.gz.sha512 https://github.com/batzilo/workstation-assimilation/raw/master/out/assimilation.tar.gz.sha512
echo "$(cat assimilation.tar.gz.sha512)" | sha512sum --check

tar zxvf assimilation.tar.gz
