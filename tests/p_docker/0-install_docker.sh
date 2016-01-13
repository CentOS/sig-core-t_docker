#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - Install docker, some utils and EPEL on CentOS 6"



t_InstallPackage  wget openssh-clients yum-utils

if [ "$centos_ver" = "6" ] ; then

	t_Log "Enabling EPEL  ..."
    t_InstallPackage epel-release

else
    if [ "$WITH_VIRT7_TESTING" = "1" ]; then
	    t_Log "CentOS 7: Disabling CentOS Extra repo"
        yum-config-manager -q --disable extras > /dev/null

	    t_Log "CentOS 7: Setting up virt7-docker-common-testing repo"
        cat > /etc/yum.repos.d/_virt7-docker-common-candidate.repo <<EOF
[virt7-docker-common-testing]
name=virt7-docker-common-testing
baseurl=http://cbs.centos.org/repos/virt7-docker-common-testing/x86_64/os/
enabled=1
gpgcheck=0
EOF

    else 
	    t_Log "CentOS 7: Docker is included in Extra repo"
    fi
fi


t_Log "Setting up docker "

if [ "$centos_ver" = "6"  ] ; then
    t_InstallPackage docker-io
else
    t_InstallPackage docker
fi

if [ "$WITH_DEBUG" == "1" ] ; then
	t_Log "Enabling debugging ..."
	sed -i "s/^OPTIONS=.*/OPTIONS='--selinux-enabled --debug=true  --log-level=debug'/" /etc/sysconfig/docker
fi

t_ServiceControl docker start
