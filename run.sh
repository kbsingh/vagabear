#!/bin/bash

# Setup a vagrant infra we can use
# XXX: this largely comes from adhoc SCL's at the moment, need a better solution longer term

# check we are on centos7
# check we are being run as root

yum -y upgrade

yum install centos-release-scl

yum -y install sclo-vagrant1-vagrant-libvirt \
               rsync qemu-kvm qemu-kvm-tools \
               qemu-img

if [ $? -eq 0 ]; then
  service libvirtd start
  # we likely dont need to run the rest as root
  git clone https://github.com/CentOS/sig-core-t_functional ~/sync
  cp Vagrantfile ~/sync/
  chmod u+x ./vagrant_test.sh
  scl enable vagrant1 ./vagrant_test.sh
  exit $?
fi
