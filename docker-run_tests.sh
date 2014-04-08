#!/bin/bash 
# A script to test the official CentOS docker-images.
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

EPEL6_RELEASE_URL="http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
EPEL6_GPGKEY_URL="https://fedoraproject.org/static/0608B895.txt"

enable_epel() {
    yum -y install wget openssh-clients
    cd /root 
    wget  "$EPEL6_RELEASE_URL"
    rpm --import  "$EPEL6_GPGKEY_URL"
    yum -y localinstall /root/epel-release*.rpm
}

setup_docker() {
    yum -y install docker-io
    service docker start
    chkconfig docker on
}

test_get_centos_img() {
    docker pull centos
}

test_centos_img_runcmd() {
    docker run centos cat /etc/centos-release | grep 'CentOS'
}

run_tests() {
    test_get_centos_img
    test_centos_img_runcmd
}

# Main

enable_epel
setup_docker
run_tests

