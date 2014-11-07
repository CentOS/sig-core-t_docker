#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - Install docker, some utils and EPEL on CentOS 6"



t_InstallPackage  wget openssh-clients

if [ "$centos_ver" = "6" ] ; then

	t_Log "Enabling EPEL  ..."
    t_InstallPackage epel-release

else
	t_Log "CentOS 7: Docker is included in Extra repo"

fi


t_Log "Setting up docker "

if [ "$centos_ver" = "6"  ] ; then
    t_InstallPackage docker-io
else
    t_InstallPackage docker
fi


t_ServiceControl docker start
