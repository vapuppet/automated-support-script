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
puppet access login
    # Active node count:
puppet query 'nodes[count(certname)]{deactivated is null and expired is null}' | tee -a output.txt
    # Nodes that are not expired:
puppet query 'nodes[count(certname)]{expired is null}' | tee -a output.txt
    # Inactive nodes:
puppet query 'nodes[count(certname)]{ node_state = "inactive"}' | tee -a output.txt
    # Nodes using a cached catalog:
puppet query 'nodes[count(certname)]{cached_catalog_status = "used"}' | tee -a output.txt
echo catalog timestamp year YYYY
read year
echo catalog timestamp month MM
read month
echo catalog timestap day DD
read day
puppet query 'nodes[count(certname)]{ catalog_timestamp < "'$year-$month-$day'T00:00:00.000Z" }' | tee -a output.txt

echo Job Complete!
