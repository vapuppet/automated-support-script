#!/bin/bash

#color
\e[1;32m  = green

#Create Output Directory
mkdir output
cd output

#1. High Level Overview
echo $green Customer name:
read name
echo $green Customer email:
read email
echo ustomer name: $name >> output.txt
echo Customer email: $email >> output.txt
puppet --version | tee -a output.txt

#2. Support Script Generation
mkdir supportscript
/opt/puppetlabs/bin/puppet enterprise support --dir supportscript

#3. PE Server Commands
/opt/puppetlabs/puppet/bin/openssl x509 -in "$(/opt/puppetlabs/bin/puppet config print hostcert)" --enddate --noout | tee -a output.txt
puppet infra status | tee -a output.txt
puppet module list --all | tee -a output.txt

#4. Bolt Taskts
#
bolt task run ca_extend::check_agent_expiry --targets local://hostname | tee -a output.txt
#bolt task run ca_extend::check_ca_expiry --targets <primary hostname> | tee -a output.txt
/opt/puppetlabs/puppet/bin/openssl x509 -in "$(/opt/puppetlabs/bin/puppet config print hostcert)" --enddate --noout | tee -a output.txt
#

#5. Hiera File
#/etc/puppetlabs/code/environments/production/modules/ntp/hiera.yaml
echo $green Please enter an existing module in your /etc/puppetlabs/code/environments/production/modules/ environment to collect a hiera.yaml file ex ntp
read module
cp /etc/puppetlabs/code/environments/production/modules/$module/hiera.yaml /output/hiera.yaml

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
echo $green catalog timestamp year YYYY
read year
echo $green catalog timestamp month MM
read month
echo $green catalog timestap day DD
read day
puppet query 'nodes[count(certname)]{ catalog_timestamp < "'$year-$month-$day'T00:00:00.000Z" }' | tee -a output.txt

echo $green Job Complete!
