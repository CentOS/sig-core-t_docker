#!/bin/bash -x
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - Running a command inside CentOS 6 image "

docker run centos:centos6 cat /etc/redhat-release | grep -q 'CentOS'


t_CheckExitStatus $?

