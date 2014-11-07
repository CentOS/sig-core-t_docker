#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - Install docker, some utils and EPEL on CentOS 6"



t_InstallPackage  wget openssh-clients

if [ "$centos_ver" = "6" ] ; then

	EPEL6_RELEASE_URL="http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
	EPEL6_GPGKEY_URL="https://fedoraproject.org/static/0608B895.txt"

	t_Log "Installing EPEL and some tools ..."
	cd /root 
	wget  "$EPEL6_RELEASE_URL"
	rpm --import  "$EPEL6_GPGKEY_URL"
	yum -y localinstall /root/epel-release*.rpm

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
