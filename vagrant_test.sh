#!/bin/bash

cd ~/sync/
vagrant init lalatendum/centos7-docker
vagrant up
UpdtPkgs=$(vagrant ssh -c "sudo yum -d0 list updates | wc -l")
echo 'Updates due :' ${UpdtPkgs} 
#if [ $UpdtPkgs -gt 10 ]; then
#    echo 'More than 10 packages due an update!'
#    exit 1
#else
    vagrant ssh -c "cd sync; sudo ./runtests.sh "
    # the $? check here isnt going to work since it will be the ssh exit, not the
    # script exit 
    if [ $? -ne 0 ]; then
      echo 't_functional failed'
      exit 2
    else
      exit 0
    fi
#fi
