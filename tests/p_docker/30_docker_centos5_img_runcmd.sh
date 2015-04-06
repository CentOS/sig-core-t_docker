#!/bin/sh
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - Running a command inside CentOS 5 image "

docker run centos:centos5 cat /etc/redhat-release | grep -q 'CentOS'


t_CheckExitStatus $?

