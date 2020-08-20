#!/bin/bash -e

berks package cookbooks.tar.gz

tar zcvf assimilation.tar.gz cookbooks.tar.gz chef-solo-node.json run.sh solo.rb

scp assimilation.tar.gz root@vsoul.net:/var/www/html/

echo "MD5:"
md5sum assimilation.tar.gz

rm assimilation.tar.gz
rm cookbooks.tar.gz
