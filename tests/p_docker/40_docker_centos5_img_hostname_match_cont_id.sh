#!/bin/sh
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - Check if hostname inside CentOS 5 image matches container id"


hostname_output="`docker run centos:centos5 hostname`"

docker ps -a | grep -q "$hostname_output"

t_CheckExitStatus $?

