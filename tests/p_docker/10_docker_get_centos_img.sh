#!/bin/bash -x
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - Pulling CentOS images"

docker pull centos

t_CheckExitStatus $?

