#!/bin/bash
echo "Copying the github repos"
ansible-playbook git1.yml
echo "#####################################"
echo "Apply the configuration"
cd aviLsc
ansible-playbook -i hostsLocal generateCreds.yml
cd ../vyos
ansible-playbook -i hostsArpLocal vyos.yml
cd ../cs
ansible-playbook -i hostsArpLocal main.yml
cd ../aviBootstrap
ansible-playbook -i hostsArpLocal main.yml
cd ../aviLscCloud
ansible-playbook -i hostsArpLocal main.yml
cd ../aviAlerts
ansible-playbook configureAlerts.yml
cd ..
rm -fr aviBootstrap aviLsc aviLscCloud cs vyos aviAlerts
