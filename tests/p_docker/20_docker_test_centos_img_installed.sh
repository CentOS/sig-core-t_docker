#!/bin/bash -x
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - Checking if CentOS images were installed correctly"

docker images | grep -q 'centos'


t_CheckExitStatus $?

