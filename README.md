#Setup
------

wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb

sudo dpkg -i puppetlabs-release-precise.deb

sudo apt-get update

sudo apt-get install puppet-common wget curl git

git clone https://github.com/rocky-jaiswal/statusboard-devops.git

cd statusboard-devops

chmod u+x setup.sh

./setup.sh


Add User One
------------
useradd rockyj -s /bin/bash

mkdir /home/rockyj

chown -R rockyj /home/rockyj

passwd rockyj

usermod -aG sudo rockyj


Make torquebox sudo
-------------------

sudo usermod -a -G sudo torquebox
