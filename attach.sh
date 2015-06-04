#!/bin/bash

if [[ $EUID -ne 0  ]]; then
	echo "Not running as root. Going to fail!"
	exit 1
fi


subscription-manager register

subscription-manager subscribe --pool <POOL-ID>			# RHEL 7
subscription-manager subscribe --pool <POOL-ID>			# OpenShift Enterprise v3 Beta
