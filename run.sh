#!/bin/bash

set -e
set -x

# Please run me as root

RECIPE="default"
while :
do
        case "$1" in
                "--cli")
                        # Be verbose.
			RECIPE="cli"
                        ;;
                *)
                        ;;
        esac
        shift || break
done

if ! hash chef-solo;
then
	wget https://packages.chef.io/files/stable/chef/16.4.41/debian/10/chef_16.4.41-1_amd64.deb
	dpkg -i chef_16.4.41-1_amd64.deb
fi

if ! hash berks;
then
	wget https://packages.chef.io/files/stable/chefdk/4.10.0/debian/10/chefdk_4.10.0-1_amd64.deb
	dpkg -i chefdk_4.10.0-1_amd64.deb
fi

# Unpack the cookbooks directory from cookbooks.tar.gz
tar zxvf cookbooks.tar.gz

# Run chef-solo
chef-solo -c solo.rb --override-runlist "recipe[assimilation::$RECIPE]"
