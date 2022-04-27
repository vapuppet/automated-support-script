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
puppet access loging
    # Active node count:
puppet query 'nodes[count(certname)]{deactivated is null and expired is null}'
    # Nodes that are not expired:
puppet query 'nodes[count(certname)]{expired is null}'
    # Inactive nodes:
puppet query 'nodes[count(certname)]{ node_state = "inactive"}'
    # Nodes using a cached catalog:
#puppet query 'nodes[count(certname)]{cached_catalog_status = "used"}'
#puppet query 'nodes[count(certname)]{ catalog_timestamp < "YYYY-MM-DDT00:00:00.000Z" }'
#puppet query 'nodes[count(certname)]{ catalog_timestamp < "2022-04-25T00:00:00.000Z" }'


echo Job Complete!
