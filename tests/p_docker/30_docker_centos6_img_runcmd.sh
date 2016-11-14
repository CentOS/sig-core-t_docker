#!/bin/sh
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - Running a command inside CentOS 6 image "

t_ExcludeArches "ppc64le"

docker run centos:centos6 cat /etc/redhat-release | grep -q 'CentOS'


t_CheckExitStatus $?
