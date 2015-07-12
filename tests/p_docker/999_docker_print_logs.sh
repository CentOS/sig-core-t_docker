#!/bin/sh
# Author: Athmane Madjoudj <athmane@fedoraproject.org>



t_Log "Running $0 - Printing debug log ..."

if [ "$WITH_DEBUG" == "1" ] ; then
    grep -i 'docker' /var/log/messages
else
    t_Log "Debug option not enabled ..."
fi
