#!/bin/bash

# Setup a vagrant infra we can use
# XXX: this largely comes from adhoc SCL's at the moment, need a better solution longer term

# check we are on centos7
# check we are being run as root

yum -y upgrade

cat > /etc/yum.repos.d/vagrant.repo <<- EOM

[jstribny-vagrant1]
name=Copr repo for vagrant1 owned by jstribny
baseurl=https://copr-be.cloud.fedoraproject.org/results/jstribny/vagrant1/epel-7-x86_64/
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/jstribny/vagrant1/pubkey.gpg
enabled=1

[ruby200-copr]
name=ruby200-copr
baseurl=http://copr-be.cloud.fedoraproject.org/results/rhscl/ruby200-el7/epel-7-x86_64/
enabled=1
gpgcheck=0

[ror40-copr]
name=ror40-copr
baseurl=http://copr-be.cloud.fedoraproject.org/results/rhscl/ror40-el7/epel-7-x86_64/
enabled=1
gpgcheck=0

EOM

yum -y install vagrant1 rsync

if [ $? -eq 0 ]; then
  service libvirtd start
  # we likely dont need to run the rest as root
  git clone https://github.com/CentOS/sig-core-t_functional ~/sync
  scl enable vagrant1 ./vagrant_test
  if [ $? -ne 0 ]; then
    echo 'Failed'
    exit 1
  fi
fi
