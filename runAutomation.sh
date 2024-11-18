#=========================================
# Script Name : your_script_name.sh
# Description : This script will trigger the automation that will setup Vagrant VM (Cluster nodes) and then configure all the nodes for making Kubernetes Cluster
# Author      : Rohit Kansra
# Email       : rohitkansra2@gmail.com
# Date        : 2024-11-15
# Version     : 1.0
#=========================================
# Pre-requisites:
# - Vagrant, VMWARE Fusion, Ansible, Python3 
# - sudo for runnung Vagrant
# - Specify if environment variables or configuration files are required
#   (e.g., PATH must include /usr/local/bin, CONFIG_FILE=/path/to/config)
#=========================================

#!/bin/zsh

#echo "Starting Vagrant Machines..."
#sudo vagrant up
echo "Changing permission of Certificate Files..."
sudo chmod -R 755 /Users/rohitkansra/Documents/Technologies_Learning/K8S_vagrant_ansible_automation/.vagrant/
echo "Configuring Nodes for Kubernetes dependencies..."
ansible-playbook -i ansible_kubernetes_config/inventory.ini ansible_kubernetes_config/kubeadm_setup.yaml  -v
