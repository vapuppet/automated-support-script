#!/bin/bash

#ls
mkdir output
cd output
#1. High Level Overview
echo Customer name:
read name
echo Customer email:
read email
echo Customer name: $name >> output.txt
echo Customer email: $email >> output.txt
puppet --version | tee -a output.txt

#2. Support Script Generation
#
#

#3. PE Server Commands
/opt/puppetlabs/puppet/bin/openssl x509 -in "$(/opt/puppetlabs/bin/puppet config print hostcert)" --enddate --noout | tee -a output.txt
puppet infra status | tee -a output.txt
puppet module list --all | tee -a output.txt

#4. Bolt Taskts
#
#

#5. Hiera File
#
#

#6. PQL Queries
#
#

echo Job Complete!
