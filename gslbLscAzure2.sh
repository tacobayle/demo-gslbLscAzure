#!/bin/bash
mkdir creds
cp ../../creds/* creds/

echo "Copying the github repos"
ansible-playbook git2.yml
echo "#####################################"
echo "Apply the configuration"
read -n 1 -s -r -p "Press any key to spin-up the Avi Azure Config."
echo ""
cd Azure
rm -f hostAzurePublicIp
ansible-playbook azureCreate.yml
sleep 2
ansible-playbook -i hostsAzurePublicIp routingSsh.yml
cd ../aviBootstrap
ansible-playbook -i hostsAzurePrivate main.yml
cd ../aviAzure
ansible-playbook main.yml
cd ..
rm -fr creds
rm -fr Azure aviBootstrap aviAzure creds
