#!/bin/bash
# A script to test the official CentOS docker-images.
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

EPEL6_RELEASE_URL="http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
EPEL6_GPGKEY_URL="https://fedoraproject.org/static/0608B895.txt"

# A function to test an output of a command 
# arg1: Command to run 
# arg2: Expected output
#
expect_output(){
    if [ -z "$2" ]
    then
        printf "We need two args\n"
        return 98
    fi
    $1 | grep "$2"
    if [ $? -eq 0 ]
    then
        printf "Test PASSED\n"
    else
        printf "Test \'%s\' FAILED: expecting %s\n" $1 $2
    fi
    
}

enable_epel() {
    printf "Installing EPEL and some tools ...\n"
    yum -y install wget openssh-clients
    cd /root 
    wget  "$EPEL6_RELEASE_URL"
    rpm --import  "$EPEL6_GPGKEY_URL"
    yum -y localinstall /root/epel-release*.rpm
}

setup_docker() {
    printf "Setting up docker ...\n"
    yum -y install docker-io
    service docker start
    chkconfig docker on
}

test_get_centos_img() {
    printf "TEST 1: Pulling CentOS image ...\n"
    docker pull centos
}

test_centos_img_installed(){
    printf "TEST 2: Checking if CentOS image was installed correctly ...\n"
    expect_output 'docker images' 'centos'

}

test_centos_img_runcmd() {
    printf "TEST 3: Running a command inside CentOS image ...\n"
    expect_output 'docker run centos cat /etc/centos-release' 'CentOS'
}

run_tests() {
    test_get_centos_img
    test_centos_img_installed
    test_centos_img_runcmd
}

# Main

enable_epel
setup_docker
run_tests

